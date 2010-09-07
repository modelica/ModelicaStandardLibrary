within ModelicaTest;
package FluidDissipation
  "Test cases for heat transfer and pressure loss correlations"
extends Modelica.Icons.ExamplesPackage;

  package Verifications
    "verification package of heat transfer and pressure loss correlations"
  extends Modelica.Icons.ExamplesPackage;
    package HeatTransfer "Verification package for heat transfer functions"
    extends Modelica.Icons.ExamplesPackage;
      package Channel "Verification package for channel correlations"
      extends Modelica.Icons.ExamplesPackage;
        model kc_evenGapLaminar "Verification of function kc_evenGapLaminar"

          parameter Integer n=size(cp, 1);
          parameter Modelica.SIunits.Diameter d_hyd=2*s;

          Real abscissa[n]={(length/d_hyd/(max(Re[i], 1e-3)*Pr[i]))^0.5 for i in 1:n};
          Modelica.SIunits.Length length=L;
          Modelica.SIunits.Length dimlesslength(start=1e-2);
          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/(lambda[i]) for i in 
                  1:n};
          Modelica.SIunits.ReynoldsNumber Re[n]={rho[i]*velocity[i]*d_hyd/eta[i] 
              for i in 1:n};
          Modelica.SIunits.Velocity velocity[n]={m_flow[i]/(rho[i]*h*s) for i in 
                  1:n};

          //even gap variables
          parameter Modelica.SIunits.Length h=0.1
            "Height of cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length s=0.05
            "Distance between parallel plates in cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length L=1 "Overflowed length of gap" 
            annotation (Dialog(group="Geometry"));

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
            m_flow_IN_con_1[n](
            each final target=1,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-100,20},{-80,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
            m_flow_IN_con_2[n](
            each final target=2,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-50,20},{-30,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
            m_flow_IN_con_3[n](
            each final target=3,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{10,20},{30,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
            m_flow_IN_var_3[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
            m_flow_IN_con_4[n](
            each final target=4,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{60,20},{80,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
            m_flow_IN_var_4[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{80,20},{100,40}})));

          //output variables
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_3[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_4[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

        protected
          Modelica.SIunits.MassFlowRate m_flow[n]={0.5*h*lambda[i]*length/(cp[i]
              *d_hyd*dimlesslength^2) for i in 1:n};
        equation
          der(dimlesslength) = 1 - 0.01;

          //heat transfer calculation

          for i in 1:n loop
            (,,,Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_3[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar(
              m_flow_IN_con_3[i], m_flow_IN_var_3[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_4[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar(
              m_flow_IN_con_4[i], m_flow_IN_var_4[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/channel/kc_evenGapLaminar.mos"
                "Verification of kc_evenGapLaminar"),Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of EVEN GAP for LAMINAR flow regime"),Text(
                  extent={{-160,11},{40,6}},
                  lineColor={0,0,255},
                  textString="Target == 1 "),Text(
                  extent={{-120,11},{80,6}},
                  lineColor={0,0,255},
                  textString="Target == 2"),Text(
                  extent={{-82,11},{118,6}},
                  lineColor={0,0,255},
                  textString="Target == 3"),Text(
                  extent={{-40,11},{160,6}},
                  lineColor={0,0,255},
                  textString="Target == 4"),Text(
                  extent={{-100,-100},{100,40}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 1 >>>>>> DEVELOPED fluid flow AND heat transfer at ONE side"),
                  Text(
                  extent={{-100,-100},{100,30}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 2 >>>> DEVELOPED fluid flow AND heat transfer at BOTH sides"),
                  Text(
                  extent={{-100,-100},{100,20}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 3 >>>> UNDEVELOPED fluid flow AND heat transfer at ONE side"),
                  Text(
                  extent={{-100,-100},{100,10}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 4 >> UNDEVELOPED fluid flow AND heat transfer at BOTH sides")}),
            experiment(StopTime=1.01));
        end kc_evenGapLaminar;

        model kc_evenGapLaminar_KC
          "Verification of function kc_evenGapLaminar_KC"

          parameter Integer n=size(cp, 1);
          parameter Modelica.SIunits.Diameter d_hyd=2*s;

          //even gap variables
          parameter Modelica.SIunits.Length h=0.1
            "Height of cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length s=0.05
            "Distance between parallel plates in cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length L=1 "Overflowed length of gap" 
            annotation (Dialog(group="Geometry"));

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow_1[n](start=ones(n)*1e-3);
          Modelica.SIunits.MassFlowRate m_flow_2[n](start=ones(n)*1e-3);
          Modelica.SIunits.MassFlowRate m_flow_3[n](start=ones(n)*1e-3);
          Modelica.SIunits.MassFlowRate m_flow_4[n](start=ones(n)*1e-3);
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_1[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_2[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_3[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_4[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
            m_flow_IN_con_1[n](
            each final target=1,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-100,20},{-80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow_1,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
            m_flow_IN_con_2[n](
            each final target=2,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-50,20},{-30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow_2,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
            m_flow_IN_con_3[n](
            each final target=3,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{10,20},{30,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
            m_flow_IN_var_3[n](
            m_flow=m_flow_3,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
            m_flow_IN_con_4[n](
            each final target=4,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{60,20},{80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
            m_flow_IN_var_4[n](
            m_flow=m_flow_4,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{80,20},{100,40}})));

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e4 - 10,
            offset=1.1e1) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{50,-80},{70,-60}})));

          Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_3[n]={abs(m_flow_3[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_4[n]={abs(m_flow_4[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};

        equation
          //heat transfer calculation
          kc_OUT_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};

          kc_OUT_2 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(
            m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};

          kc_OUT_3 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(
            m_flow_IN_con_3[i], m_flow_IN_var_3[i]) for i in 1:n};

          kc_OUT_4 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(
            m_flow_IN_con_4[i], m_flow_IN_var_4[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/channel/kc_evenGapLaminar_KC.mos"
                "Verification of kc_evenGapLaminar_KC"),Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of EVEN GAP for LAMINAR flow regime (inlining)"),
                  Text(
                  extent={{-160,11},{40,6}},
                  lineColor={0,0,255},
                  textString="Target == 1 "),Text(
                  extent={{-120,11},{80,6}},
                  lineColor={0,0,255},
                  textString="Target == 2"),Text(
                  extent={{-82,11},{118,6}},
                  lineColor={0,0,255},
                  textString="Target == 3"),Text(
                  extent={{-40,11},{160,6}},
                  lineColor={0,0,255},
                  textString="Target == 4"),Text(
                  extent={{-100,-100},{100,40}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 1 >>>>>> DEVELOPED fluid flow AND heat transfer at ONE side"),
                  Text(
                  extent={{-100,-100},{100,30}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 2 >>>> DEVELOPED fluid flow AND heat transfer at BOTH sides"),
                  Text(
                  extent={{-100,-100},{100,20}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 3 >>>> UNDEVELOPED fluid flow AND heat transfer at ONE side"),
                  Text(
                  extent={{-100,-100},{100,10}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 4 >> UNDEVELOPED fluid flow AND heat transfer at BOTH sides"),
                  Text(
                  extent={{-98,-26},{102,-1}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(StopTime=1.01));
        end kc_evenGapLaminar_KC;

        model kc_evenGapOverall "Verification of function kc_evenGapOverall"

          parameter Integer n=size(cp, 1);
          parameter Modelica.SIunits.Diameter d_hyd=2*s;

          //even gap variables
          parameter Modelica.SIunits.Length h=0.1
            "Height of cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length s=0.05
            "Distance between parallel plates in cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length L=1 "Overflowed length of gap" 
            annotation (Dialog(group="Geometry"));

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input VARIABLES
          //create identical Reynolds number for different fluid properties >> adjustment of  mass flow rate
          Modelica.SIunits.MassFlowRate m_flow[:]={mflow_test*eta[1]/eta[3],
              mflow_test*eta[2]/eta[3],mflow_test} "mass flow rate" 
                                           annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
            m_flow_IN_con_1[n](
            each final target=1,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-100,20},{-80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
            m_flow_IN_con_2[n](
            each final target=2,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-50,20},{-30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
            m_flow_IN_con_3[n](
            each final target=3,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{10,20},{30,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
            m_flow_IN_var_3[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
            m_flow_IN_con_4[n](
            each final target=4,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{60,20},{80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
            m_flow_IN_var_4[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{80,20},{100,40}})));

          //output variables
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_3[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_4[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

          Modelica.SIunits.ReynoldsNumber Re_1[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.ReynoldsNumber Re_2[n] "Reynolds number" 
            annotation (Dialog(group="Output"));

        protected
          Real mflow_test=input_mflow_0.y;
        public
          Modelica.Blocks.Sources.Ramp input_mflow_0(
            offset=0,
            duration=1,
            height=1e4) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(amplitude=100, freqHz=1) 
            annotation (extent=[-80, -80; -60, -60], Placement(transformation(extent={{
                    -40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            outMax=100,
            riseTime=1e-1,
            riseTimeConst=1e-1) annotation (extent=[-40, -80; -20, -60], Placement(
                transformation(extent={{0,-80},{20,-60}})));

        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,Re_1[i],Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,Re_2[i],Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_3[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall(
              m_flow_IN_con_3[i], m_flow_IN_var_3[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_4[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall(
              m_flow_IN_con_4[i], m_flow_IN_var_4[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/channel/kc_evenGapOverall.mos"
                "Verification of kc_evenGapOverall"),Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of EVEN GAP for OVERALL flow regime"),Text(
                  extent={{-160,11},{40,6}},
                  lineColor={0,0,255},
                  textString="Target == 1 "),Text(
                  extent={{-120,11},{80,6}},
                  lineColor={0,0,255},
                  textString="Target == 2"),Text(
                  extent={{-82,11},{118,6}},
                  lineColor={0,0,255},
                  textString="Target == 3"),Text(
                  extent={{-40,11},{160,6}},
                  lineColor={0,0,255},
                  textString="Target == 4"),Text(
                  extent={{-100,-100},{100,40}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 1 >>>>>> DEVELOPED fluid flow AND heat transfer at ONE side"),
                  Text(
                  extent={{-100,-100},{100,30}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 2 >>>> DEVELOPED fluid flow AND heat transfer at BOTH sides"),
                  Text(
                  extent={{-100,-100},{100,20}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 3 >>>> UNDEVELOPED fluid flow AND heat transfer at ONE side"),
                  Text(
                  extent={{-100,-100},{100,10}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 4 >> UNDEVELOPED fluid flow AND heat transfer at BOTH sides")}),
            experiment(StopTime=1.01));
        end kc_evenGapOverall;

        model kc_evenGapOverall_KC
          "Verification of function kc_evenGapOverall_KC"

          parameter Integer n=size(cp, 1);
          parameter Modelica.SIunits.Diameter d_hyd=2*s;

          //even gap variables
          parameter Modelica.SIunits.Length h=0.1
            "Height of cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length s=0.05
            "Distance between parallel plates in cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length L=1 "Overflowed length of gap" 
            annotation (Dialog(group="Geometry"));

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //target variables
          //here: mass flow rate as input for normal calculation
          /*SI.MassFlowRate mflow_test=input_mflow_0.y;
  SI.MassFlowRate m_flow[:]={mflow_test*eta[1]/eta[3],mflow_test*eta[2]/eta[3],
      mflow_test} "mass flow rate" annotation (Dialog(group="Input"));
  SI.NusseltNumber Nu[n]={kc[i]*d_hyd/lambda[i] for i in 1:n};*/

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow_1[n](start=ones(n)*1e-3);
          Modelica.SIunits.MassFlowRate m_flow_2[n](start=ones(n)*1e-3);
          Modelica.SIunits.MassFlowRate m_flow_3[n](start=ones(n)*1e-3);
          Modelica.SIunits.MassFlowRate m_flow_4[n](start=ones(n)*1e-3);
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_1[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_2[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_3[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_4[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
            m_flow_IN_con_1[n](
            each final target=1,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-100,20},{-80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow_1,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
            m_flow_IN_con_2[n](
            each final target=2,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-50,20},{-30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow_2,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
            m_flow_IN_con_3[n](
            each final target=3,
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{10,20},{30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
            m_flow_IN_var_3[n](
            m_flow=m_flow_3,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
            m_flow_IN_con_4[n](
            each final target=4,
            each h=0.6,
            each s=0.5,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{60,20},{80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
            m_flow_IN_var_4[n](
            m_flow=m_flow_4,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{80,20},{100,40}})));

          Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_3[n]={abs(m_flow_3[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_4[n]={abs(m_flow_4[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};

          /*Modelica.Blocks.Sources.Ramp input_mflow(
    duration=1000,
    height=1000,
    offset=0) annotation (extent=[-80, -80; -60, -60], Placement(transformation(
          extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.Sine input_mflow_1(amplitude=100, freqHz=1/100)
    annotation (extent=[-80, -80; -60, -60], Placement(transformation(extent={{
            -40,-80},{-20,-60}})));
  Modelica.Blocks.Sources.Exponentials input_mflow_2(
    outMax=100,
    riseTime=1e-1,
    riseTimeConst=1e-1) annotation (extent=[-40, -80; -20, -60], Placement(
        transformation(extent={{0,-80},{20,-60}})));*/

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e4 - 10,
            offset=1.1e1) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{50,-80},{70,-60}})));
        equation
          //heat transfer calculation
          kc_OUT_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};

          kc_OUT_2 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC(
            m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};

          kc_OUT_3 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC(
            m_flow_IN_con_3[i], m_flow_IN_var_3[i]) for i in 1:n};

          kc_OUT_4 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC(
            m_flow_IN_con_4[i], m_flow_IN_var_4[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/channel/kc_evenGapOverall_KC.mos"
                "Verification of kc_evenGapOverall_KC"),Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of EVEN GAP for OVERALL flow regime (inlining)"),
                  Text(
                  extent={{-160,11},{40,6}},
                  lineColor={0,0,255},
                  textString="Target == 1 "),Text(
                  extent={{-120,11},{80,6}},
                  lineColor={0,0,255},
                  textString="Target == 2"),Text(
                  extent={{-82,11},{118,6}},
                  lineColor={0,0,255},
                  textString="Target == 3"),Text(
                  extent={{-40,11},{160,6}},
                  lineColor={0,0,255},
                  textString="Target == 4"),Text(
                  extent={{-100,-100},{100,40}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 1 >>>>>> DEVELOPED fluid flow AND heat transfer at ONE side"),
                  Text(
                  extent={{-102,-100},{98,30}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 2 >>>> DEVELOPED fluid flow AND heat transfer at BOTH sides"),
                  Text(
                  extent={{-100,-100},{100,20}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 3 >>>> UNDEVELOPED fluid flow AND heat transfer at ONE side"),
                  Text(
                  extent={{-100,-100},{100,10}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 4 >> UNDEVELOPED fluid flow AND heat transfer at BOTH sides"),
                  Text(
                  extent={{-98,-30},{102,-5}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(StopTime=1.01));
        end kc_evenGapOverall_KC;

        model kc_evenGapTurbulent
          "Verification of function kc_evenGapTurbulent"

          parameter Integer n=size(cp, 1);
          parameter Modelica.SIunits.Diameter d_hyd=2*s;

          Modelica.SIunits.Velocity velocity[n]={m_flow[i]/(rho[i]*h*s) for i in 
                  1:n};

          //even gap variables
          parameter Modelica.SIunits.Length h=0.1
            "Height of cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length s=0.05
            "Distance between parallel plates in cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length L=1 "Overflowed length of gap" 
            annotation (Dialog(group="Geometry"));

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input VARIABLES
          //create identical Reynolds number for different fluid properties >> adjustment of  mass flow rate
          Modelica.SIunits.MassFlowRate m_flow[:]={mflow_test*eta[1]/eta[3],
              mflow_test*eta[2]/eta[3],mflow_test} "mass flow rate" 
                                           annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_con
            m_flow_IN_con_2[n](
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-20,20},{0,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{0,20},{20,40}})));

          //output variables
          Modelica.SIunits.ReynoldsNumber Re_2[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

        protected
          Real mflow_test=input_mflow_0.y;
        public
          Modelica.Blocks.Sources.Ramp input_mflow_0(
            offset=0,
            duration=1,
            height=1e4) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(amplitude=1e4, freqHz=1) 
            annotation (extent=[-80, -80; -60, -60], Placement(transformation(extent={{
                    -40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            riseTime=1e-1,
            riseTimeConst=1e-1,
            outMax=1e4) annotation (extent=[-40, -80; -20, -60], Placement(
                transformation(extent={{0,-80},{20,-60}})));

        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,Re_2[i],Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/channel/kc_evenGapTurbulent.mos"
                "Verification of kc_evenGapTurbulent"),Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-102,11},{98,6}},
                  lineColor={0,0,255},
                  textString="Target == 2"),Text(
                  extent={{-100,-90},{100,20}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 2 >> DEVELOPED fluid flow AND heat transfer at BOTH sides"),
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of EVEN GAP for TURBULENT flow regime")}),
            experiment(StopTime=1.01));
        end kc_evenGapTurbulent;

        model kc_evenGapTurbulent_KC
          "Verification of function kc_evenGapTurbulent_KC"

          parameter Integer n=size(cp, 1);
          parameter Modelica.SIunits.Diameter d_hyd=2*s;

          Modelica.SIunits.Velocity velocity[n]={m_flow[i]/(rho[i]*h*s) for i in 
                  1:n};

          //even gap variables
          parameter Modelica.SIunits.Length h=0.1
            "Height of cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length s=0.05
            "Distance between parallel plates in cross sectional area" 
            annotation (Dialog(group="Geometry"));
          parameter Modelica.SIunits.Length L=1 "Overflowed length of gap" 
            annotation (Dialog(group="Geometry"));

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21}
            "Density of fluid";

          //target variables
          //here: mass flow rate as input for normal calculation
          /*SI.MassFlowRate mflow_test=input_mflow_0.y;
  SI.MassFlowRate m_flow[:]={mflow_test*eta[1]/eta[3],mflow_test*eta[2]/eta[3],
      mflow_test} "mass flow rate" annotation (Dialog(group="Input"));
   SI.NusseltNumber Nu[n]={kc[i]*d_hyd/lambda[i] for i in 1:n};*/

          //here: Nusselt number as input for reverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow[n](start=ones(n)*1e-1);
          Modelica.SIunits.CoefficientOfHeatTransfer kc_OUT_1[n]={Nu[i]*lambda[
              i]/d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_con
            m_flow_IN_con_1[n](
            each h=h,
            each s=s,
            each L=L) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-20,20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{0,20},{20,40}})));

          Modelica.SIunits.ReynoldsNumber Re[n]={abs(m_flow[i])*d_hyd/(eta[i]*
              Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            offset=600,
            height=2e3 - 600) 
                       annotation (extent=[-80, -80; -60, -60],Placement(transformation(
                  extent={{52,-78},{72,-58}})));
        equation
          //heat transfer calculation
          kc_OUT_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/channel/kc_evenGapTurbulent_KC.mos"
                "Verification of kc_evenGapTurbulent_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-102,11},{98,6}},
                  lineColor={0,0,255},
                  textString="Target == 2"),Text(
                  extent={{-100,-90},{100,20}},
                  lineColor={0,0,255},
                  textString=
                    "Target == 2 >> DEVELOPED fluid flow AND heat transfer at BOTH sides"),
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of EVEN GAP for TURBULENT flow regime (inlining)"),
                  Text(
                  extent={{-98,-30},{102,-5}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(StopTime=1.01));
        end kc_evenGapTurbulent_KC;
      end Channel;

      package General "Verification package for general correlations"
      extends Modelica.Icons.ExamplesPackage;
        model kc_approxForcedConvection
          "Verification of function kc_approxForcedConvection"
          parameter Integer n=size(cp, 1);

          //generic variables
          parameter Modelica.SIunits.Area A_cross=Modelica.Constants.pi*0.1^2/4
            "Cross sectional area";
          parameter Modelica.SIunits.Length perimeter=Modelica.Constants.pi*0.1
            "Wetted perimeter";
          //parameter SI.Diameter d_hyd=4*A_cross/perimeter "Hydraulic diameter";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con
            m_flow_IN_con_1[n](
            each final target=1,
            each A_cross=A_cross,
            each perimeter=perimeter) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con
            m_flow_IN_con_2[n](
            each final target=2,
            each A_cross=A_cross,
            each perimeter=perimeter) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-20,20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            eta_wall=eta) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con
            m_flow_IN_con_3[n](
            each final target=3,
            each A_cross=A_cross,
            each perimeter=perimeter) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var
            m_flow_IN_var_3[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{60,20},{80,40}})));

          //output variables
          Modelica.SIunits.ReynoldsNumber Re_1[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_3[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
        public
          Modelica.Blocks.Sources.Ramp input_mflow_0(
            duration=1,
            offset=0,
            height=1e4) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(amplitude=1, freqHz=1) annotation (
             extent=[-80, -80; -60, -60], Placement(transformation(extent={{-40,-80},{-20,
                    -60}})));
          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            riseTime=1e-1,
            riseTimeConst=1e-1,
            outMax=1) annotation (extent=[-40, -80; -20, -60], Placement(transformation(
                  extent={{0,-80},{20,-60}})));

        protected
          Modelica.SIunits.MassFlowRate m_flow[n]={input_mflow_0.y*eta[1]/eta[3],
              input_mflow_0.y*eta[2]/eta[3],input_mflow_0.y} "Mass flow rate";
        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,Re_1[i],Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_3[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection(
              m_flow_IN_con_3[i], m_flow_IN_var_3[i]);
          end for;
          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/general/kc_approxForcedConvection.mos"
                "Verification of kc_approxForcedConvection"),Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-92,12},{-32,6}},
                  lineColor={0,0,255},
                  textString="Target == 1 "),Text(
                  extent={{-34,12},{28,6}},
                  lineColor={0,0,255},
                  textString="Target == 2"),Text(
                  extent={{34,12},{80,6}},
                  lineColor={0,0,255},
                  textString="Target == 3"),Text(
                  extent={{-102,50},{98,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of GENERIC calculation for forced convection for TURBULENT flow regime")}),
            experiment(StopTime=1.01));
        end kc_approxForcedConvection;

        model kc_approxForcedConvection_KC
          "Verification of function kc_approxForcedConvection_KC"
           parameter Integer n=size(cp, 1);

           //generic variables
           parameter Modelica.SIunits.Area A_cross=Modelica.Constants.pi*0.1^2/4
            "Cross sectional area";
           parameter Modelica.SIunits.Length perimeter=Modelica.Constants.pi*0.1
            "Wetted perimeter";
           //parameter SI.Diameter d_hyd=4*A_cross/perimeter "Hydraulic diameter";

           //fluid property variables
           parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
             :]={1007,4189}
            "Specific heat capacity at constant pressure of fluid";
           parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
               1001.6e-6} "Dynamic viscosity of fluid";
           parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
               598.5e-3} "Thermal conductivity of fluid";
           parameter Modelica.SIunits.Density rho[:]={1.188,998.21}
            "Density of fluid";

           //here: Nusselt number as input for inverse calculation
           Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
           Modelica.SIunits.MassFlowRate m_flow_1[n](start=ones(n)*1e-1);
           Modelica.SIunits.MassFlowRate m_flow_2[n](start=ones(n)*1e-1);
           Modelica.SIunits.MassFlowRate m_flow_3[n](start=ones(n)*1e-1);

           Modelica.SIunits.CoefficientOfHeatTransfer kc_1[n]={Nu[i]*lambda[i]/
               perimeter for i in 1:n};
           Modelica.SIunits.CoefficientOfHeatTransfer kc_2[n]={Nu[i]*lambda[i]/
               perimeter for i in 1:n};
           Modelica.SIunits.CoefficientOfHeatTransfer kc_3[n]={Nu[i]*lambda[i]/
               perimeter for i in 1:n};

           //input record
           Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con
            m_flow_IN_con_1[ n](
             each final target=1,
             each A_cross=A_cross,
             each perimeter=perimeter) annotation (extent=[-10, 20; 10, 40], Placement(
                 transformation(extent={{-80,20},{-60,40}})));

           Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var
            m_flow_IN_var_1[ n](
             m_flow=m_flow_1,
             cp=cp,
             eta=eta,
             lambda=lambda,
             rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                   extent={{-60,20},{-40,40}})));

           Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con
            m_flow_IN_con_2[ n](
             each final target=2,
             each A_cross=A_cross,
             each perimeter=perimeter) annotation (extent=[-10, 20; 10, 40], Placement(
                 transformation(extent={{-20,20},{0,40}})));

           Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var
            m_flow_IN_var_2[ n](
             m_flow=m_flow_2,
             cp=cp,
             eta=eta,
             lambda=lambda,
             rho=rho,
             eta_wall=eta) annotation (extent=[-10, 20; 10, 40], Placement(
                 transformation(extent={{0,20},{20,40}})));

           Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con
            m_flow_IN_con_3[ n](
             each final target=3,
             each A_cross=A_cross,
             each perimeter=perimeter) annotation (extent=[-10, 20; 10, 40], Placement(
                 transformation(extent={{40,20},{60,40}})));

           Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var
            m_flow_IN_var_3[ n](
             m_flow=m_flow_3,
             cp=cp,
             eta=eta,
             lambda=lambda,
             rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                   extent={{60,20},{80,40}})));

           Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*(perimeter/
               Modelica.Constants.pi)/(eta[i]*A_cross) for i in 1:n};
           Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*(perimeter/
               Modelica.Constants.pi)/(eta[i]*A_cross) for i in 1:n};
           Modelica.SIunits.ReynoldsNumber Re_3[n]={abs(m_flow_3[i])*(perimeter/
               Modelica.Constants.pi)/(eta[i]*A_cross) for i in 1:n};

        public
           Modelica.Blocks.Sources.Ramp input_Nu(
             startTime=0,
             duration=1,
            offset=1e2,
            height=3.5e3) annotation (extent=[-80, -80; -60, -60], Placement(
                 transformation(extent={{52,-80},{72,-60}})));
        equation
           //heat transfer calculation
           kc_1 = {
             Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC(
             m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};
           kc_2 = {
             Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC(
             m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};
           kc_3 = {
             Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC(
             m_flow_IN_con_3[i], m_flow_IN_var_3[i]) for i in 1:n};

           annotation (Commands(file=
                   "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/general/kc_approxForcedConvection_KC.mos"
                "Verification of kc_approxForcedConvection_KC"), Diagram(
                 coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}),
                 graphics={Text(
                   extent={{-92,12},{-32,6}},
                   lineColor={0,0,255},
                   textString="Target == 1 "),Text(
                   extent={{-34,12},{28,6}},
                   lineColor={0,0,255},
                   textString="Target == 2"),Text(
                   extent={{34,12},{80,6}},
                   lineColor={0,0,255},
                   textString="Target == 3"),Text(
                   extent={{-102,50},{98,75}},
                   lineColor={0,0,255},
                   textString=
                     "Heat transfer of GENERIC calculation for forced convection for TURBULENT flow regime (inlining)")}),
             experiment(StopTime=1.01));
        end kc_approxForcedConvection_KC;
      end General;

      package HeatExchanger
        "Verification package for heat exchanger correlations"
      extends Modelica.Icons.ExamplesPackage;

        model kc_flatTube "Verification of function kc_flatTube"

          parameter Integer n=2 "Number of various fin geometries";

          //heat exchanger variables
          parameter Modelica.SIunits.Area A_fr=1 "Frontal area";

          //heat exchanger variables geometry no.1
          parameter Modelica.SIunits.Length D_m_1=0.005
            "Major tube diameter for flat tube";
          parameter Modelica.SIunits.Length F_l_1=0.019 "Fin length";
          parameter Modelica.SIunits.Length F_p_1=0.0018
            "Fin pitch, fin spacing + fin thickness";
          parameter Modelica.SIunits.Length L_l_1=0.01607 "Louver length";
          parameter Modelica.SIunits.Length L_p_1=0.001534 "Louver pitch";
          parameter Modelica.SIunits.Length T_d_1=0.026 "Tube depth";
          parameter Modelica.SIunits.Length T_p_1=0.0197 "Tube pitch";

          parameter Modelica.SIunits.Length delta_f_1=0.0001 "fin thickness";
          parameter Modelica.SIunits.Angle Phi_1=28*Modelica.Constants.pi/180
            "Louver angle";

          //heat exchanger variables geometry no.2
          parameter Modelica.SIunits.Length D_h_2=0.002383 "Hydraulic diameter";
          parameter Modelica.SIunits.Length D_m_2=0.002
            "Major tube diameter for flat tube";
          parameter Real alpha_2=0.244
            "Lateral fin spacing (s) / free flow height (h)";
          parameter Real gamma_2=0.067
            "Fin thickness (t) / lateral fin spacing (s)";
          parameter Real delta_2=0.032 "Fin thickness (t) / Fin length (l)";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp=
              1007 "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta=18.24e-6
            "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda=25.69e-3
            "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho=1.188 "Density of fluid";

          //input VARIABLES
          Modelica.SIunits.ReynoldsNumber Re=input_Re.y "Reynolds number" 
            annotation (Dialog(group="Input"));

          //input record

          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con
            m_flow_IN_con_1(
            geometry=1,
            A_fr=A_fr,
            D_m=D_m_1,
            F_l=F_l_1,
            F_p=F_p_1,
            L_l=L_l_1,
            L_p=L_p_1,
            T_d=T_d_1,
            T_p=T_p_1,
            delta_f=delta_f_1,
            Phi=Phi_1) 
            annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var
            m_flow_IN_var_1(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[1]) 
            annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con
            m_flow_IN_con_2(
            geometry=2,
            A_fr=A_fr,
            D_h=D_h_2,
            alpha=alpha_2,
            gamma=gamma_2,
            delta=delta_2,
            D_m=D_m_2) annotation (Placement(transformation(extent={{20,-20},{40,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var
            m_flow_IN_var_2(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[2]) 
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));

          //output variables
          Modelica.SIunits.MassFlowRate m_flow[n] "Mass flow rate" 
                                                     annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu[n] "Nusselt number" 
                                                  annotation (Dialog(group="Output"));

        public
          Modelica.Blocks.Sources.Ramp input_Re(
            duration=1,
            startTime=0,
            height=10000,
            offset=100) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));

        equation
          //heat transfer calculation
          (,,Re,Nu[1],) =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube(
            m_flow_IN_con_1, m_flow_IN_var_1);

          (,,Re,Nu[2],) =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube(
            m_flow_IN_con_2, m_flow_IN_var_2);

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/heatExchanger/kc_flatTube.mos"
                "Verification of kc_flatTube"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                      "Heat transfer of heat exchangers with flat tubes and various fin geometries"),
                Text(
                  extent={{-58,-22},{-22,-30}},
                  lineColor={0,0,255},
                  textString="Flat tube and louver fin"),
                Text(
                  extent={{22,-22},{58,-30}},
                  lineColor={0,0,255},
                  textString="Flat tube and slit fin")}),
            experiment(StopTime=1.01));
        end kc_flatTube;

        model kc_flatTube_KC "Verification of function kc_flatTube_KC"
          parameter Integer n=2 "Number of various fin geometries";

          //heat exchanger variables
          parameter Modelica.SIunits.Area A_fr=1 "Frontal area";

          //heat exchanger variables geometry no.1
          parameter Modelica.SIunits.Length D_m_1=0.005
            "Major tube diameter for flat tube";
          parameter Modelica.SIunits.Length F_l_1=0.019 "Fin length";
          parameter Modelica.SIunits.Length F_p_1=0.0018
            "Fin pitch, fin spacing + fin thickness";
          parameter Modelica.SIunits.Length L_l_1=0.01607 "Louver length";
          parameter Modelica.SIunits.Length L_p_1=0.001534 "Louver pitch";
          parameter Modelica.SIunits.Length T_d_1=0.026 "Tube depth";
          parameter Modelica.SIunits.Length T_p_1=0.0197 "Tube pitch";

          parameter Modelica.SIunits.Length delta_f_1=0.0001 "fin thickness";
          parameter Modelica.SIunits.Angle Phi_1=28*Modelica.Constants.pi/180
            "louver angle";

          //heat exchanger variables geometry no.2
          parameter Modelica.SIunits.Length D_h_2=0.002383 "Hydraulic diameter";
          parameter Modelica.SIunits.Length D_m_2=0.002
            "Major tube diameter for flat tube";
          parameter Real alpha_2=0.244
            "Lateral fin spacing (s) / free flow height (h)";
          parameter Real gamma_2=0.067
            "Fin thickness (t) / lateral fin spacing (s)";
          parameter Real delta_2=0.032 "Fin thickness (t) / Fin length (l)";

          Modelica.SIunits.Length h_2=D_h_2*(1 + alpha_2)/(2*alpha_2)
            "Free flow height";
          Modelica.SIunits.Length l_2=t_2/delta_2 "Fin length";
          Modelica.SIunits.Length s_2=h_2*alpha_2
            "Lateral fin spacing (free flow width)";
          Modelica.SIunits.Length t_2=s_2*gamma_2 "Fin thickness";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp=
              1007 "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta=18.24e-6
            "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda=25.69e-3
            "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho=1.188 "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu=input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow[n](start=ones(n)*1e-6);

          Modelica.SIunits.CoefficientOfHeatTransfer kc_1=Nu*lambda/L_p_1;
          Modelica.SIunits.CoefficientOfHeatTransfer kc_2=Nu*lambda/D_h_2;

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con
            m_flow_IN_con_1(
            geometry=1,
            A_fr=A_fr,
            D_m=D_m_1,
            F_l=F_l_1,
            F_p=F_p_1,
            L_l=L_l_1,
            L_p=L_p_1,
            T_d=T_d_1,
            T_p=T_p_1,
            delta_f=delta_f_1,
            Phi=Phi_1) 
            annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var
            m_flow_IN_var_1(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[1]) 
            annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con
            m_flow_IN_con_2(
            geometry=2,
            A_fr=A_fr,
            D_h=D_h_2,
            alpha=alpha_2,
            gamma=gamma_2,
            delta=delta_2,
            D_m=D_m_2) annotation (Placement(transformation(extent={{20,-20},{40,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var
            m_flow_IN_var_2(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[2]) 
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));

          Modelica.SIunits.ReynoldsNumber Re_1=abs(m_flow[1])*L_p_1/(eta*A_fr*(
              (F_l_1 - delta_f_1)*(F_p_1 - delta_f_1)/((F_l_1 + D_m_1)*F_p_1)));
          Modelica.SIunits.ReynoldsNumber Re_2=abs(m_flow[2])*D_h_2/(eta*A_fr*(
              h_2*s_2/((h_2 + t_2 + D_m_2)*(s_2 + t_2))));

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e3,
            offset=1) annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{50,-80},{70,-60}})));
        equation
          //heat transfer calculation
          kc_1 =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC(
            m_flow_IN_con_1, m_flow_IN_var_1);
          kc_2 =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC(
            m_flow_IN_con_2, m_flow_IN_var_2);

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/heatExchanger/kc_flatTube_KC.mos"
                "Verification of kc_flatTube_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                      "Heat transfer of heat exchangers with flat tubes and various fin geometries (inlining)"),
                Text(
                  extent={{-58,-22},{-22,-30}},
                  lineColor={0,0,255},
                  textString="Flat tube and louver fin"),
                Text(
                  extent={{22,-22},{58,-30}},
                  lineColor={0,0,255},
                  textString="Flat tube and slit fin")}),
            experiment(StopTime=1.01));
        end kc_flatTube_KC;

        model kc_roundTube "Verification of function kc_roundTube"

          parameter Integer n=4 "Number of various fin geometries";

          //heat exchanger variables
          parameter Modelica.SIunits.Area A_fr=1 "Frontal area";
          parameter Modelica.SIunits.Length delta_f=0.0001 "fin thickness";

          //heat exchanger variables geometry no.1
          parameter Modelica.SIunits.Length D_c_1=0.00752 "Fin collar diameter";
          parameter Modelica.SIunits.Length F_p_1=0.00122
            "Fin pitch, fin spacing + fin thickness";
          parameter Modelica.SIunits.Length P_l_1=0.0127
            "Longitudinal tube pitch";
          parameter Modelica.SIunits.Length P_t_1=0.021 "Transverse tube pitch";
          parameter Integer N_1=2 "Number of tube rows";

          //heat exchanger variables geometry no.2
          parameter Modelica.SIunits.Length D_c_2=0.01042 "Fin collar diameter";
          parameter Modelica.SIunits.Length F_p_2=0.00205
            "Fin pitch, fin spacing + fin thickness";
          parameter Modelica.SIunits.Length L_2=N_2*P_l_2
            "Heat exchanger length";
          parameter Modelica.SIunits.Length L_h_2=0.0014 "Louver height";
          parameter Modelica.SIunits.Length L_p_2=0.0024 "Louver pitch";
          parameter Integer N_2=2 "Number of tube rows";
          parameter Modelica.SIunits.Length P_l_2=0.01905
            "Longitudinal tube pitch";
          parameter Modelica.SIunits.Length P_t_2=0.0254
            "Transverse tube pitch";

          //heat exchanger variables geometry no.3
          parameter Modelica.SIunits.Length D_c_3=0.01034 "Fin collar diameter";
          parameter Modelica.SIunits.Length F_p_3=0.00246
            "Fin pitch, fin spacing + fin thickness";
          parameter Integer N_3=2 "Number of tube rows";
          parameter Modelica.SIunits.Length P_l_3=0.022
            "Longitudinal tube pitch";
          parameter Modelica.SIunits.Length P_t_3=0.0254
            "Transverse tube pitch";
          parameter Modelica.SIunits.Length delta_f_3=0.00012 "fin thickness";
          parameter Modelica.SIunits.Length S_h_3=0.00099 "Slit height";
          parameter Modelica.SIunits.Length S_p_3=0.0022 "Slit pitch";

          //heat exchanger variables geometry no.4
          parameter Modelica.SIunits.Length D_c_4=0.0103 "Fin collar diameter";
          parameter Modelica.SIunits.Length F_p_4=0.00169
            "Fin pitch, fin spacing + fin thickness";
          parameter Integer N_4=2 "Number of tube rows";
          parameter Modelica.SIunits.Length P_l_4=0.01905
            "Longitudinal tube pitch";
          parameter Modelica.SIunits.Length P_t_4=0.0254
            "Transverse tube pitch";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp=
              1007 "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta=18.24e-6
            "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda=25.69e-3
            "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho=1.188 "Density of fluid";

          //input VARIABLES
          Modelica.SIunits.ReynoldsNumber Re=input_Re.y "Reynolds number" 
            annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
            m_flow_IN_con_1(
            geometry=1,
            A_fr=A_fr,
            D_c=D_c_1,
            F_p=F_p_1,
            P_t=P_t_1,
            P_l=P_l_1,
            N=N_1,
            delta_f=delta_f) 
            annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
            m_flow_IN_var_1(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[1]) 
            annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
            m_flow_IN_con_2(
            geometry=2,
            A_fr=A_fr,
            D_c=D_c_2,
            F_p=F_p_2,
            L_h=L_h_2,
            L_p=L_p_2,
            P_t=P_t_2,
            P_l=P_l_2,
            N=N_2,
            delta_f=delta_f,
            L=L_2) annotation (Placement(transformation(extent={{20,20},{40,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
            m_flow_IN_var_2(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[2]) 
            annotation (Placement(transformation(extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
            m_flow_IN_con_3(
            geometry=3,
            A_fr=A_fr,
            D_c=D_c_3,
            F_p=F_p_3,
            P_t=P_t_3,
            P_l=P_l_3,
            N=N_3,
            S_h=S_h_3,
            S_p=S_p_3,
            delta_f=delta_f_3) 
            annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
            m_flow_IN_var_3(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[3]) 
            annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
            m_flow_IN_con_4(
            geometry=4,
            A_fr=A_fr,
            D_c=D_c_4,
            F_p=F_p_4,
            P_t=P_t_4,
            delta_f=delta_f) 
            annotation (Placement(transformation(extent={{20,-20},{40,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
            m_flow_IN_var_4(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[4]) 
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));

          //output variables
          Modelica.SIunits.MassFlowRate m_flow[n] "Mass flow rate" 
                                                     annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu[n] "Nusselt number" 
                                                  annotation (Dialog(group="Output"));

        public
          Modelica.Blocks.Sources.Ramp input_Re(
            duration=1,
            startTime=0,
            height=10000,
            offset=100) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));

        equation
          //heat transfer calculation
          (,,Re,Nu[1],) =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube(
            m_flow_IN_con_1, m_flow_IN_var_1);

          (,,Re,Nu[2],) =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube(
            m_flow_IN_con_2, m_flow_IN_var_2);

          (,,Re,Nu[3],) =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube(
            m_flow_IN_con_3, m_flow_IN_var_3);

          (,,Re,Nu[4],) =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube(
            m_flow_IN_con_4, m_flow_IN_var_4);

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/heatExchanger/kc_roundTube.mos"
                "Verification of kc_roundTube"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                      "Heat transfer of heat exchangers with round tubes and various fin geometries"),
                Text(
                  extent={{-60,18},{-20,10}},
                  lineColor={0,0,255},
                  textString="Round tube and plain fin"),
                Text(
                  extent={{20,18},{60,10}},
                  lineColor={0,0,255},
                  textString="Round tube and louver fin"),
                Text(
                  extent={{-58,-22},{-22,-30}},
                  lineColor={0,0,255},
                  textString="Round tube and slit fin"),
                Text(
                  extent={{20,-22},{60,-30}},
                  lineColor={0,0,255},
                  textString="Round tube and wavy fin")}),
            experiment(StopTime=1.01));
        end kc_roundTube;

        model kc_roundTube_KC "Verification of function kc_roundTube_KC"
          //The functions for heat exchanger geometry no.2 and no.3 are too complex for inverting.
          //Therefore they have been removed from this verification model.

          parameter Integer n=4 "Number of various fin geometries";

          //heat exchanger variables
          parameter Modelica.SIunits.Area A_fr=1 "Frontal area";
          parameter Modelica.SIunits.Length delta_f=0.0001 "fin thickness";

          //heat exchanger variables geometry no.1
          parameter Modelica.SIunits.Length D_c_1=0.00752 "Fin collar diameter";
          parameter Modelica.SIunits.Length F_p_1=0.00122
            "Fin pitch, fin spacing + fin thickness";
          parameter Modelica.SIunits.Length P_l_1=0.0127
            "Longitudinal tube pitch";
          parameter Modelica.SIunits.Length P_t_1=0.021 "Transverse tube pitch";
          parameter Integer N_1=2 "Number of tube rows";

          //heat exchanger variables geometry no.2
          parameter Modelica.SIunits.Length D_c_2=0.01042 "Fin collar diameter";
          parameter Modelica.SIunits.Length F_p_2=0.00205
            "Fin pitch, fin spacing + fin thickness";
          parameter Modelica.SIunits.Length L_2=N_2*P_l_2
            "Heat exchanger length";
          parameter Modelica.SIunits.Length L_h_2=0.0014 "Louver height";
          parameter Modelica.SIunits.Length L_p_2=0.0024 "Louver pitch";
          parameter Integer N_2=2 "Number of tube rows";
          parameter Modelica.SIunits.Length P_l_2=0.01905
            "Longitudinal tube pitch";
          parameter Modelica.SIunits.Length P_t_2=0.0254
            "Transverse tube pitch";

          //heat exchanger variables geometry no.3
          parameter Modelica.SIunits.Length D_c_3=0.01034 "Fin collar diameter";
          parameter Modelica.SIunits.Length F_p_3=0.00246
            "Fin pitch, fin spacing + fin thickness";
          parameter Integer N_3=2 "Number of tube rows";
          parameter Modelica.SIunits.Length P_l_3=0.022
            "Longitudinal tube pitch";
          parameter Modelica.SIunits.Length P_t_3=0.0254
            "Transverse tube pitch";
          parameter Modelica.SIunits.Length delta_f_3=0.00012 "fin thickness";
          parameter Modelica.SIunits.Length S_h_3=0.00099 "Slit height";
          parameter Modelica.SIunits.Length S_p_3=0.0022 "Slit pitch";

          //heat exchanger variables geometry no.4
          parameter Modelica.SIunits.Length D_c_4=0.0103 "Fin collar diameter";
          parameter Modelica.SIunits.Length F_p_4=0.00169
            "Fin pitch, fin spacing + fin thickness";
          parameter Integer N_4=2 "Number of tube rows";
          parameter Modelica.SIunits.Length P_l_4=0.01905
            "Longitudinal tube pitch";
          parameter Modelica.SIunits.Length P_t_4=0.0254
            "Transverse tube pitch";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp=
              1007 "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta=18.24e-6
            "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda=25.69e-3
            "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho=1.188 "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu=input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow[n](start=ones(n)*1e-6);

          Modelica.SIunits.CoefficientOfHeatTransfer kc_1=Nu*lambda/D_c_1;
          //SI.CoefficientOfHeatTransfer kc_2 = Nu*lambda/D_c_2;
          //SI.CoefficientOfHeatTransfer kc_3 = Nu*lambda/D_c_3;
          Modelica.SIunits.CoefficientOfHeatTransfer kc_4=Nu*lambda/D_c_4;

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
            m_flow_IN_con_1(
            geometry=1,
            A_fr=A_fr,
            D_c=D_c_1,
            F_p=F_p_1,
            P_t=P_t_1,
            P_l=P_l_1,
            N=N_1,
            delta_f=delta_f) 
            annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
            m_flow_IN_var_1(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[1]) 
            annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
            m_flow_IN_con_2(
            geometry=2,
            A_fr=A_fr,
            D_c=D_c_2,
            F_p=F_p_2,
            L_h=L_h_2,
            L_p=L_p_2,
            P_t=P_t_2,
            P_l=P_l_2,
            N=N_2,
            delta_f=delta_f) 
            annotation (Placement(transformation(extent={{20,20},{40,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
            m_flow_IN_var_2(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[2]) 
            annotation (Placement(transformation(extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
            m_flow_IN_con_3(
            geometry=3,
            A_fr=A_fr,
            D_c=D_c_3,
            F_p=F_p_3,
            P_t=P_t_3,
            P_l=P_l_3,
            N=N_3,
            S_h=S_h_3,
            S_p=S_p_3,
            delta_f=delta_f_3) 
            annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
            m_flow_IN_var_3(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[3]) 
            annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
            m_flow_IN_con_4(
            geometry=4,
            A_fr=A_fr,
            D_c=D_c_4,
            F_p=F_p_4,
            P_t=P_t_4,
            delta_f=delta_f) 
            annotation (Placement(transformation(extent={{20,-20},{40,0}})));
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
            m_flow_IN_var_4(
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow[4]) 
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));

          Modelica.SIunits.ReynoldsNumber Re_1=abs(m_flow[1])*D_c_1/(eta*A_fr*(
              (F_p_1*P_t_1 - F_p_1*D_c_1 - (P_t_1 - D_c_1)*delta_f)/(F_p_1*
              P_t_1)));
          //SI.ReynoldsNumber Re_2 = abs(m_flow[2])*D_c_2/(eta*A_fr*((F_p_2*P_t_2-F_p_2*D_c_2-(P_t_2-D_c_2)*delta_f)/(F_p_2*P_t_2)));
          //SI.ReynoldsNumber Re_3 = abs(m_flow[3])*D_c_3/(eta*A_fr*((F_p_3*P_t_3-F_p_3*D_c_3-(P_t_3-D_c_3)*delta_f_3)/(F_p_3*P_t_3)));
          Modelica.SIunits.ReynoldsNumber Re_4=abs(m_flow[4])*D_c_4/(eta*A_fr*(
              (F_p_4*P_t_4 - F_p_4*D_c_4 - (P_t_4 - D_c_4)*delta_f)/(F_p_4*
              P_t_4)));
        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e3,
            offset=5) annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{50,-80},{70,-60}})));
        equation
          //heat transfer calculation
          kc_1 =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC(
            m_flow_IN_con_1, m_flow_IN_var_1);
          //kc_2 = Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_heatExchanger_KC(
          //m_flow_IN_con_2, m_flow_IN_var_2);
          //kc_3 = Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC(
          //m_flow_IN_con_3, m_flow_IN_var_3);
          kc_4 =
            Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC(
            m_flow_IN_con_4, m_flow_IN_var_4);
          m_flow[2] = 1;
          m_flow[3] = 1;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/heatExchanger/kc_roundTube_KC.mos"
                "Verification of kc_roundTube_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of heat exchangers with round tubes and various fin geometries (inlining)"),
                  Text(
                  extent={{-60,18},{-20,10}},
                  lineColor={0,0,255},
                  textString="Round tube and plain fin"),Text(
                  extent={{20,18},{60,10}},
                  lineColor={0,0,255},
                  textString="Round tube and louver fin"),Text(
                  extent={{-60,-22},{-20,-30}},
                  lineColor={0,0,255},
                  textString="Round tube and slit fin"),Text(
                  extent={{20,-22},{60,-30}},
                  lineColor={0,0,255},
                  textString="Round tube and wavy fin")}),
            experiment(StopTime=1.01));
        end kc_roundTube_KC;
      end HeatExchanger;

      package HelicalPipe "Verification package for helical pipe correlations"
      extends Modelica.Icons.ExamplesPackage;
        model kc_laminar "Verification of function kc_laminar"

          parameter Integer n=size(cp, 1);

          //helical pipe variables
          parameter Real n_nt[:]={1,5,10} "Total number of turns";

          parameter Modelica.SIunits.Diameter d_hyd=0.01;
          parameter Modelica.SIunits.Length L=10 "Total length of helical pipe";
          parameter Modelica.SIunits.Length h=1.5*d_hyd
            "Distance between turns";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input VARIABLES
          Modelica.SIunits.MassFlowRate m_flow[n]={input_mflow_0.y*eta[1]/eta[3],
              input_mflow_0.y*eta[2]/eta[3],input_mflow_0.y} "Mass flow rate" 
            annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[1]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[2]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-20,20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{0,20},{20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con
            m_flow_IN_con_3[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[3]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var
            m_flow_IN_var_3[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{60,20},{80,40}})));

          //output variables
          Modelica.SIunits.ReynoldsNumber Re_1[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_3[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

          Modelica.Blocks.Sources.Ramp input_mflow_0(duration=1, height=1e2) 
            annotation (extent=[-80, -80; -60, -60], Placement(transformation(extent={{
                    -80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(amplitude=100, freqHz=1) 
            annotation (extent=[-80, -80; -60, -60], Placement(transformation(extent={{
                    -40,-80},{-20,-60}})));

          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            outMax=100,
            riseTime=1e-1,
            riseTimeConst=1e-1) annotation (extent=[-40, -80; -20, -60], Placement(
                transformation(extent={{0,-80},{20,-60}})));

        protected
          parameter Real frac_dtoL=d_hyd/L;

          Modelica.SIunits.ReynoldsNumber Re=Re_1[1] "Reynolds number";
          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";

        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,Re_1[i],Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_3[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar(
              m_flow_IN_con_3[i], m_flow_IN_var_3[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/helicalPipe/kc_laminar.mos"
                "Verification of kc_laminar"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of helical pipe for LAMINAR flow regime"),
                  Text(
                  extent={{-78,15},{-40,6}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 1"),Text(
                  extent={{-18,15},{20,6}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 5"),Text(
                  extent={{42,15},{80,6}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 10")}),
            experiment(StopTime=1.01));
        end kc_laminar;

        model kc_laminar_KC "Verification of function kc_laminar_KC"

          parameter Integer n=size(cp, 1);

          //helical pipe variables
          parameter Real n_nt[:]={1,5,10} "Total number of turns";

          parameter Modelica.SIunits.Diameter d_hyd=0.01;
          parameter Modelica.SIunits.Length L=10 "Total length of helical pipe";
          parameter Modelica.SIunits.Length h=1.5*d_hyd
            "Distance between turns";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow_1[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_2[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_3[3](start=ones(n)*1e-6);

          Modelica.SIunits.CoefficientOfHeatTransfer kc_1[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_2[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_3[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[1]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow_1,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[2]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-20,20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow_2,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{0,20},{20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con
            m_flow_IN_con_3[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[3]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var
            m_flow_IN_var_3[n](
            m_flow=m_flow_3,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{60,20},{80,40}})));

          Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_3[n]={abs(m_flow_3[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            offset=5,
            height=8e1) 
                      annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{50,-80},{70,-60}})));

        equation
          //heat transfer calculation
          kc_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};
          kc_2 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC(
            m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};
          kc_3 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC(
            m_flow_IN_con_3[i], m_flow_IN_var_3[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/helicalPipe/kc_laminar_KC.mos"
                "Verification of kc_laminar_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of helical pipe for LAMINAR flow regime (inlining)"),
                  Text(
                  extent={{-78,17},{-40,8}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 1"),Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{-16,17},{22,8}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 5"),Text(
                  extent={{40,17},{78,8}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 10")}),
            experiment(StopTime=1.01));
        end kc_laminar_KC;

        model kc_overall "Verification of function kc_overall"

          parameter Integer n=size(cp, 1);

          //helical pipe variables
          parameter Modelica.SIunits.Diameter d_hyd=0.02;
          parameter Modelica.SIunits.Length L=10 "Total length of helical pipe";
          parameter Modelica.SIunits.Length h=1.5*d_hyd
            "Distance between turns";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input VARIABLES
          Modelica.SIunits.MassFlowRate m_flow[n]={input_mflow_0.y*eta[1]/eta[3],
              input_mflow_0.y*eta[2]/eta[3],input_mflow_0.y} "Mass flow rate" 
            annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[1]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var
            m_flow_IN_var_1[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[2]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-20,20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var
            m_flow_IN_var_2[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{0,20},{20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con
            m_flow_IN_con_3[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[3]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var
            m_flow_IN_var_3[n](
            m_flow=m_flow,
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{60,20},{80,40}})));

          //output variables
          Modelica.SIunits.ReynoldsNumber Re_1[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_3[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

          Modelica.Blocks.Sources.Ramp input_mflow_0(
            duration=1,
            offset=1e-5,
            height=1e3) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(amplitude=100, freqHz=1) 
            annotation (extent=[-80, -80; -60, -60], Placement(transformation(extent={{
                    -40,-80},{-20,-60}})));

          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            outMax=100,
            riseTime=1e-1,
            riseTimeConst=1e-1) annotation (extent=[-40, -80; -20, -60], Placement(
                transformation(extent={{0,-80},{20,-60}})));

        protected
          constant Real MIN=Modelica.Constants.eps;

          parameter Real frac_dtoL=d_hyd/L;
          parameter Real frac_dhydTodcoil[n]={0.012,0.049,0.098};
          parameter Real d_coil[n]={d_hyd/frac_dhydTodcoil[i] for i in 1:n};
          parameter Real d_w[n]={sqrt((d_coil[i])^2 + (h/Modelica.Constants.pi)
                                                            ^2) for i in 1:n};
          parameter Real n_nt[n]={L/(d_w[i]*Modelica.Constants.pi) 
                                                for i in 1:n};

          Modelica.SIunits.ReynoldsNumber Re=Re_1[1] "Reynolds number";
          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";

        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,Re_1[i],Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_3[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall(
              m_flow_IN_con_3[i], m_flow_IN_var_3[i]);
          end for;

          annotation (
            Commands(file="modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/helicalPipe/kc_overall.mos"
                "Verification of kc_overall"),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                    100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of helical pipe for OVERALL flow regime")}),
            experiment(StopTime=1.01, Tolerance=1e-007),
            experimentSetupOutput(events=false));
        end kc_overall;

        model kc_overall_KC "Verification of function kc_mean_overall_KC"

          parameter Integer n=size(cp, 1);

          //helical pipe variables
          parameter Real n_nt[:]={1,5,10} "Total number of turns";

          parameter Modelica.SIunits.Diameter d_hyd=0.01;
          parameter Modelica.SIunits.Length L=10 "Total length of helical pipe";
          parameter Modelica.SIunits.Length h=1.5*d_hyd
            "Distance between turns";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow_1[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_2[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_3[3](start=ones(n)*1e-6);

          Modelica.SIunits.CoefficientOfHeatTransfer kc_1[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_2[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_3[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each n_nt=n_nt[1],
            each h=h) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var
            m_flow_IN_var_1[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_1) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[2]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-20,20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var
            m_flow_IN_var_2[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_2) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con
            m_flow_IN_con_3[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[3]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var
            m_flow_IN_var_3[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_3) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{60,20},{80,40}})));

          Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_3[n]={abs(m_flow_3[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};

          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e6,
            offset=10) annotation (extent=[-80, -80; -60, -60],Placement(transformation(
                  extent={{50,-80},{70,-60}})));

        equation
          //heat transfer calculation
          kc_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};
          kc_2 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC(
            m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};
          kc_3 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC(
            m_flow_IN_con_3[i], m_flow_IN_var_3[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/helicalPipe/kc_overall_KC.mos"
                "Verification of kc_overall_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of helical pipe for OVERALL flow regime (inlining)"),
                  Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{-78,19},{-40,10}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 1"),Text(
                  extent={{-16,19},{22,10}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 5"),Text(
                  extent={{40,19},{78,10}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 10")}),
            experiment(StopTime=1.01, Tolerance=1e-007),
            experimentSetupOutput);
        end kc_overall_KC;

        model kc_turbulent "Verification of function kc_turbulent"

          parameter Integer n=size(cp, 1);

          //helical pipe variables
          parameter Real n_nt[:]={1,5,10} "Total number of turns";

          parameter Modelica.SIunits.Diameter d_hyd=0.01;
          parameter Modelica.SIunits.Length L=10 "Total length of helical pipe";
          parameter Modelica.SIunits.Length h=1.5*d_hyd
            "Distance between turns";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input VARIABLES
          Modelica.SIunits.MassFlowRate m_flow[n]={input_mflow_0.y*eta[1]/eta[3],
              input_mflow_0.y*eta[2]/eta[3],input_mflow_0.y} "Mass flow rate" 
            annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each n_nt=n_nt[1],
            each h=h) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
            m_flow_IN_var_1[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each n_nt=n_nt[2],
            each h=h) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-20,20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
            m_flow_IN_var_2[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
            m_flow_IN_con_3[n](
            each d_hyd=d_hyd,
            each L=L,
            each n_nt=n_nt[3],
            each h=h) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
            m_flow_IN_var_3[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{60,20},{80,40}})));

          //output variables
          Modelica.SIunits.ReynoldsNumber Re_1[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_3[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

          Modelica.Blocks.Sources.Sine input_mflow_1(amplitude=100, freqHz=1) 
            annotation (extent=[-80, -80; -60, -60], Placement(transformation(extent={{
                    -40,-80},{-20,-60}})));

          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            outMax=100,
            riseTime=1e-1,
            riseTimeConst=1e-1) annotation (extent=[-40, -80; -20, -60], Placement(
                transformation(extent={{0,-80},{20,-60}})));

          Modelica.Blocks.Sources.Ramp input_mflow_0(
            duration=1,
            offset=0,
            height=1e6) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
        protected
          parameter Real frac_dtoL=d_hyd/L;

          Modelica.SIunits.ReynoldsNumber Re=Re_1[1] "Reynolds number";
          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";

        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,Re_1[i],Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_3[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent(
              m_flow_IN_con_3[i], m_flow_IN_var_3[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/helicalPipe/kc_turbulent.mos"
                "Verification of kc_turbulent"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of helical pipe for TURBULENT flow regime"),
                  Text(
                  extent={{-76,15},{-38,6}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 1"),Text(
                  extent={{-16,15},{22,6}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 5"),Text(
                  extent={{44,15},{82,6}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 10")}),
            experiment(StopTime=1.01, Tolerance=1e-007));
        end kc_turbulent;

        model kc_turbulent_KC "Verification of function kc_turbulent_KC"
          parameter Integer n=size(cp, 1);

          //helical pipe variables
          parameter Real n_nt[:]={1,5,10} "Total number of turns";

          parameter Modelica.SIunits.Diameter d_hyd=0.01;
          parameter Modelica.SIunits.Length L=10 "Total length of helical pipe";
          parameter Modelica.SIunits.Length h=1.5*d_hyd
            "Distance between turns";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow_1[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_2[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_3[3](start=ones(n)*1e-6);

          Modelica.SIunits.CoefficientOfHeatTransfer kc_1[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_2[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_3[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each n_nt=n_nt[1],
            each h=h) annotation (extent=[-10, 20; 10, 40], Placement(transformation(
                  extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
            m_flow_IN_var_1[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_1) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[2]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-20,20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
            m_flow_IN_var_2[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_2) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
            m_flow_IN_con_3[n](
            each d_hyd=d_hyd,
            each L=L,
            each h=h,
            each n_nt=n_nt[3]) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{40,20},{60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
            m_flow_IN_var_3[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_3) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{60,20},{80,40}})));

          Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_3[n]={abs(m_flow_3[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            offset=5e2,
            height=8e2) 
                      annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{50,-80},{70,-60}})));

        equation
          //heat transfer calculation
          kc_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};
          kc_2 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC(
            m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};
          kc_3 = {
            Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC(
            m_flow_IN_con_3[i], m_flow_IN_var_3[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/helicalPipe/kc_turbulent_KC.mos"
                "Verification of kc_turbulent_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of helical pipe for TURBULENT flow regime (inlining)"),
                  Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{-78,17},{-40,8}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 1"),Text(
                  extent={{-16,17},{22,8}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 5"),Text(
                  extent={{40,17},{78,8}},
                  lineColor={0,0,255},
                  textString="number of turns n_nt = 10")}),
            experiment(StopTime=1.01, Tolerance=1e-007));
        end kc_turbulent_KC;
      end HelicalPipe;

      package Plate "Verification models for plate heat transfer"
      extends Modelica.Icons.ExamplesPackage;
        model kc_laminar "Verification of function kc_laminar"

          parameter Integer n=size(cp, 1);

          //plate variable
          parameter Modelica.SIunits.Length L=1 "Length of plate";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //target variables
          //here: mass flow rate as input for normal calculation
          Modelica.SIunits.Velocity velocity[n]={input_v_0.y*eta[1]/eta[3]*rho[3]/rho[1],
              input_v_0.y*eta[2]/eta[3]*rho[3]/rho[2],input_v_0.y};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_con
            IN_con[n](each L=L) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-20,
                    20},{0,40}})));
          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_var
            IN_var[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            velocity=velocity) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          //output variables
          Modelica.SIunits.NusseltNumber Nu[n] "Nussel number" 
                                                 annotation (Dialog(group="Output"));

          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho[i]*abs(velocity[i])*L/eta[
              i] for i in 1:n} "Reynolds number";

        public
          Modelica.Blocks.Sources.Ramp input_v_0(
            duration=1,
            startTime=0,
            height=2e1,
            offset=1e-5) annotation (extent=[-80, -80; -60, -60],Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_v_1(
            offset=0,
            phase=0,
            startTime=0,
            freqHz=1,
            amplitude=1) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_v_2(
            offset=0,
            startTime=0,
            riseTime=1e-2,
            riseTimeConst=1e-2,
            outMax=1) annotation (extent=[-40, -80; -20, -60], Placement(transformation(
                  extent={{0,-80},{20,-60}})));
        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,,Nu[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar(IN_con[i],
              IN_var[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/plate/kc_laminar.mos"
                "Verification of kc_laminar"), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of plate for LAMINAR flow regime"),Text(
                  extent={{-100,11},{100,6}},
                  lineColor={0,0,255},
                  textString="Target: kc == f(m_flow)")}),
            experiment(StopTime=1.01, Tolerance=1e-007));
        end kc_laminar;

        model kc_laminar_KC "Verification of function kc_laminar_KC"

          parameter Integer n=size(cp, 1);

          //plate variable
          parameter Modelica.SIunits.Length L=1 "Length of plate";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.Velocity velocity[n](start=ones(n)*1e-6);
          Modelica.SIunits.CoefficientOfHeatTransfer kc[n]={Nu[i]*lambda[i]/L 
              for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_con
            IN_con[n](each L=L) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-20,
                    20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_var
            IN_var[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            velocity=abs(velocity)) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho[i]*abs(velocity[i])*L/eta[
              i] for i in 1:n} "Reynolds number";

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            offset=10,
            height=4e2) 
                       annotation (extent=[-80, -80; -60, -60],Placement(transformation(
                  extent={{50,-80},{70,-60}})));
        equation
          //heat transfer calculation
          kc = {Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC(
            IN_con[i], IN_var[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/plate/kc_laminar_KC.mos"
                "Verification of kc_laminar_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of plate for LAMINAR flow regime (inlining)"),Text(
                  extent={{-100,11},{100,6}},
                  lineColor={0,0,255},
                  textString="Target: m_flow == f(kc)"),Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(StopTime=1.01, Tolerance=1e-007));
        end kc_laminar_KC;

        model kc_overall "Verification of function kc_overall"

          parameter Integer n=size(cp, 1);

          //plate variable
          parameter Modelica.SIunits.Length L=1 "Length of plate";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //target variables
          //here: mass flow rate as input for normal calculation
          Modelica.SIunits.Velocity velocity[n]={input_v_0.y*eta[1]/eta[3]*rho[3]/rho[1],
              input_v_0.y*eta[2]/eta[3]*rho[3]/rho[2],input_v_0.y};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con
            IN_con[n](each L=L) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-20,
                    20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var
            IN_var[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            velocity=velocity) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          //output variables
          Modelica.SIunits.NusseltNumber Nu[n] "Nussel number" 
                                                 annotation (Dialog(group="Output"));

          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho[i]*abs(velocity[i])*L/eta[
              i] for i in 1:n} "Reynolds number";

          Modelica.Blocks.Sources.Sine input_v_1(
            offset=0,
            phase=0,
            startTime=0,
            amplitude=10,
            freqHz=1/10) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_v_2(
            offset=0,
            riseTime=1e-1,
            riseTimeConst=1e-1,
            startTime=0,
            outMax=10) annotation (extent=[-40, -80; -20, -60], Placement(
                transformation(extent={{0,-80},{20,-60}})));

        public
          Modelica.Blocks.Sources.Ramp input_v_0(
            duration=1,
            startTime=0,
            offset=1e-6,
            height=5e3) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,,Nu[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall(IN_con[i],
              IN_var[i]);
          end for;

          annotation (
            Commands(file="modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/plate/kc_overall.mos"
                "Verification of kc_overall"),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of plate for OVERALL flow regime"),Text(
                  extent={{-100,11},{100,6}},
                  lineColor={0,0,255},
                  textString="Target: kc == f(m_flow)")}),
            experiment(Tolerance=1e-005),
            experimentSetupOutput(
              states=false,
              derivatives=false,
              inputs=false,
              equdistant=false,
              events=false));
        end kc_overall;

        model kc_overall_KC "Verification of function kc_overall_KC"

          parameter Integer n=size(cp, 1);

          //plate variable
          parameter Modelica.SIunits.Length L=1 "Length of plate";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for reverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.Velocity velocity[n](start=ones(n)*1e-6);
          Modelica.SIunits.CoefficientOfHeatTransfer kc[n]={Nu[i]*lambda[i]/L 
              for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con
            IN_con[n](each L=L) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-20,
                    20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var
            IN_var[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            velocity=abs(velocity)) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho[i]*abs(velocity[i])*L/eta[
              i] for i in 1:n} "Reynolds number";

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e6,
            offset=1e0) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{50,-80},{70,-60}})));
        equation
          //heat transfer calculation
          kc = {Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC(
            IN_con[i], IN_var[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/plate/kc_overall_KC.mos"
                "Verification of kc_overall_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of plate for OVERALL flow regime (inlining)"),Text(
                  extent={{-100,11},{100,6}},
                  lineColor={0,0,255},
                  textString="Target: m_flow == f(kc)"),Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(StopTime=1.01, Tolerance=1e-007));
        end kc_overall_KC;

        model kc_turbulent "Verification of function kc_turbulent"

          parameter Integer n=size(cp, 1);

          //plate variable
          parameter Modelica.SIunits.Length L=1 "Length of plate";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //target variables
          //here: mass flow rate as input for normal calculation
          Modelica.SIunits.Velocity velocity[n]={input_v_0.y*eta[1]/eta[3]*rho[3]/rho[1],
              input_v_0.y*eta[2]/eta[3]*rho[3]/rho[2],input_v_0.y};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_con
            IN_con[n](each L=L) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-20,
                    20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_var
            IN_var[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            velocity=velocity) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          //output variables
          Modelica.SIunits.NusseltNumber Nu[n] "Nussel number" 
                                                 annotation (Dialog(group="Output"));

          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho[i]*abs(velocity[i])*L/eta[
              i] for i in 1:n} "Reynolds number";

        public
          Modelica.Blocks.Sources.Ramp input_v_0(
            duration=1,
            startTime=0,
            height=1e4,
            offset=1e-6) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_v_1(
            offset=0,
            phase=0,
            startTime=0,
            freqHz=1,
            amplitude=10) annotation (extent=[-80, -80; -60, -60],Placement(
                transformation(extent={{-40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_v_2(
            offset=0,
            startTime=0,
            riseTime=1e-2,
            riseTimeConst=1e-2,
            outMax=10) annotation (extent=[-40, -80; -20, -60],Placement(transformation(
                  extent={{0,-80},{20,-60}})));
        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,,Nu[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent(IN_con[
              i], IN_var[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/plate/kc_turbulent.mos"
                "Verification of kc_turbulent"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of plate for LAMINAR flow regime"),Text(
                  extent={{-100,11},{100,6}},
                  lineColor={0,0,255},
                  textString="Target: kc == f(m_flow)")}),
            experiment(StopTime=1.01, Tolerance=1e-007));
        end kc_turbulent;

        model kc_turbulent_KC "Verification of function kc_turbulent_KC"

          parameter Integer n=size(cp, 1);

          //plate variable
          parameter Modelica.SIunits.Length L=1 "Length of plate";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.Velocity velocity[n](start=ones(n)*1e-6);
          Modelica.SIunits.CoefficientOfHeatTransfer kc[n]={Nu[i]*lambda[i]/L 
              for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_con
            IN_con[n](each L=L) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-20,
                    20},{0,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_var
            IN_var[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            velocity=abs(velocity)) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{0,20},{20,40}})));

          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho[i]*abs(velocity[i])*L/eta[
              i] for i in 1:n} "Reynolds number";

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e6,
            offset=2.5e4) 
                        annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{50,-80},{70,-60}})));
        equation
          //heat transfer calculation
          kc = {Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC(
            IN_con[i], IN_var[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/plate/kc_turbulent_KC.mos"
                "Verification of kc_turbulent_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer of plate for TURBULENT flow regime (inlining)"),Text(
                  extent={{-100,11},{100,6}},
                  lineColor={0,0,255},
                  textString="Target: m_flow == f(kc)"),Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(StopTime=1.01, Tolerance=1e-007));
        end kc_turbulent_KC;
      end Plate;

      package StraightPipe
        "Verification package for straight pipe correlations"
      extends Modelica.Icons.ExamplesPackage;
        model kc_laminar "Verification of function kc_laminar"

          parameter Integer n=size(cp, 1);

          //straight pipe variables
          parameter Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
          parameter Modelica.SIunits.Length L=1 "Length of straight pipe";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input VARIABLES
          Modelica.SIunits.MassFlowRate m_flow[n]={input_mflow_0.y*eta[1]/eta[3],
              input_mflow_0.y*eta[2]/eta[3],input_mflow_0.y} "Mass flow rate" 
            annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-100,
                    20},{-80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
            m_flow_IN_var_1[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuDFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-50,
                    20},{-30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
            m_flow_IN_var_2[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
            m_flow_IN_con_3[n](
            each d_hyd=d_hyd,
            each L=L,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuUFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{10,
                    20},{30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
            m_flow_IN_var_3[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
            m_flow_IN_con_4[n](
            each d_hyd=d_hyd,
            each L=L,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuUFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{60,
                    20},{80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
            m_flow_IN_var_4[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{80,20},{100,40}})));

          //output variables
          Modelica.SIunits.ReynoldsNumber Re_1[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_3[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_4[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

        protected
          parameter Real frac_dtoL=d_hyd/L;

          Modelica.SIunits.ReynoldsNumber Re=Re_1[1] "Reynolds number";
          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";

        public
          Modelica.Blocks.Sources.Ramp input_mflow_0(
            duration=1,
            offset=0,
            startTime=0,
            height=100) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(
            amplitude=100,
            offset=0,
            phase=0,
            startTime=0,
            freqHz=1) annotation (extent=[-40, -80; -20, -60], Placement(transformation(
                  extent={{-40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            offset=0,
            outMax=100,
            riseTime=1e-1,
            riseTimeConst=1e-1,
            startTime=0) annotation (extent=[0, -80; 20, -60], Placement(transformation(
                  extent={{0,-80},{20,-60}})));

        equation
          for i in 1:n loop
            (,,Re_1[i],Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_3[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar(
              m_flow_IN_con_3[i], m_flow_IN_var_3[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_4[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar(
              m_flow_IN_con_4[i], m_flow_IN_var_4[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/straightPipe/kc_laminar.mos"
                "Verification of kc_laminar"), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of straight pipe for LAMINAR flow regime"),
                  Text(
                  extent={{-104,14},{-58,6}},
                  lineColor={0,0,255},
                  textString="UWT+DFF"),Text(
                  extent={{-54,20},{-8,12}},
                  lineColor={0,0,255},
                  textString="UHF + DFF"),Text(
                  extent={{6,12},{52,4}},
                  lineColor={0,0,255},
                  textString="UWT+UFF"),Text(
                  extent={{56,20},{102,12}},
                  lineColor={0,0,255},
                  textString="UHF + UFF")}),
            experiment(StopTime=1.01, Tolerance=1e-007));
        end kc_laminar;

        model kc_laminar_KC "Verification of function kc_mean_laminar_KC"

          parameter Integer n=size(cp, 1);

          //straight pipe variables
          parameter Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
          parameter Modelica.SIunits.Length L=1 "Length of straight pipe";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow_1[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_2[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_3[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_4[3](start=ones(n)*1e-6);

          Modelica.SIunits.CoefficientOfHeatTransfer kc_1[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_2[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_3[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_4[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
            m_flow_IN_con_1[3](
            each d_hyd=d_hyd,
            each L=L,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-100,
                    20},{-80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
            m_flow_IN_var_1[3](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_1) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
            m_flow_IN_con_2[3](
            each d_hyd=d_hyd,
            each L=L,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuDFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-50,
                    20},{-30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
            m_flow_IN_var_2[3](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_2) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
            m_flow_IN_con_3[3](
            each d_hyd=d_hyd,
            each L=L,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuUFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{10,
                    20},{30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
            m_flow_IN_var_3[3](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_3) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
            m_flow_IN_con_4[3](
            each d_hyd=d_hyd,
            each L=L,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuUFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{60,
                    20},{80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
            m_flow_IN_var_4[3](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_4) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{80,20},{100,40}})));

          Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_3[n]={abs(m_flow_3[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_4[n]={abs(m_flow_4[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            offset=5,
            height=3e1) 
                      annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{52,-80},{72,-60}})));

        equation
          //heat transfer calculation
          kc_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};
          kc_2 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
            m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};
          kc_3 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
            m_flow_IN_con_3[i], m_flow_IN_var_3[i]) for i in 1:n};
          kc_4 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
            m_flow_IN_con_4[i], m_flow_IN_var_4[i]) for i in 1:n};
          annotation (
            Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/straightPipe/kc_laminar_KC.mos"
                "Verification of kc_laminar_KC"),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                    100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of straight pipe for LAMINAR flow regime"),
                  Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{-104,14},{-58,6}},
                  lineColor={0,0,255},
                  textString="UWT+DFF"),Text(
                  extent={{-52,20},{-6,12}},
                  lineColor={0,0,255},
                  textString="UHF + DFF"),Text(
                  extent={{56,20},{102,12}},
                  lineColor={0,0,255},
                  textString="UHF + UFF"),Text(
                  extent={{6,12},{52,4}},
                  lineColor={0,0,255},
                  textString="UWT+UFF")}),
            experiment(Tolerance=1e-005),
            experimentSetupOutput);
        end kc_laminar_KC;

        model kc_overall "Verification of function kc_overall"

          parameter Integer n=size(cp, 1);

          //straight pipe variables
          parameter Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
          parameter Modelica.SIunits.Length L=1 "Length of straight pipe";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input VARIABLES
          Modelica.SIunits.MassFlowRate m_flow[n]={input_mflow_0.y*eta[1]/eta[3],
              input_mflow_0.y*eta[2]/eta[3],input_mflow_0.y} "Mass flow rate" 
            annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-100,
                    20},{-80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
            m_flow_IN_var_1[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuDFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-50,
                    20},{-30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
            m_flow_IN_var_2[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
            m_flow_IN_con_3[n](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuUFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{10,
                    20},{30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
            m_flow_IN_var_3[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
            m_flow_IN_con_4[n](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuUFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{60,
                    20},{80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
            m_flow_IN_var_4[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{80,20},{100,40}})));

          //output variables
          Modelica.SIunits.ReynoldsNumber Re_1[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_3[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_4[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

        protected
          parameter Real frac_dtoL=d_hyd/L;

          Modelica.SIunits.ReynoldsNumber Re=Re_1[1] "Reynolds number";
          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";
        public
          Modelica.Blocks.Sources.Ramp input_mflow_0(
            offset=0,
            startTime=0,
            duration=1,
            height=1e4) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(
            amplitude=100,
            offset=0,
            phase=0,
            startTime=0,
            freqHz=1/100) annotation (extent=[-40, -80; -20, -60],Placement(
                transformation(extent={{-40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            offset=0,
            outMax=100,
            riseTime=1e-1,
            riseTimeConst=1e-1,
            startTime=0) annotation (extent=[0, -80; 20, -60], Placement(transformation(
                  extent={{0,-80},{20,-60}})));

        equation
          //heat transfer calculation
          for i in 1:n loop
            (,,Re_1[i],Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_3[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall(
              m_flow_IN_con_3[i], m_flow_IN_var_3[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_4[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall(
              m_flow_IN_con_4[i], m_flow_IN_var_4[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/straightPipe/kc_overall.mos"
                "Verification of kc_overall"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of straight pipe for OVERALL flow regime"),
                  Text(
                  extent={{-104,14},{-58,6}},
                  lineColor={0,0,255},
                  textString="UWT+DFF"),Text(
                  extent={{-52,20},{-6,12}},
                  lineColor={0,0,255},
                  textString="UHF + DFF"),Text(
                  extent={{6,12},{52,4}},
                  lineColor={0,0,255},
                  textString="UWT+UFF"),Text(
                  extent={{56,20},{102,12}},
                  lineColor={0,0,255},
                  textString="UHF + UFF")}),
            experiment(StopTime=1.01, Tolerance=1e-005));
        end kc_overall;

        model kc_overall_KC "Verification of function kc_mean_overall_KC"
          parameter Integer n=size(cp, 1);

          //straight pipe variables
          parameter Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
          parameter Modelica.SIunits.Length L=1 "Length of straight pipe";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for inverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow_1[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_2[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_3[3](start=ones(n)*1e-6);
          Modelica.SIunits.MassFlowRate m_flow_4[3](start=ones(n)*1e-6);

          Modelica.SIunits.CoefficientOfHeatTransfer kc_1[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_2[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_3[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};
          Modelica.SIunits.CoefficientOfHeatTransfer kc_4[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
            m_flow_IN_con_1[3](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-100,
                    20},{-80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
            m_flow_IN_var_1[3](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_1) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
            m_flow_IN_con_2[3](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuDFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{-50,
                    20},{-30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
            m_flow_IN_var_2[3](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_2) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
            m_flow_IN_con_3[3](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuUFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{10,
                    20},{30,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
            m_flow_IN_var_3[3](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_3) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
            m_flow_IN_con_4[3](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2,
            each target=Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuUFF) 
            annotation (extent=[-10, 20; 10, 40], Placement(transformation(extent={{60,
                    20},{80,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
            m_flow_IN_var_4[3](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_4) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{80,20},{100,40}})));

          Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_3[n]={abs(m_flow_3[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_4[n]={abs(m_flow_4[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd^2/4) for i in 1:n};

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e4,
            offset=5) annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{52,-80},{72,-60}})));

        equation
          //heat transfer calculation
          kc_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};
          kc_2 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
            m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};
          kc_3 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
            m_flow_IN_con_3[i], m_flow_IN_var_3[i]) for i in 1:n};
          kc_4 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
            m_flow_IN_con_4[i], m_flow_IN_var_4[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/straightPipe/kc_overall_KC.mos"
                "Verification of kc_overall_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString="Heat transfer of straight pipe for OVERALL flow regime "),
                  Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{-102,12},{-56,4}},
                  lineColor={0,0,255},
                  textString="UWT+DFF"),Text(
                  extent={{-52,18},{-6,10}},
                  lineColor={0,0,255},
                  textString="UHF + DFF"),Text(
                  extent={{6,10},{52,2}},
                  lineColor={0,0,255},
                  textString="UWT+UFF"),Text(
                  extent={{56,18},{102,10}},
                  lineColor={0,0,255},
                  textString="UHF + UFF")}),
            experiment(StopTime=1.01, Tolerance=1e-005));
        end kc_overall_KC;

        model kc_turbulent "Verification of function kc_turbulent"

          parameter Integer n=size(cp, 1);

          //straight pipe variables
          parameter Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
          parameter Modelica.SIunits.Length L=1 "Length of straight pipe";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //input VARIABLES
          //create identical Reynolds number for different fluid properties >> adjustment of  mass flow rate
          Modelica.SIunits.MassFlowRate m_flow[:]={input_mflow_0.y*eta[1]/eta[3],
              input_mflow_0.y*eta[2]/eta[3],input_mflow_0.y} "Mass flow rate" 
            annotation (Dialog(group="Input"));

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=1) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_var
            m_flow_IN_var_1[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-40,20},{-20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{20,20},{40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_var
            m_flow_IN_var_2[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{40,20},{60,40}})));

          //output variables
          Modelica.SIunits.ReynoldsNumber Re_1[n] "Reynolds number" 
            annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_1[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));
          Modelica.SIunits.NusseltNumber Nu_2[n] "Nussel number" 
                                                   annotation (Dialog(group="Output"));

        protected
          parameter Real frac_dtoL=d_hyd/L;

          Modelica.SIunits.ReynoldsNumber Re=Re_1[1] "Reynolds number";
          Modelica.SIunits.PrandtlNumber Pr[n]={eta[i]*cp[i]/lambda[i] for i in 
                  1:n} "Prandtl number";
        public
          Modelica.Blocks.Sources.Ramp input_mflow_0(
            offset=0,
            startTime=0,
            duration=1,
            height=1e4) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(
            amplitude=100,
            offset=0,
            phase=0,
            startTime=0,
            freqHz=1) annotation (extent=[-40, -80; -20, -60], Placement(transformation(
                  extent={{-40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            offset=0,
            outMax=100,
            riseTime=1e-1,
            riseTimeConst=1e-1,
            startTime=0) annotation (extent=[0, -80; 20, -60], Placement(transformation(
                  extent={{0,-80},{20,-60}})));

        equation
          //heat transfer calculation
          //neglecting surface roughness
          for i in 1:n loop
            (,,Re_1[i],Nu_1[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent(
              m_flow_IN_con_1[i], m_flow_IN_var_1[i]);
          end for;

          for i in 1:n loop
            (,,,Nu_2[i],) =
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent(
              m_flow_IN_con_2[i], m_flow_IN_var_2[i]);
          end for;

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/straightPipe/kc_turbulent.mos"
                "Verification of kc_turbulent"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer in straight pipe for turbulent flow regime ")}),
            experiment(StopTime=1.01, Tolerance=1e-005));
        end kc_turbulent;

        model kc_turbulent_KC "Verification of function kc_turbulent_KC"

          parameter Integer n=size(cp, 1);

          //straight pipe variables
          parameter Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
          parameter Modelica.SIunits.Length L=1 "Length of straight pipe";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp[
            :]={1007,4189,3384.550}
            "Specific heat capacity at constant pressure of fluid";
          parameter Modelica.SIunits.DynamicViscosity eta[:]={18.24e-6,
              1001.6e-6,0.114} "Dynamic viscosity of fluid";
          parameter Modelica.SIunits.ThermalConductivity lambda[:]={25.69e-3,
              598.5e-3,0.387} "Thermal conductivity of fluid";
          parameter Modelica.SIunits.Density rho[:]={1.188,998.21,1037.799}
            "Density of fluid";

          //here: Nusselt number as input for reverse calculation
          Modelica.SIunits.NusseltNumber Nu[n]=ones(n)*input_Nu.y;
          Modelica.SIunits.MassFlowRate m_flow_1[3](start=ones(n)*1e-1);
          Modelica.SIunits.MassFlowRate m_flow_2[3](start=ones(n)*1);
          Modelica.SIunits.CoefficientOfHeatTransfer kc[n]={Nu[i]*lambda[i]/
              d_hyd for i in 1:n};

          //input record
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=1) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-60,20},{-40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_var
            m_flow_IN_var_1[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_1) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{-40,20},{-20,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_con
            m_flow_IN_con_2[n](
            each d_hyd=d_hyd,
            each L=L,
            each roughness=2) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{20,20},{40,40}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_var
            m_flow_IN_var_2[n](
            cp=cp,
            eta=eta,
            lambda=lambda,
            rho=rho,
            m_flow=m_flow_2) annotation (extent=[-10, 20; 10, 40], Placement(
                transformation(extent={{40,20},{60,40}})));

          Modelica.SIunits.ReynoldsNumber Re_1[n]={abs(m_flow_1[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};
          Modelica.SIunits.ReynoldsNumber Re_2[n]={abs(m_flow_2[i])*d_hyd/(eta[
              i]*Modelica.Constants.pi*d_hyd*d_hyd/4) for i in 1:n};

        public
          Modelica.Blocks.Sources.Ramp input_Nu(
            startTime=0,
            duration=1,
            height=1e3 - 600,
            offset=600) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{48,-80},{68,-60}})));

        equation
          //heat transfer calculation
          //neglecting surface roughness
          kc = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC(
            m_flow_IN_con_1[i], m_flow_IN_var_1[i]) for i in 1:n};

          //considered surface roughness
          kc = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC(
            m_flow_IN_con_2[i], m_flow_IN_var_2[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/straightPipe/kc_turbulent_KC.mos"
                "Verification of kc_turbulent_KC"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,5},{100,0}},
                  lineColor={0,0,255},
                  textString="Target: kc == f(m_flow)"),Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "Here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{-100,52},{100,77}},
                  lineColor={0,0,255},
                  textString=
                    "Heat transfer in straight pipe for turbulent flow regime considering surface roughness")}),
            experiment(StopTime=1.01, Tolerance=1e-005));
        end kc_turbulent_KC;

        model kc_twoPhaseOverall_KC
          "Verification of function kc_twoPhaseOverall_KC"
          import Modelica.Math.log10;
          parameter Integer n=size(m_flow_1, 1);
          parameter Integer m=size(m_flow_3, 1);

          //boiling in a horizontal pipe (KC=1)
          parameter Modelica.SIunits.Diameter d_hyd_1=0.01092;
          parameter Modelica.SIunits.Area A_cross_1=Modelica.Constants.pi*
              d_hyd_1^2/4;
          parameter Modelica.SIunits.Length perimeter_1=Modelica.Constants.pi*
              d_hyd_1;

          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure
            cp_1[n]={1341.222455,1341.222455,1341.222455,1346,1346,1346};
          parameter Modelica.SIunits.DynamicViscosity eta_l_1[n]={
              0.2589963793e-3,0.2589963793e-3,0.2589963793e-3,0.181e-3,0.181e-3,
              0.181e-3};
          parameter Modelica.SIunits.DynamicViscosity eta_g_1[n]={1.1732415e-5,
              1.1732415e-5,1.1732415e-5,1.172546e-5,1.172546e-5,1.172546e-5};
          parameter Modelica.SIunits.ThermalConductivity lambda_1[n]={
              0.09296757,0.09296757,0.09296757,0.0816653,0.0816653,0.0816653};
          parameter Modelica.SIunits.Density rho_l_1[n]={1280.569453,
              1280.569453,1280.569453,1164,1164,1164};
          parameter Modelica.SIunits.Density rho_g_1[n]={16.89048514,
              16.89048514,16.89048514,32.9,32.9,32.9};
          parameter Modelica.SIunits.MolarMass M_1[n]={102.032,102.032,102.032,
              97.6,97.6,97.6};
          parameter Modelica.SIunits.SpecificEnthalpy dh_lg_1[n]={193865.4,
              193865.4,193865.4,166298.02,166298.02,166298.02};
          parameter Modelica.SIunits.HeatFlux qdot_A_1[n]={5000,4000,1200,10000,
              7000,5000};
          parameter Modelica.SIunits.Pressure p_1[n]={342402.623,342402.623,
              342402.623,660500,660500,660500};
          parameter Modelica.SIunits.Pressure p_crit_1[n]={4056000,4056000,
              4056000,3732000,3732000,3732000};
          Modelica.SIunits.MassFlowRate m_flow_1[6]={0.028003115,0.018637525,
              0.009365590,0.009552902,0.009552902,0.009552902};
          Real mdot_A1[n]={m_flow_1[i]/A_cross_1 for i in 1:n};

          //boiling in a vertical pipe (KC=2)
          parameter Modelica.SIunits.Diameter d_hyd_2=0.0061;
          parameter Modelica.SIunits.Area A_cross_2=Modelica.Constants.pi*
              d_hyd_2^2/4;
          parameter Modelica.SIunits.Length perimeter_2=Modelica.Constants.pi*
              d_hyd_2;

          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure
            cp_2=1128.7126;
          parameter Modelica.SIunits.DynamicViscosity eta_l_2=0.000264104448;
          parameter Modelica.SIunits.DynamicViscosity eta_g_2=1.126785138e-5;
          parameter Modelica.SIunits.ThermalConductivity lambda_2=0.107525;
          parameter Modelica.SIunits.Density rho_l_2=1334.01138;
          parameter Modelica.SIunits.MolarMass M_2=86.47;
          parameter Modelica.SIunits.Density rho_g_2=12.8808;
          parameter Modelica.SIunits.SpecificEnthalpy dh_lg_2=216811.5384;
          parameter Modelica.SIunits.HeatFlux qdot_A_2=10000;
          parameter Modelica.SIunits.Pressure p_2=295700;
          parameter Modelica.SIunits.Pressure p_crit_2=4986000;
          Modelica.SIunits.MassFlowRate m_flow_2=0.011689866;

          //condensation in a horizontal pipe (KC=3)
          parameter Modelica.SIunits.Diameter d_hyd_3=0.00704;
          parameter Modelica.SIunits.Area A_cross_3=Modelica.Constants.pi*
              d_hyd_3^2/4;
          parameter Modelica.SIunits.Length perimeter_3=Modelica.Constants.pi*
              d_hyd_3;

          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure
            cp_3[m]={1301.76461,1902.75,1301.76461,1471,1471,1471};
          parameter Modelica.SIunits.DynamicViscosity eta_l_3[m]={
              0.0001889385508,0.106e-3,0.0001889385508,0.0001734,0.0001734,
              0.0001734};
          parameter Modelica.SIunits.ThermalConductivity lambda_3[m]={0.082775,
              0.0825,0.082775,0.07798,0.07798,0.07798};
          parameter Modelica.SIunits.Density rho_l_3[m]={1153.0466,1016.75,
              1153.0466,1167.5,1167.5,1167.5};
          parameter Modelica.SIunits.Pressure p_3[m]={1354785.871,2189950,
              1354785.871,886980,886980,886980};
          parameter Modelica.SIunits.Pressure p_crit_3[m]={4977400,4893000,
              4977400,4056000,4056000,4056000};
          Modelica.SIunits.MassFlowRate m_flow_3[6]={0.0087583,0.02530163,
              0.02530163,0.02530163,0.01167768,0.00291942};

          //mass flow rate quality from 0 to 1
          Modelica.SIunits.MassFraction x_flow=input_x_0.y
            "Mass flow rate quality";

          //plotting
          Modelica.SIunits.NusseltNumber Nu_1[n]={kc_1[i]*d_hyd_1/lambda_1[i] 
              for i in 1:n} "Local Nusselt number";
          Modelica.SIunits.NusseltNumber NU_2=kc_2*d_hyd_2/lambda_2
            "Local Nusselt number";
          Modelica.SIunits.NusseltNumber Nu_3[m]={kc_3[i]*d_hyd_3/lambda_3[i] 
              for i in 1:m} "Local Nusselt number";

          //input records
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_con
            IN_con_1[n](
            each target=Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor,
            each A_cross=A_cross_1,
            each perimeter=perimeter_1,
            p_crit=p_crit_1,
            MM=M_1) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_var
            IN_var_1[n](
            each target=Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor,
            cp_l=cp_1,
            eta_l=eta_l_1,
            eta_g=eta_g_1,
            lambda_l=lambda_1,
            rho_l=rho_l_1,
            rho_g=rho_g_1,
            each x_flow=x_flow,
            qdot_A=qdot_A_1,
            dh_lg=dh_lg_1,
            m_flow=m_flow_1,
            pressure=p_1) 
            annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_con
            IN_con_2(
            each target=Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer,
            each A_cross=A_cross_2,
            each perimeter=perimeter_2,
            p_crit=p_crit_2,
            MM=M_2) annotation (Placement(transformation(extent={{-30,0},{-10,20}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_var
            IN_var_2(
            each target=Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer,
            cp_l=cp_2,
            eta_l=eta_l_2,
            eta_g=eta_g_2,
            lambda_l=lambda_2,
            rho_l=rho_l_2,
            rho_g=rho_g_2,
            each x_flow=x_flow,
            qdot_A=qdot_A_2,
            each dh_lg=dh_lg_2,
            m_flow=m_flow_2,
            pressure=p_2) 
            annotation (Placement(transformation(extent={{-10,0},{10,20}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_con
            IN_con_3[m](
            each target=Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.CondHor,
            each A_cross=A_cross_3,
            each perimeter=perimeter_3,
            p_crit=p_crit_3) 
            annotation (Placement(transformation(extent={{20,0},{40,20}})));

          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_var
            IN_var_3[m](
            each target=Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.CondHor,
            cp_l=cp_3,
            eta_l=eta_l_3,
            lambda_l=lambda_3,
            rho_l=rho_l_3,
            each x_flow=x_flow,
            m_flow=m_flow_3,
            pressure=p_3) 
            annotation (Placement(transformation(extent={{40,0},{60,20}})));

          //output variables
          Modelica.SIunits.CoefficientOfHeatTransfer kc_1[n];
          Modelica.SIunits.CoefficientOfHeatTransfer kc_2;
          Modelica.SIunits.CoefficientOfHeatTransfer kc_3[m];

          Modelica.Blocks.Sources.Ramp input_x_0(duration=1, height=1) 
            annotation (Placement(transformation(extent={{-60,-38},{-40,-18}})));
          Modelica.Blocks.Sources.Sine input_x_1(freqHz=1, amplitude=100) 
            annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
          Modelica.Blocks.Sources.Exponentials input_x_2(
            riseTimeConst=1e-1,
            outMax=100,
            riseTime=1e-1) 
            annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
          Modelica.Blocks.Sources.Ramp input_mflow_0(duration=1, height=100) 
            annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1(freqHz=1, amplitude=100) 
            annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
          Modelica.Blocks.Sources.Exponentials input_mflow_2(
            outMax=100,
            riseTime=1e-1,
            riseTimeConst=1e-1) 
            annotation (Placement(transformation(extent={{20,-80},{40,-60}})));

        equation
          kc_1 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC(
            IN_con_1[i], IN_var_1[i]) for i in 1:n};
          kc_2 =
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC(
            IN_con_2, IN_var_2);
          kc_3 = {
            Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC(
            IN_con_3[i], IN_var_3[i]) for i in 1:m};
          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/heatTransfer/straightPipe/kc_twoPhaseOverall_KC.mos"),
              Diagram(graphics={Text(
                  extent={{-100,52},{100,77}},
                  lineColor={0,0,255},
                  textString=
                    "Two phase heat transfer in straight pipe for overall  flow regime ")}),
            experiment(StopTime=1.01, Tolerance=1e-005));
        end kc_twoPhaseOverall_KC;
      end StraightPipe;
    end HeatTransfer;

    package PressureLoss "Verification package for pressure loss functions"
    extends Modelica.Icons.ExamplesPackage;
      package Bend
      extends Modelica.Icons.ExamplesPackage;

        model dp_curvedOverall_DPMFLOW
          "Verification of function dp_curvedOverall_DP AND dp_curvedOverall_MFLOW"

          parameter Integer n=size(R_0, 1)
            "Number of different relative curvature radii of bend";
          parameter Integer m=size(delta, 1)
            "Number of different angles of turning of bend";

          //bend variables
          parameter Modelica.SIunits.Area A_cross=Modelica.Constants.pi*d_hyd^2
              /4 "Circular cross sectional area of bend";
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg delta[3]=
              {30,45,90} "Angle of turning";
          parameter Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
          parameter Modelica.SIunits.Length K=0
            "Roughness (average height of surface asperities)";
          parameter Modelica.SIunits.Radius R_0[2]={2.26,11.71}*d_hyd
            "Curvature radius";

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid";
          Modelica.SIunits.Density rho=1000 "Density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot_1[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp_1[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW_1[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP_1[n](start=zeros(n))={input_dp_1[i] for 
            i in 1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot_2[m](start=zeros(m))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp_2[m](start=zeros(m))=ones(m)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW_2[m](start=zeros(m))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP_2[m](start=zeros(m))={input_dp_2[i] for 
            i in 1:m}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con
            m_flow_IN_con_1[n](
            each d_hyd=d_hyd,
            each delta=delta[3],
            R_0=R_0,
            each K=K) annotation (extent=[-60, 12; -40, 32], Placement(transformation(
                  extent={{-100,20},{-80,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var
            m_flow_IN_var_1[n](each eta=eta, each rho=rho) 
                                         annotation (extent=[-60, 12; -40, 32],
              Placement(transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con
            m_flow_IN_con_2[m](
            each d_hyd=d_hyd,
            each K=K,
            delta=delta,
            each R_0=2.26*d_hyd) annotation (extent=[-60, 12; -40, 32], Placement(
                transformation(extent={{10,20},{30,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var
            m_flow_IN_var_2[m](each eta=eta, each rho=rho) 
                                         annotation (extent=[-60, 12; -40, 32],
              Placement(transformation(extent={{30,20},{50,40}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con
            dp_IN_con_1[n](
            each d_hyd=d_hyd,
            each delta=delta[3],
            each K=K,
            R_0=R_0) annotation (extent=[40, 12; 60, 32], Placement(transformation(
                  extent={{-50,20},{-30,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var
            dp_IN_var_1[n](each eta=eta, each rho=rho) 
                                          annotation (extent=[40, 12; 60, 32],
              Placement(transformation(extent={{-30,20},{-10,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con
            dp_IN_con_2[m](
            delta=delta,
            each d_hyd=d_hyd,
            each K=K,
            each R_0=2.26*d_hyd) annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{60,20},{80,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var
            dp_IN_var_2[m](each eta=eta, each rho=rho) 
                                          annotation (extent=[40, 12; 60, 32],
              Placement(transformation(extent={{80,20},{100,40}})));

        protected
          parameter Real frac_RD[n]={R_0[i]/d_hyd for i in 1:n}
            "Relative curvature radius";

          //plotting
          Modelica.SIunits.Velocity velocity_1[n]={input_mdot_1[i]/(rho*A_cross) 
              for i in 1:n} "Mean velocity";
          Modelica.SIunits.ReynoldsNumber Re_1[n]={rho*velocity_1[i]*d_hyd/eta 
              for i in 1:n};
          Modelica.SIunits.Velocity velocity_2[m]={input_mdot_2[i]/(rho*A_cross) 
              for i in 1:m} "Mean velocity";
          Modelica.SIunits.ReynoldsNumber Re_2[m]={rho*velocity_2[i]*d_hyd/eta 
              for i in 1:m};

          Real DP_plot_1[n]={DP_1[i] for i in 1:n} "Pressure loss [Pa]";
          Real DP_plot_2[m]={DP_2[i] for i in 1:m} "Pressure loss [Pa]";
          Real zeta_TOT_1[n]={2*abs(DP_plot_1[i])/(max(rho*(velocity_1[i])^2, 1e-5)) 
              for i in 1:n} "Pressure loss coefficients";
          Real zeta_TOT_2[m]={2*abs(DP_plot_2[i])/(max(rho*(velocity_2[i])^2, 1e-5)) 
              for i in 1:m} "Pressure loss coefficients";

        public
          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            duration=1,
            offset=1e-3,
            height=1.2e4) annotation (extent=[-80, -80; -60, -60],Placement(
                transformation(extent={{60,-80},{80,-60}})));

        equation
          //target == DP (incompressible)
          DP_1 = {
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP(
                    m_flow_IN_con_1[i],
                    m_flow_IN_var_1[i],
                    input_mdot_1[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW_1 = {
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
                    dp_IN_con_1[i],
                    dp_IN_var_1[i],
                    input_dp_1[i]) for i in 1:n};

          //target == DP (incompressible)
          DP_2 = {
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP(
                    m_flow_IN_con_2[i],
                    m_flow_IN_var_2[i],
                    input_mdot_2[i]) for i in 1:m};

          //target == M_FLOW (compressible)
          M_FLOW_2 = {
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
                    dp_IN_con_2[i],
                    dp_IN_var_2[i],
                    input_dp_2[i]) for i in 1:m};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/bend/dp_curvedOverall_DPMFLOW.mos"
                "Verification of dp_overall_DPMFLOW"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of CURVED bend for OVERALL flow regime (considering surface roughness | inverse)"),
                  Text(
                  extent={{-103,22},{-12,2}},
                  lineColor={0,0,255},
                  textString=
                    "relative curvature radius dependence | constant angle of turning "),
                  Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{13,22},{104,2}},
                  lineColor={0,0,255},
                  textString=
                    "constant relative curvature radius | angle of turning dependence")}),
            experiment(StopTime=1.01, Tolerance=1e-005));
        end dp_curvedOverall_DPMFLOW;

        model dp_edgedOverall_DPMFLOW
          "Verification of function dp_edgedOverall_DP AND dp_edged_Overall_MFLOW"

          constant Real MIN=Modelica.Constants.eps;

          parameter Integer n=size(delta, 1)
            "Number of different angles of turning of bend";

          //bend variables
          parameter Modelica.SIunits.Area A_cross=Modelica.Constants.pi*d_hyd^2
              /4 "Circular cross sectional area of bend";
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg delta[4]=
              {30,45,90,180} "Angle of turning";
          parameter Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
          parameter Modelica.SIunits.Length K=2e-5
            "Roughness (average height of surface asperities)";

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid";
          Modelica.SIunits.Density rho=1000 "Density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con
            m_flow_IN_con[n](
            delta=delta,
            each d_hyd=d_hyd,
            each K=K) annotation (extent=[-60, 12; -40, 32], Placement(transformation(
                  extent={{-70,20},{-50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var
            m_flow_IN_var[n](each eta=eta, each rho=rho) 
                                          annotation (extent=[-60, 12; -40, 32],
              Placement(transformation(extent={{-50,20},{-30,40}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con
            dp_IN_con[n](
            delta=delta,
            each d_hyd=d_hyd,
            each K=K) annotation (extent=[40, 12; 60, 32], Placement(transformation(
                  extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var
            dp_IN_var[n](each eta=eta, each rho=rho) 
                                     annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{50,20},{70,40}})));

          //plotting
          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";
          Modelica.SIunits.Velocity velocity[n]={input_mdot[i]/(rho*A_cross) 
              for i in 1:n} "Mean velocity";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho*velocity[i]*d_hyd/eta for 
              i in 1:n};
          Real zeta_TOT[n]={2*abs(DP_plot[i])/(max(rho*(velocity[i])^2, 1e-5)) for i in 
                  1:n} "Pressure loss coefficients";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            duration=1,
            offset=1e-4,
            height=276270) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));

        equation
          //target == DP (incompressible)
          DP = {Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/bend/dp_edgedOverall_DPMFLOW.mos"
                "Verification of dp_edgedOverall_DPMFLOW"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of EDGED bend for OVERALL flow regime (considering surface roughness | inlining)"),
                  Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)")}));
        end dp_edgedOverall_DPMFLOW;
      end Bend;

      package Channel
      extends Modelica.Icons.ExamplesPackage;

        model dp_internalFlowOverall_DPMFLOW
          "Verification of function dp_internalFlowOverall_DP AND dp_internalFlowOverall_MFLOW"

          parameter Integer n=size(geometry, 1)
            "Number of different geometries";

          //channel variables
          Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=
              Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered
            "Choice of considering surface roughness";
          Modelica.SIunits.Length K=0
            "Roughness (average height of surface asperities)";
          Modelica.SIunits.Length L=1 "Length";
          Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow
            geometry[5]={1,2,3,4,5} "Choice of geometry for internal flow";
          Modelica.SIunits.Diameter d_ann=d_hyd "Small diameter";
          Modelica.SIunits.Diameter D_ann=2*d_ann "Large diameter";
          Modelica.SIunits.Diameter d_cir=d_hyd "Internal diameter";
          Modelica.SIunits.Length a_ell=(3/4)*d_hyd
            "Half length of long base line";
          Modelica.SIunits.Length b_ell=0.5*a_ell
            "Half length of short base line";
          Modelica.SIunits.Length a_rec=d_hyd "Horizontal length";
          Modelica.SIunits.Length b_rec=a_rec "Vertical length";
          Modelica.SIunits.Length a_tri=d_hyd*(1 + 2^0.5) "Length of base line";
          Modelica.SIunits.Length h_tri=0.5*a_tri
            "Heigth to top angle perpendicular to base line";
          Real beta=tan((a_tri)/2/h_tri) "Top angle";

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid";
          Modelica.SIunits.Density rho=1000 "Density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot_1[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp_1[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW_1[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP_1[n](start=zeros(n))={input_dp_1[i] for 
            i in 1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_con
            m_flow_IN_con_1[n](
            each roughness=roughness,
            geometry=geometry,
            each d_ann=d_ann,
            each D_ann=D_ann,
            each d_cir=d_cir,
            each a_ell=a_ell,
            each b_ell=b_ell,
            each a_rec=a_rec,
            each b_rec=b_rec,
            each a_tri=a_tri,
            each h_tri=h_tri,
            each beta=beta,
            each K=K,
            each L=L) annotation (extent=[-60, 12; -40, 32], Placement(transformation(
                  extent={{-50,20},{-30,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_var
            m_flow_IN_var_1[n](each eta=eta, each rho=rho) annotation (extent=[-60, 12;
                -40, 32], Placement(transformation(extent={{-30,20},{-10,40}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_con
            dp_IN_con_1[n](
            each roughness=roughness,
            geometry=geometry,
            each K=K,
            each L=L,
            each d_ann=d_ann,
            each D_ann=D_ann,
            each d_cir=d_cir,
            each a_ell=a_ell,
            each b_ell=b_ell,
            each a_rec=a_rec,
            each b_rec=b_rec,
            each a_tri=a_tri,
            each h_tri=h_tri,
            each beta=beta) annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{10,20},{30,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_var
            dp_IN_var_1[n](each eta=eta, each rho=rho) annotation (extent=[40, 12; 60,
                32], Placement(transformation(extent={{30,20},{50,40}})));

        protected
          Real MIN=Modelica.Constants.eps;

          Modelica.SIunits.Area A_crossT[n]={max(MIN, if geometry[i] == 1 then 
              (Modelica.Constants.pi/4)*((D_ann)^2 - (d_ann)^2) else if 
              geometry[i] == 2 then Modelica.Constants.pi/4*(d_cir)^2 else if 
              geometry[i] == 3 then Modelica.Constants.pi*a_ell*b_ell else if 
              geometry[i] == 4 then a_rec*b_rec else if geometry[i] == 5 then 
              0.5*(a_tri*h_tri) else 0) for i in 1:n} "Cross sectional area";
          Modelica.SIunits.Length perimeterT[n]={max(MIN, if geometry[i] == 1 then 
                    Modelica.Constants.pi*(D_ann + d_ann) else if geometry[i]
               == 2 then Modelica.Constants.pi*d_cir else if geometry[i] == 3 then 
                    Modelica.Constants.pi*(2*((a_ell)^2) + (b_ell)^2)^0.5 else 
              if geometry[i] == 4 then 2*(a_rec + b_rec) else if geometry[i]
               == 5 then a_tri + 2*((h_tri)^2 + (a_tri/2)^2)^0.5 else 0) for i in 
                  1:n} "Perimeter";
          Modelica.SIunits.Diameter d_hydT[n]={4*A_crossT[i]/perimeterT[i] for 
              i in 1:n} "Hydraulic diameter";
          Modelica.SIunits.Area A_cross=(Modelica.Constants.pi/4)*d_hyd^2;
          Modelica.SIunits.Diameter d_hyd=0.1;
          Modelica.SIunits.Diameter perimeter=4*A_cross/d_hyd;

          Modelica.SIunits.Velocity velocity_1[n]={input_mdot_1[i]/(rho*
              A_crossT[i]) for i in 1:n} "Mean velocity";
          Modelica.SIunits.ReynoldsNumber Re_1[n]={rho*velocity_1[i]*d_hyd/eta 
              for i in 1:n};

          Real DP_plot_1[n]={DP_1[i] for i in 1:n} "Pressure loss [Pa]";
          Real zeta_TOT_1[n]={2*abs(DP_plot_1[i])/(max(rho*(velocity_1[i])^2, MIN)) 
              for i in 1:n} "Pressure loss coefficients";

        public
          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            duration=1,
            height=1.2e4,
            offset=1) annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{60,-80},{80,-60}})));

        equation
          //target == DP (incompressible)
          DP_1 = {
            Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP(
                    m_flow_IN_con_1[i],
                    m_flow_IN_var_1[i],
                    input_mdot_1[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW_1 = {
            Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW(
                    dp_IN_con_1[i],
                    dp_IN_var_1[i],
                    input_dp_1[i]) for i in 1:n};

          annotation (
            Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/channel/dp_internalFlowOverall_DPMFLOW.mos"
                "Verification of dp_internalFlowOverall_DP and dp_internalFlowOverall_MFLOW (inverse)"),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of CHANNEL for OVERALL flow regime (different geometries | inverse)"),
                  Text(
                  extent={{-43,22},{48,2}},
                  lineColor={0,0,255},
                  textString="different geometries as target"),Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(StopTime=1.01),
            experimentSetupOutput);
        end dp_internalFlowOverall_DPMFLOW;
      end Channel;

      package General
      extends Modelica.Icons.ExamplesPackage;

        model dp_idealGas_DPMFLOW
          "Verification of function dp_idealGas_DP and dp_idealGas_MFLOW"

          parameter Integer n=size(dp_nom, 1);

          Real frac_KmToRs[n]={Km[i]/R_s for i in 1:n};

          //general variables
          parameter Real exp=2 "Exponent of pressure loss law" 
            annotation (Dialog(group="Generic variables"));

          parameter Real p_1=1.1e5 "MEASURED pressure at input [Pa]";
          parameter Real dp_nom[3]={0.5e3,2e3,3e3} "Nominal pressure loss [Pa]";
          parameter Real p_2[n]={p_1 - dp_nom[i] for i in 1:n}
            "MEASURED pressure at output [Pa]";

          parameter Real m_flow_nom[n]=ones(n)*10
            "Nominal mass flow rate [kg/s]";
          Real Km[n]={R_s*(p_1 - (p_2[i]))/((m_flow_nom[i])^exp/rho_m) for i in 1:n}
            "Coefficient for pressure loss law [(Pa)^2/{(kg/s)^exp*K}]";

          //fluid property variables
          parameter Modelica.SIunits.SpecificHeatCapacity R_s=287
            "Specific gas constant of ideal gas";
          parameter Modelica.SIunits.Density rho_m=p_m/(R_s*T_m)
            "Mean density of ideal gas";
          parameter Modelica.SIunits.Temp_K T_m=(293 + 293)/2
            "Mean temperature of ideal gas";
          parameter Modelica.SIunits.Pressure p_m=(1e5 + 1e5)/2
            "Mean pressure of ideal gas";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_con
            m_flow_IN_con[n](
            each exp=exp,
            each R_s=R_s,
            Km=Km) annotation (extent=[-10, 12; 10, 34], Placement(transformation(
                  extent={{-70,20},{-50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_var
            m_flow_IN_var[n](
            each rho_m=rho_m,
            each T_m=T_m,
            each p_m=p_m) annotation (extent=[-10, 12; 10, 34], Placement(
                transformation(extent={{-50,20},{-30,42}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_con
            dp_IN_con[n](
            each exp=exp,
            each R_s=R_s,
            Km=Km) annotation (extent=[-10, 12; 10, 34], Placement(transformation(
                  extent={{30,20},{50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_var
            dp_IN_var[n](
            each rho_m=rho_m,
            each T_m=T_m,
            each p_m=p_m) annotation (extent=[-10, 12; 10, 34], Placement(
                transformation(extent={{50,20},{70,42}})));

          //plotting
          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            offset=0,
            duration=1,
            height=30) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));
        equation
          //target == DP (incompressible)
          DP = {Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/general/dp_idealGas_DPMFLOW.mos"
                "Verification of dp_idealGas_DPMFLOW"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of GENERIC geometry (ideal gas law dependence | inverse)"),
                  Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)"),Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(StopTime=1.01));
        end dp_idealGas_DPMFLOW;

        model dp_nominalDensityViscosity_DPMFLOW
          "Verification of function dp_nominalDensityViscosity_DP and dp_nominalDensityViscosity_MFLOW"

          parameter Integer n=size(rho, 1)
            "number of different fluid density values";
          parameter Modelica.SIunits.KinematicViscosity nue=1e-6
            "kinetic viscosity of fluid";

          //general variables
          parameter Modelica.SIunits.Pressure dp_nom=50
            "Nominal pressure loss (at nominal values of mass flow rate and density)"
            annotation (Dialog(group="Generic variables"));
          parameter Real exp=2 "Exponent of pressure loss law" 
            annotation (Dialog(group="Generic variables"));
          parameter Modelica.SIunits.MassFlowRate m_flow_nom=1
            "Nominal mass flow rate (at nominal values of pressure loss and density)"
            annotation (Dialog(group="Generic variables"));
          parameter Modelica.SIunits.Density rho_nom=1e3
            "Nominal density (at nominal values of mass flow rate and pressure loss)"
            annotation (Dialog(group="Generic variables"));
          parameter Real exp_eta=1.5
            "Exponent for dynamic viscosity dependence" 
            annotation (Dialog(group="Generic variables"));
          parameter Modelica.SIunits.DynamicViscosity eta_nom=1e-3
            "Dynamic viscosity at nominal pressure loss" 
            annotation (Dialog(group="Generic variables"));

          //fluid property PARAMETERS
          parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp=
              4190 "specific heat capacity at constant pressure of fluid" 
            annotation (Dialog(group="FluidProperties"));
          Modelica.SIunits.DynamicViscosity eta[:]={rho[i]*nue for i in 1:n}
            "dynamic viscosity of fluid" annotation (Dialog(group="FluidProperties"));
          parameter Modelica.SIunits.ThermalConductivity lambda=0.6
            "thermal conductivity of fluid" 
            annotation (Dialog(group="FluidProperties"));
          Modelica.SIunits.Density rho[:]={1e3,1.5e3,2e3} "density of fluid" 
            annotation (Dialog(group="FluidProperties"));

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n};

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_con
            m_flow_IN_con[n](
            each eta_nom=eta_nom,
            each exp=exp,
            each exp_eta=exp_eta,
            each m_flow_nom=m_flow_nom,
            each dp_nom=dp_nom,
            each rho_nom=rho_nom) annotation (extent=[-10, 12; 10, 34], Placement(
                transformation(extent={{-70,20},{-50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_var
            m_flow_IN_var[n](eta=eta, rho=rho) annotation (extent=[-10, 12; 10, 34],
              Placement(transformation(extent={{-50,20},{-30,42}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_con
            dp_IN_con[n](
            each dp_nom=dp_nom,
            each eta_nom=eta_nom,
            each exp=exp,
            each exp_eta=exp_eta,
            each m_flow_nom=m_flow_nom,
            each rho_nom=rho_nom) annotation (extent=[-10, 12; 10, 34], Placement(
                transformation(extent={{30,20},{50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_var
            dp_IN_var[n](eta=eta, rho=rho) annotation (extent=[-10, 12; 10, 34],
              Placement(transformation(extent={{50,20},{70,42}})));

          //plotting
          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            offset=0,
            duration=1,
            height=5e5) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));
        equation
          //target == DP (incompressible)
          DP = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/general/dp_nominalDensityViscosity_DPMFLOW.mos"
                "Verification of dp_nominalDensityViscosity_DPMFLOW"), Diagram(
                coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                    100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of GENERIC geometry (density and viscosity dependence | inverse)"),
                  Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)")}),
            experiment(StopTime=1.01));
        end dp_nominalDensityViscosity_DPMFLOW;

        model dp_nominalPressureLossLawDensity_DPMFLOW
          "Verification of function dp_nominalPressureLossLawDensity_DP and dp_nominalPressureLossLawDensity_MFLOW"

          parameter Integer n=size(rho, 1)
            "number of different fluid density values";

          //general variables
          Modelica.SIunits.Area A_cross=A_cross_nom "Cross sectional area" 
            annotation (Dialog(group="Generic variables"));
          Modelica.SIunits.Area A_cross_nom=Modelica.Constants.pi*0.1^2/4
            "Nominal cross sectional area" 
            annotation (Dialog(group="Generic variables"));
          Modelica.SIunits.Pressure dp_nom=50
            "Nominal pressure loss (at nominal values of mass flow rate and density)"
            annotation (Dialog(group="Generic variables"));
          Modelica.SIunits.MassFlowRate m_flow_nom=1
            "Nominal mass flow rate (at nominal values of pressure loss and density)"
            annotation (Dialog(group="Generic variables"));
          Real exp=2 "Exponent of pressure loss law" 
            annotation (Dialog(group="Generic variables"));
          Integer NominalMassFlowRate=1
            "true == use nominal mass flow rate | false == nominal volume flow rate"
            annotation (Dialog(group="Generic variables"));
          Modelica.SIunits.VolumeFlowRate V_flow_nom=m_flow_nom/rho_nom
            "Nominal volume flow rate (at nominal values of pressure loss and density)"
            annotation (Dialog(group="Generic variables"));
          Modelica.Fluid.Dissipation.Utilities.Types.PressureLossCoefficient
            zeta_TOT=0.05*1/0.1 "Pressure loss coefficient" 
                                        annotation (Dialog(group="Generic variables"));
          Modelica.Fluid.Dissipation.Utilities.Types.PressureLossCoefficient
            zeta_TOT_nom=1
            "Nominal pressure loss coefficient (for nominal values)" 
            annotation (Dialog(group="Generic variables"));
          Modelica.SIunits.Density rho_nom=1e3
            "Nominal density (at nominal values of mass flow rate and pressure loss)"
            annotation (Dialog(group="Generic variables"));

          //fluid property variables
          Modelica.SIunits.Density rho[:]={1e3,1.5e3,2e3} "density of fluid" 
            annotation (Dialog(group="FluidProperties"));

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con
            m_flow_IN_con[n](
            each exp=exp,
            each m_flow_nom=m_flow_nom,
            each A_cross=A_cross,
            each A_cross_nom=A_cross_nom,
            each dp_nom=dp_nom,
            each V_flow_nom=V_flow_nom,
            each zeta_TOT_nom=zeta_TOT_nom,
            each rho_nom=rho_nom) annotation (extent=[40, 20; 60, 42], Placement(
                transformation(extent={{-70,20},{-50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var
            m_flow_IN_var[n](each zeta_TOT=zeta_TOT, rho=rho) annotation (extent=[40,
                20; 60, 42], Placement(transformation(extent={{-50,20},{-30,42}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con
            dp_IN_con[n](
            each exp=exp,
            each m_flow_nom=m_flow_nom,
            each rho_nom=rho_nom,
            each A_cross=A_cross,
            each A_cross_nom=A_cross_nom,
            each dp_nom=dp_nom,
            each V_flow_nom=V_flow_nom,
            each zeta_TOT_nom=zeta_TOT_nom) annotation (extent=[-60, 20; -40, 42],
              Placement(transformation(extent={{30,20},{50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var
            dp_IN_var[n](rho=rho, each zeta_TOT=zeta_TOT) annotation (extent=[-60, 20;
                -40, 42], Placement(transformation(extent={{50,20},{70,42}})));

          //plotting
          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            offset=0,
            duration=1,
            height=2.5e5) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));
        equation
          //target == DP (incompressible)
          DP = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/general/dp_nominalPressureLossLawDensity_DPMFLOW.mos"
                "Verification of dp_nominalPressureLossLawDensity_DPMFLOW"), Diagram(
                coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of GENERIC geometry (pressure loss law dependence | inverse)"),
                  Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)"),Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(
              StopTime=1.01,
              NumberOfIntervals=5000,
              Tolerance=1e-005));
        end dp_nominalPressureLossLawDensity_DPMFLOW;

        model dp_pressureLossCoefficient_DPMFLOW
          "Verification of function dp_pressureLossCoefficient_DP and dp_pressureLossCoefficient_MFLOW"

          //general variables
          parameter Integer n=3 "Number of grid points";

          parameter Modelica.SIunits.Area A_cross=Modelica.Constants.pi*0.1^2/4
            "Circular cross sectional area";
          parameter
            Modelica.Fluid.Dissipation.Utilities.Types.PressureLossCoefficient
            zeta_TOT[n]={0.01,0.1,1} "Pressure loss coefficient";

          //fluid property variables
          Modelica.SIunits.Density rho=1.2 "Density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_con
            m_flow_IN_con[n](each A_cross=A_cross) annotation (extent=[-10, 12; 10, 34],
              Placement(transformation(extent={{-70,20},{-50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_var
            m_flow_IN_var[n](each rho=rho, zeta_TOT=zeta_TOT) annotation (extent=[-10,
                12; 10, 34], Placement(transformation(extent={{-50,20},{-30,42}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_con
            dp_IN_con[n](each A_cross=A_cross) annotation (extent=[-10, 12; 10, 34],
              Placement(transformation(extent={{30,20},{50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_var
            dp_IN_var[n](each rho=rho, zeta_TOT=zeta_TOT) annotation (extent=[-10, 12;
                10, 34], Placement(transformation(extent={{50,20},{70,42}})));

          //plotting
          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            offset=0,
            duration=1,
            height=6757) annotation (extent=[-80, -80; -60, -60],Placement(
                transformation(extent={{60,-80},{80,-60}})));

        equation
          //target == DP (incompressible)
          DP = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/general/dp_pressureLossCoefficient_DPMFLOW.mos"
                "Verification of dp_pressureLossCoefficient_DP and dp_pressureLossCoefficient_MFLOW"),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of GENERIC geometry (pressure loss coefficient dependence | inverse)"),
                  Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)"),Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(
              StopTime=1.01,
              NumberOfIntervals=5000,
              Tolerance=1e-005));
        end dp_pressureLossCoefficient_DPMFLOW;

        model dp_volumeFlowRate_DPMFLOW
          "Verification of function dp_volumeFlowRate_DP and dp_volumeFlowRate_MFLOW"

          parameter Integer n=size(a, 1) "number of different coefficients a";

          Modelica.SIunits.VolumeFlowRate V_flow[n]={input_mdot[i]/rho for i in 
                  1:n} "Input volume flow rate";

          //general variables
          parameter Real a[:](unit="(Pa.s2)/m6") = {15,30,45}
            "Coefficient for quadratic term";
          parameter Real b(unit="(Pa.s)/m3") = 0 "Coefficient for linear term";

          //fluid property variables
          Modelica.SIunits.Density rho=1.2 "density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";
          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con
            m_flow_IN_con[n](a=a, each b=b) 
                              annotation (extent=[-10, 12; 10, 34], Placement(
                transformation(extent={{-70,20},{-50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var
            m_flow_IN_var[n](each rho=rho) 
                             annotation (extent=[-10, 12; 10, 34], Placement(
                transformation(extent={{-50,20},{-30,42}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con
            dp_IN_con[n](a=a, each b=b) 
                            annotation (extent=[-10, 12; 10, 34], Placement(
                transformation(extent={{30,20},{50,42}})));

          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var
            dp_IN_var[n](each rho=rho) 
                            annotation (extent=[-10, 12; 10, 34], Placement(
                transformation(extent={{50,20},{70,42}})));

          //plotting
          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            offset=0,
            duration=1,
            height=31.25) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));

        equation
          //target == DP (incompressible)
          DP = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/general/dp_volumeFlowRate_DPMFLOW.mos"
                "Verification of dp_volumeFlowRate_DPMFLOW"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of GENERIC geometry (volume flow rate dependence | inverse)"),
                  Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)"),Text(
                  extent={{-98,-50},{102,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(
              StopTime=1.01,
              NumberOfIntervals=5000,
              Tolerance=1e-005));
        end dp_volumeFlowRate_DPMFLOW;
      end General;

      package Orifice
      extends Modelica.Icons.ExamplesPackage;

        model dp_suddenChange_DPMFLOW
          "Verification of function dp_suddenChange_DP AND dp_suddenChange_MFLOW"

          constant Real MIN=Modelica.Constants.eps;

          parameter Real dpoo=1;

          Real frac_A1toA2 "Ratio of small to large cross sectional area";

          //orifice variables
          Modelica.SIunits.Area A_1=A_2*frac_A1toA2
            "Small cross sectional area of orifice";
          Modelica.SIunits.Area A_2=1e-2
            "Large cross sectional area of orifice";
          Modelica.SIunits.Length C_1=sqrt(4*A_1/Modelica.Constants.pi)*
              Modelica.Constants.pi
            "Perimeter of small cross sectional area of orifice";
          Modelica.SIunits.Length C_2=sqrt(4*A_2/Modelica.Constants.pi)*
              Modelica.Constants.pi
            "Perimeter of large cross sectional area of orifice";

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid";
          Modelica.SIunits.Density rho=1000 "Density of fluid";

          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot(start=0)
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp(start=0)=dpoo*input_DP.y
            "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW(start=0)
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP(start=0)=input_dp
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_con
            dp_IN_con(
            A_1=A_1,
            A_2=A_2,
            C_1=C_1,
            C_2=C_2) annotation (extent=[40, 14; 60, 34], Placement(transformation(
                  extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_var
            dp_IN_var(eta=eta, rho=rho) 
                              annotation (extent=[40, 14; 60, 34], Placement(
                transformation(extent={{50,20},{70,40}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_con
            m_flow_IN_con(
            A_1=A_1,
            A_2=A_2,
            C_1=C_1,
            C_2=C_2) annotation (extent=[-58, 16; -38, 36], Placement(transformation(
                  extent={{-70,20},{-50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_var
            m_flow_IN_var(eta=eta, rho=rho) 
                                annotation (extent=[-58, 16; -38, 36], Placement(
                transformation(extent={{-50,20},{-30,40}})));

          //plotting
          Modelica.SIunits.Diameter d_hyd=4*A_1/max(MIN, C_1)
            "Hydraulic diameter of small cross sectional area of orifice";
          Modelica.SIunits.Velocity velocity=abs(M_FLOW)/(rho*max(MIN, A_1))
            "Mean velocity in small cross sectional area";
          Modelica.SIunits.ReynoldsNumber Re=rho*velocity*d_hyd/eta;

          Real DP_plot=DP "Pressure loss [Pa]";
          Real zeta_TOT=2*abs(DP_plot)/max(MIN, rho*(velocity)^2)
            "Pressure loss coefficients";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            offset=0,
            duration=1,
            height=836) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));
        equation
          //orifice variables
          der(frac_A1toA2) = 1;

          //incompressible fluid flow
          DP =
            Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP(
                    m_flow_IN_con,
                    m_flow_IN_var,
                    input_mdot);

          //compressible fluid flow
          M_FLOW =
            Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW(
                    dp_IN_con,
                    dp_IN_var,
                    input_dp);

          annotation (
            Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/orifice/dp_suddenChange_DPMFLOW.mos"
                "Verification of dp_suddenChange_DPMFLOW"),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                    100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of SMOOTH orifice with SUDDEN CHANGE in cross sectional area for TURBULENT flow regime (inverse)"),
                  Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)"),Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(NumberOfIntervals=5000),
            experimentSetupOutput);
        end dp_suddenChange_DPMFLOW;

        model dp_thickEdgedOverall_DPMFLOW
          "Verification of function dp_thickEdgedOverall_DP AND dp_thickEdgedOverall_MFLOW"

          constant Real MIN=Modelica.Constants.eps;

          parameter Integer n=size(A0_2_A1, 1)
            "Number of different ratios of cross sectional areas";

          //orifice variables
          parameter Modelica.SIunits.Area A_0=1e-3
            "Cross sectional area of vena contraction";
          parameter Modelica.SIunits.Area A_1[n]={A_0/A0_2_A1[i] for i in 1:n}
            "Large cross sectional area of orifice";
          parameter Modelica.SIunits.Length C_0=sqrt(4*A_0/Modelica.Constants.pi)
              *Modelica.Constants.pi "Perimeter of vena contraction";
          parameter Modelica.SIunits.Length C_1[n]=sqrt(4*A_1/Modelica.Constants.pi)
              *Modelica.Constants.pi
            "Perimeter of large cross sectional area of orifice";
          parameter Real A0_2_A1[6]={0.02,0.08,0.20,0.40,0.70,0.90}
            "Ratio of cross sectional areas";

          Modelica.SIunits.Length L(start=0) "Length of thick edged orifice";
          Real l_bar=L/sqrt(4*A_0/Modelica.Constants.pi)
            "Relative length of orifice";

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid" 
            annotation (Dialog(group="Fluid properties"));
          Modelica.SIunits.Density rho=1000 "Density of fluid" 
            annotation (Dialog(group="Fluid properties"));

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con
            m_flow_IN_con[n](
            each A_0=A_0,
            A_1=A_1,
            each C_0=C_0,
            C_1=C_1,
            each L=L) annotation (extent=[-60, 12; -40, 32], Placement(transformation(
                  extent={{-70,20},{-50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var
            m_flow_IN_var[n](each eta=eta, each rho=rho) annotation (extent=[-60, 12; -40,
                32], Placement(transformation(extent={{-50,20},{-30,40}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con
            dp_IN_con[n](
            each A_0=A_0,
            A_1=A_1,
            each C_0=C_0,
            C_1=C_1,
            each L=L) annotation (extent=[40, 12; 60, 32], Placement(transformation(
                  extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var
            dp_IN_var[n](each eta=eta, each rho=rho) 
                                         annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{50,20},{70,40}})));

          //plotting
          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";
          Real A_cross[n]={A_1[i] for i in 1:n};
          Real velocity[n]={input_mdot[1]/max(MIN, (rho*A_cross[i])) for i in 1:n};
          Real zeta_TOT[n]={2*DP[i]/max(MIN, (rho*(velocity[i]^2))) for i in 1:n};

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            duration=1,
            height=836,
            offset=0) annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{60,-80},{80,-60}})));

        equation
          //orifice variables
          der(L) = 0.39;

          //target == DP (incompressible)
          DP = {
            Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/orifice/dp_thickEdgedOverall_DPMFLOW.mos"
                "Verification of dp_thickEdgedOverall_DP and dp_thickEdgedOverall_MFLOW"),
              Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of THICK EDGED ORIFICE in cross sectional area for OVERALL flow regime (inverse)"),
                  Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)"),Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(
              StopTime=1.01,
              NumberOfIntervals=5000,
              Tolerance=1e-005));
        end dp_thickEdgedOverall_DPMFLOW;
      end Orifice;

      package StraightPipe
      extends Modelica.Icons.ExamplesPackage;

        model dp_laminar_DPMFLOW
          "Verification of function dp_laminar_DP AND dp_laminar_MFLOW"

          Real MIN=Modelica.Constants.eps;

          parameter Integer n=size(K, 1);

          //straight pipe variables
          Modelica.SIunits.Area A_cross=Modelica.Constants.pi*d_hyd^2/4
            "Circular cross sectional area of straight pipe";
          Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=
              Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered
            "Choice of considering surface roughness" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Length K[1]={0}
            "Roughness (average height of surface asperities)" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Length L=1 "Length" 
                                 annotation (Dialog(group="Straight pipe"));

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid";
          Modelica.SIunits.Density rho=1000 "Density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_con
            m_flow_IN_con[n](each d_hyd=d_hyd, each L=L) 
                                         annotation (extent=[-60, 12; -40, 32],
              Placement(transformation(extent={{-70,20},{-50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_var
            m_flow_IN_var[n](each eta=eta, each rho=rho) 
                                         annotation (extent=[-60, 12; -40, 32],
              Placement(transformation(extent={{-50,20},{-30,40}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_con
            dp_IN_con[n](each d_hyd=d_hyd, each L=L) 
                                          annotation (extent=[40, 12; 60, 32],
              Placement(transformation(extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_var
            dp_IN_var[n](each eta=eta, each rho=rho) 
                                          annotation (extent=[40, 12; 60, 32],
              Placement(transformation(extent={{50,20},{70,40}})));

          //plotting
          Modelica.SIunits.Velocity velocity[n]={M_FLOW[i]/(rho*A_cross) for i in 
                  1:n} "Mean velocity";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho*velocity[i]*d_hyd/eta for 
              i in 1:n};

          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";
          Real zeta_TOT[n]={2*abs(DP_plot[i])/max(MIN, rho*(velocity[i])^2) for i in 1:
              n} "Pressure loss coefficients";
          Real lambda_FRI[n]={zeta_TOT[i]*d_hyd/L for i in 1:n}
            "Frictional resistance coefficient";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            offset=0,
            duration=1,
            height=41) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));
        equation
          //target == DP (incompressible)
          DP = {
            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/straightPipe/dp_laminar_DPMFLOW.mos"
                "Verification of dp_laminar_DPMFLOW"), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of STRAIGHT PIPE for LAMINAR flow regime (inverse)"),
                  Text(
                  extent={{-102,-50},{98,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(
              StopTime=1.01,
              NumberOfIntervals=5000,
              Tolerance=1e-005));
        end dp_laminar_DPMFLOW;

        model dp_overall_DPMFLOW
          "Verification of function dp_overall_DP AND dp_overall_MFLOW"

          Real MIN=Modelica.Constants.eps;

          parameter Integer n=size(K, 1);

          //straight pipe variables
          Modelica.SIunits.Area A_cross=Modelica.Constants.pi*d_hyd^2/4
            "Circular cross sectional area of straight pipe";
          Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=
              Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered
            "Choice of considering surface roughness" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Length K[4]={0,2e-4*d_hyd,2e-3*d_hyd,2e-2*d_hyd}
            "Roughness (average height of surface asperities)" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Length L=1 "Length" 
                                 annotation (Dialog(group="Straight pipe"));

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid";
          Modelica.SIunits.Density rho=1000 "Density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con
            m_flow_IN_con[n](
            each d_hyd=d_hyd,
            each L=L,
            K=K,
            each roughness=roughness) annotation (extent=[-60, 12; -40, 32], Placement(
                transformation(extent={{-70,20},{-50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var
            m_flow_IN_var[n](each eta=eta, each rho=rho) 
                                         annotation (extent=[-60, 12; -40, 32],
              Placement(transformation(extent={{-50,20},{-30,40}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con
            dp_IN_con[n](
            each d_hyd=d_hyd,
            each L=L,
            K=K,
            each roughness=roughness) annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var
            dp_IN_var[n](each eta=eta, each rho=rho) 
                                          annotation (extent=[40, 12; 60, 32],
              Placement(transformation(extent={{50,20},{70,40}})));

          //plotting
          Modelica.SIunits.Velocity velocity[n]={M_FLOW[i]/(rho*A_cross) for i in 
                  1:n} "Mean velocity";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho*velocity[i]*d_hyd/eta for 
              i in 1:n};

          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";
          Real zeta_TOT[n]={2*abs(DP_plot[i])/max(MIN, rho*(velocity[i])^2) for i in 1:
              n} "Pressure loss coefficients";
          Real lambda_FRI[n]={zeta_TOT[i]*d_hyd/L for i in 1:n}
            "Frictional resistance coefficient";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            duration=1,
            offset=0,
            height=4e4) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));
        equation
          //target == DP (incompressible)
          DP = {
            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/straightPipe/dp_overall_DPMFLOW.mos"
                "Verification of dp_overall_DPMFLOW"), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)"),Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of STRAIGHT PIPE for OVERALL flow regime (inverse)")}),
            experiment(
              StopTime=1.01,
              NumberOfIntervals=5000,
              Tolerance=1e-005));
        end dp_overall_DPMFLOW;

        model dp_turbulent_DPMFLOW
          "Verification of function dp_turbulent_DP AND dp_turbulent_MFLOW"

          Real MIN=Modelica.Constants.eps;

          parameter Integer n=size(K, 1);

          //straight pipe variables
          Modelica.SIunits.Area A_cross=Modelica.Constants.pi*d_hyd^2/4
            "Circular cross sectional area of straight pipe";
          Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=
              Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered
            "Choice of considering surface roughness" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Length K[4]={0,2e-4*d_hyd,2e-3*d_hyd,2e-2*d_hyd}
            "Roughness (average height of surface asperities)" 
            annotation (Dialog(group="Straight pipe"));
          Modelica.SIunits.Length L=1 "Length" 
                                 annotation (Dialog(group="Straight pipe"));

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid";
          Modelica.SIunits.Density rho=1000 "Density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";

          //intended output variables for records
          Modelica.SIunits.MassFlowRate M_FLOW[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP[n](start=zeros(n))={input_dp[i] for i in 
                1:n}
            "(Output) pressure loss (for intended incompressible case)";

          //input record
          //target == DP (incompressible)
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_con
            m_flow_IN_con[n](
            each d_hyd=d_hyd,
            each L=L,
            K=K,
            each roughness=roughness) annotation (extent=[-60, 12; -40, 32], Placement(
                transformation(extent={{-70,20},{-50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_var
            m_flow_IN_var[n](each eta=eta, each rho=rho) 
                                           annotation (extent=[-60, 12; -40, 32],
              Placement(transformation(extent={{-50,20},{-30,40}})));

          //target == M_FLOW (compressible)
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_con
            dp_IN_con[n](
            each d_hyd=d_hyd,
            each L=L,
            K=K,
            each roughness=roughness) annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_var
            dp_IN_var[n](each eta=eta, each rho=rho) 
                                          annotation (extent=[40, 12; 60, 32],
              Placement(transformation(extent={{50,20},{70,40}})));

          //plotting
          Modelica.SIunits.Velocity velocity[n]={M_FLOW[i]/(rho*A_cross) for i in 
                  1:n} "Mean velocity";
          Modelica.SIunits.ReynoldsNumber Re[n]={rho*velocity[i]*d_hyd/eta for 
              i in 1:n};

          Real DP_plot[n]={DP[i] for i in 1:n} "Pressure loss [Pa]";
          Real zeta_TOT[n]={2*abs(DP_plot[i])/max(MIN, rho*(velocity[i])^2) for i in 1:
              n} "Pressure loss coefficients";
          Real lambda_FRI[n]={zeta_TOT[i]*d_hyd/L for i in 1:n}
            "Frictional resistance coefficient";

          Modelica.Blocks.Sources.Ramp input_DP(
            startTime=0,
            offset=0,
            duration=1,
            height=4e4) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{60,-80},{80,-60}})));
        equation
          //target == DP (incompressible)
          DP = {
            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(
                    m_flow_IN_con[i],
                    m_flow_IN_var[i],
                    input_mdot[i]) for i in 1:n};

          //target == M_FLOW (compressible)
          M_FLOW = {
            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                    dp_IN_con[i],
                    dp_IN_var[i],
                    input_dp[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/straightPipe/dp_turbulent_DPMFLOW.mos"
                "Verification of dp_turbulent_DPMFLOW"), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of STRAIGHT PIPE for TURBULENT flow regime (inverse)"),
                  Text(
                  extent={{13,14},{88,4}},
                  lineColor={0,0,255},
                  textString="Target == M_FLOW (compressible)"),Text(
                  extent={{-83,14},{-8,4}},
                  lineColor={0,0,255},
                  textString="Target == DP (incompressible)"),Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)")}),
            experiment(
              StopTime=1.01,
              NumberOfIntervals=5000,
              Tolerance=1e-005));
        end dp_turbulent_DPMFLOW;

        model dp_twoPhaseOverall_DP
          "Verification of function dp_twoPhaseOverall_DP"

          import PI = Modelica.Constants.pi;

          //straight pipe variables
          parameter Integer n=size(eta_l, 1);
          parameter Modelica.SIunits.Diameter d_hyd=0.000787;
          parameter Modelica.SIunits.Area A_cross=PI*d_hyd^2/4;
          parameter Modelica.SIunits.Length perimeter=PI*d_hyd;
          parameter Modelica.SIunits.Length length=0.503;

          //fluid property variables for CO2 at saturation temperatures of 0°C, 10°C, 20°C
          Modelica.SIunits.DynamicViscosity eta_l[5]={9.835980551e-5,
              8.77888107e-5,7.368173278e-5,8.77888107e-5,8.77888107e-5};
          Modelica.SIunits.DynamicViscosity eta_g[n]={1.547810104e-5,
              1.732575635e-5,2.007174653e-5,1.732575635e-5,1.732575635e-5};
          Modelica.SIunits.Density rho_l[n]={928.81004020247,863.41525244853,
              776.03258981765,863.41525244853,863.41525244853};
          Modelica.SIunits.Density rho_g[n]={97.475877361949,134.57734207752,
              192.69422231737,134.57734207752,134.57734207752};
          Modelica.SIunits.SurfaceTension sigma[n]={4.4317e-3,2.6724e-03,
              1.1607e-03,2.6724e-03,2.6724e-03};

          //Two phase pressure loss w.r.t. equation of Friedel
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_IN_con
            IN_con_1[n](
            each frictionalPressureLoss=Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss.Friedel,
            each A_cross=A_cross,
            each perimeter=perimeter,
            each length=length,
            each phi=0,
            each momentumPressureLoss=false,
            each voidFractionApproach=Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Energy) 
            annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_IN_var
            IN_var_1[n](
            eta_l=eta_l,
            eta_g=eta_g,
            rho_l=rho_l,
            rho_g=rho_g,
            sigma=sigma,
            each x_flow_sta=x_flow,
            each x_flow_end=x_flow) 
            annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

          //Two phase pressure loss w.r.t. equation of Chisholm
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_IN_con
            IN_con_2[n](
            each frictionalPressureLoss=Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss.Chisholm,
            each A_cross=A_cross,
            each perimeter=perimeter,
            each length=length,
            each phi=0,
            each momentumPressureLoss=false,
            each voidFractionApproach=Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Energy) 
            annotation (Placement(transformation(extent={{0,0},{20,20}})));

          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_IN_var
            IN_var_2[n](
            eta_l=eta_l,
            eta_g=eta_g,
            rho_l=rho_l,
            rho_g=rho_g,
            sigma=sigma,
            each x_flow_end=x_flow,
            each x_flow_sta=x_flow) 
            annotation (Placement(transformation(extent={{20,0},{40,20}})));

          Modelica.SIunits.MassFlowRate input_mdot[n]={0.0001459354,
              0.0001459354,0.0001459354,0.00019458051,0.000097290255}
            "(Input) mass flow rate (for incompressible case)";
          Modelica.SIunits.MassFlowRate m_flow[n]=input_mdot;

          //output variables
          Modelica.SIunits.Pressure DP_1[n]
            "(Output) pressure loss (for incompressible case)";
          Modelica.SIunits.Pressure DP_2[n]
            "(Output) pressure loss (for incompressible case)";
          Real DP_plot_1[n]={DP_1[i]/100000 for i in 1:n};
          Real DP_plot_2[n]={DP_2[i]/100000 for i in 1:n};
        public
          Modelica.Blocks.Sources.Ramp input_mflow_0[n](
            each startTime=0,
            each offset=0,
            each duration=1,
            each height=100) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-80,-80},{-60,-60}})));
          Modelica.Blocks.Sources.Sine input_mflow_1[n](
            each offset=0,
            each phase=0,
            each startTime=0,
            each freqHz=1,
            each amplitude=100) annotation (extent=[-40, -80; -20, -60], Placement(
                transformation(extent={{-40,-80},{-20,-60}})));
          Modelica.Blocks.Sources.Exponentials input_mflow_2[n](
            each offset=0,
            each startTime=0,
            each outMax=100,
            each riseTime=1e-1,
            each riseTimeConst=1e-1) annotation (extent=[0, -80; 20, -60], Placement(
                transformation(extent={{0,-80},{20,-60}})));
          Modelica.Blocks.Sources.Ramp input_x_0(
            duration=1,
            startTime=0,
            height=1) 
            annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
          Modelica.Blocks.Sources.Sine input_x_1(
            offset=0,
            phase=0,
            startTime=0,
            freqHz=1,
            amplitude=1) 
            annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
          Modelica.Blocks.Sources.Exponentials input_x_2(
            offset=0,
            startTime=0,
            riseTime=1e-1,
            riseTimeConst=1e-1,
            outMax=1) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

        protected
          Modelica.SIunits.MassFraction x_flow=input_x_0.y
            "Mean mass flow rate quality";

        equation
          DP_1 = {
            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP(
                    IN_con_1[i],
                    IN_var_1[i],
                    m_flow[i]) for i in 1:n};
          DP_2 = {
            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP(
                    IN_con_2[i],
                    IN_var_2[i],
                    m_flow[i]) for i in 1:n};

          annotation (Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/straightPipe/dp_twoPhaseOverall_DP.mos"
                "Verification of dp_twoPhaseOverall_DP"), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Two phase pressure loss of STRAIGHT PIPE for OVERALL flow regime")}),
            experiment(
              StopTime=1.01,
              NumberOfIntervals=5000,
              Tolerance=1e-005));
        end dp_twoPhaseOverall_DP;
      end StraightPipe;

      package Valve "Verification of valve functions"
      extends Modelica.Icons.ExamplesPackage;
        model dp_severalGeometryOverall_DPMFLOW
          "Verification of function dp_severalGeometryOverall_DP AND dp_severalGeometryOverall_MFLOW"

          parameter Integer n=size(geometry, 1)
            "Number of different geometries";

          //valve variables
          Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry geometry[5]=
              {1,2,3,4,5} "Choice of geometry for valve";
          Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diamter";
          Real Av=Modelica.Constants.pi
                    *d_hyd^2/4 "Av (metric) flow coefficient [Av]=m^2";
          Real opening=input_opening.y
            "Opening of valve | 0==closed and 1== fully openend";

          //fluid property variables
          Modelica.SIunits.DynamicViscosity eta=1e-3
            "Dynamic viscosity of fluid";
          Modelica.SIunits.Density rho=1000 "Density of fluid";

          //target variables (here: mass flow rate as input for inverse calculation)
          //compressible case
          //intended input variables for records
          Modelica.SIunits.MassFlowRate input_mdot_1[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp_1[n](start=zeros(n))=ones(n)*
            input_DP.y "(Input) pressure loss (for intended compressible case)";
          //variable opening
          Modelica.SIunits.MassFlowRate input_mdot_2[n](start=zeros(n))
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp_2[n](start=zeros(n))=ones(n)*1e3
            "(Input) pressure loss (for intended compressible case)";

          //incompressible case
          //constant opening
          Modelica.SIunits.MassFlowRate input_mdot_3[n](start=zeros(n))=ones(n)
            *input_mdot.y
            "(Input) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure input_dp_3[n](start=zeros(n))
            "(Input) pressure loss (for intended incompressible case)";

          //intended output variables for records
          //compressible case
          //constant opening
          Modelica.SIunits.MassFlowRate M_FLOW_1[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP_1[n](start=zeros(n))={input_dp_1[i] for 
            i in 1:n}
            "(Output) pressure loss (for intended incompressible case)";
          //variable opening
          Modelica.SIunits.MassFlowRate M_FLOW_2[n](start=zeros(n))
            "(Output) mass flow rate (for intended compressible case)";
          Modelica.SIunits.Pressure DP_2[n](start=zeros(n))={input_dp_2[i] for 
            i in 1:n}
            "(Output) pressure loss (for intended incompressible case)";
          //incompressible case
          //constant opening
          Modelica.SIunits.MassFlowRate M_FLOW_3[n](start=zeros(n))
            "(Output) mass flow rate (for intended incompressible case)";
          Modelica.SIunits.Pressure DP_3[n](start=zeros(n))=input_dp_3
            "(Output) pressure loss (for intended incompressible case)";

          //compressible case
          //constant opening
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con
            m_flow_IN_con_1[n](
            geometry=geometry,
            each Av=Av,
            each zeta_TOT_max=1e3) annotation (extent=[-60, 12; -40, 32], Placement(
                transformation(extent={{-100,20},{-80,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var
            m_flow_IN_var_1[n](each rho=rho, each opening=0.5) annotation (extent=[-60,
                12; -40, 32], Placement(transformation(extent={{-80,20},{-60,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con
            dp_IN_con_1[n](
            geometry=geometry,
            each Av=Av,
            each zeta_TOT_max=1e3) annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{-50,20},{-30,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var
            dp_IN_var_1[n](each rho=rho, each opening=0.5) annotation (extent=[40, 12;
                60, 32], Placement(transformation(extent={{-30,20},{-10,40}})));

          //variable opening
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con
            m_flow_IN_con_2[n](
            geometry=geometry,
            each Av=Av,
            each zeta_TOT_max=1e3) annotation (extent=[-60, 12; -40, 32], Placement(
                transformation(extent={{10,20},{30,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var
            m_flow_IN_var_2[n](each rho=rho, each opening=opening) annotation (extent=[
                -60, 12; -40, 32], Placement(transformation(extent={{30,20},{50,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con
            dp_IN_con_2[n](
            geometry=geometry,
            each Av=Av,
            each zeta_TOT_max=1e3) annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{60,20},{80,40}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var
            dp_IN_var_2[n](each rho=rho, each opening=opening) annotation (extent=[40,
                12; 60, 32], Placement(transformation(extent={{80,20},{100,40}})));

          //incompressible case
          //constant opening
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con
            m_flow_IN_con_3[n](
            geometry=geometry,
            each Av=Av,
            each zeta_TOT_max=1e3) annotation (extent=[-60, 12; -40, 32], Placement(
                transformation(extent={{-70,-20},{-50,0}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var
            m_flow_IN_var_3[n](each rho=rho, each opening=0.5) annotation (extent=[-60,
                12; -40, 32], Placement(transformation(extent={{-50,-20},{-30,0}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con
            dp_IN_con_3[n](
            geometry=geometry,
            each Av=Av,
            each zeta_TOT_max=1e3) annotation (extent=[40, 12; 60, 32], Placement(
                transformation(extent={{30,-20},{50,0}})));

          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var
            dp_IN_var_3[n](each rho=rho, each opening=0.5) annotation (extent=[40, 12;
                60, 32], Placement(transformation(extent={{50,-20},{70,0}})));

        protected
          constant Real MIN=Modelica.Constants.eps;

          //compressible case
          //constant opening
          Real DP_plot_1[n]={DP_1[i] for i in 1:n} "Pressure loss [Pa]";
          Real zeta_TOT_1[n]={2*DP_1[i]*rho*Av^2/max(MIN, (input_mdot_1[i])^2) for i in 
                  1:n} "Pressure loss coefficients";
          Real Re_1[n]={input_mdot_1[i]*d_hyd/(eta*Av) for i in 1:n};

          //variable opening
          Real DP_plot_2[n]={DP_2[i] for i in 1:n} "Pressure loss [Pa]";
          Real zeta_TOT_2[n]={2*DP_2[i]*rho*Av^2/max(MIN, (input_mdot_2[i])^2) for i in 
                  1:n} "Pressure loss coefficients";
          Real Re_2[n]={input_mdot_2[i]*d_hyd/(eta*Av) for i in 1:n};
          //incompressible case
          Real DP_plot_3[n]={DP_3[i] for i in 1:n} "Pressure loss [Pa]";
          Real zeta_TOT_3[n]={2*DP_3[i]*rho*Av^2/max(MIN, (input_mdot_3[i])^2) for i in 
                  1:n} "Pressure loss coefficients";
          Real Re_3[n]={input_mdot_3[i]*d_hyd/(eta*Av) for i in 1:n};

        public
          Modelica.Blocks.Sources.Ramp input_DP(height=1e3, duration=1) annotation (
              extent=[-80, -80; -60, -60], Placement(transformation(extent={{-70,-80},{
                    -50,-60}})));

          Modelica.Blocks.Sources.Ramp input_opening(
            startTime=0,
            duration=1,
            height=1,
            offset=0) annotation (extent=[-80, -80; -60, -60], Placement(transformation(
                  extent={{50,-80},{70,-60}})));

          Modelica.Blocks.Sources.Ramp input_mdot(
            offset=0,
            duration=1,
            height=1e2) annotation (extent=[-80, -80; -60, -60], Placement(
                transformation(extent={{-8,-80},{12,-60}})));

        equation
          //compressible case
          //constant opening
          DP_1 = {
            Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP(
                    m_flow_IN_con_1[i],
                    m_flow_IN_var_1[i],
                    input_mdot_1[i]) for i in 1:n};

          M_FLOW_1 = {
            Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW(
                    dp_IN_con_1[i],
                    dp_IN_var_1[i],
                    input_dp_1[i]) for i in 1:n};

          //variable opening
          DP_2 = {
            Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP(
                    m_flow_IN_con_2[i],
                    m_flow_IN_var_2[i],
                    input_mdot_2[i]) for i in 1:n};

          M_FLOW_2 = {
            Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW(
                    dp_IN_con_2[i],
                    dp_IN_var_2[i],
                    input_dp_2[i]) for i in 1:n};

          //incompressible case
          //constant opening
          DP_3 = {
            Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP(
                    m_flow_IN_con_3[i],
                    m_flow_IN_var_3[i],
                    input_mdot_3[i]) for i in 1:n};

          M_FLOW_3 = {
            Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW(
                    dp_IN_con_3[i],
                    dp_IN_var_3[i],
                    input_dp_3[i]) for i in 1:n};

          annotation (
            Commands(file=
                  "modelica://Modelica/Resources/Scripts/Dymola/pressureLoss/valve/dp_severalGeometryOverall_DPMFLOW.mos"
                "Verification of dp_severalGeometryOverall_DP and dp_severalGeometryOverall_MFLOW (inverse)"),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}), graphics={Text(
                  extent={{-100,50},{100,75}},
                  lineColor={0,0,255},
                  textString=
                    "Pressure loss of VALVE for OVERALL flow regime (different geometries | inverse)"),
                  Text(
                  extent={{-100,-50},{100,-25}},
                  lineColor={0,0,255},
                  textString=
                    "here: unintended input variables for creation of nonlinear equations (proof analytical Jacobians)"),
                  Text(
                  extent={{-91,20},{-24,10}},
                  lineColor={0,0,255},
                  textString=" constant opening / variable pressure loss"),Text(
                  extent={{25,20},{92,10}},
                  lineColor={0,0,255},
                  textString=" variable opening / constant pressure loss"),Text(
                  extent={{-27,-6},{26,-16}},
                  lineColor={0,0,255},
                  textString="incompressible case"),Text(
                  extent={{-33,-20},{34,-30}},
                  lineColor={0,0,255},
                  textString=" constant opening / variable mass flow rate"),Text(
                  extent={{-27,52},{26,42}},
                  lineColor={0,0,255},
                  textString="compressible cases")}),
            experiment,
            experimentSetupOutput);
        end dp_severalGeometryOverall_DPMFLOW;
      end Valve;
    end PressureLoss;
  end Verifications;

  package TestCases "package for implemented test cases ready for simulation"
  extends Modelica.Icons.ExamplesPackage;

    package PressureLoss
      "Test package for pressure loss models implemented in Modelica.Fluid"
    extends Modelica.Fluid.Icons.VariantLibrary;

      model Bend "Test cases of generic pressure loss functions"

        inner Modelica.Fluid.System system(p_ambient(displayUnit="Pa") = 100000,
            m_flow_small=0.01) annotation (extent=[80, -100; 100, -80]);

      public
        Modelica.Blocks.Sources.Sine input_mflow(
          freqHz=1,
          offset=0,
          amplitude=1) annotation (extent=[-100, -52; -80, -32], Placement(
              transformation(extent={{-100,-50},{-80,-30}})));

      public
        Modelica.Blocks.Sources.RealExpression input_p(y=from_mflow.port_a.p) 
          annotation (extent=[-100, 0; -80, 20], Placement(transformation(extent={{-100,
                  10},{-80,30}})));
        Modelica.Fluid.Sources.Boundary_pT IN_p(
          nPorts=1,
          T(displayUnit="K") = system.T_ambient,
          p(displayUnit="Pa") = system.p_ambient,
          use_p_in=true,
          redeclare package Medium = Modelica.Media.Air.DryAirNasa) 
          annotation (Placement(transformation(extent={{-60,10},{-40,30}})));

        Modelica.Fluid.Sources.FixedBoundary OUT_dp(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={90,20})));

        Modelica.Fluid.Sources.FixedBoundary OUT_mflow(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={90,-40})));

        Modelica.Fluid.Sources.MassFlowSource_T IN_mflow(
          T=system.T_ambient,
          nPorts=1,
          use_m_flow_in=true,
          redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-50,-40})));

        Modelica.Fluid.Fittings.Bends.CurvedBend from_dp(
                                                        redeclare package
            Medium = 
              Modelica.Media.Air.DryAirNasa, geometry(d_hyd=0.1, R_0=0.2))
          "Calculate mass flow rate from pressure loss" 
          annotation (Placement(transformation(extent={{-24,-4},{24,44}})));

        Modelica.Fluid.Fittings.Bends.CurvedBend from_mflow(
                     redeclare package Medium = Modelica.Media.Air.DryAirNasa,
            geometry(d_hyd=0.1, R_0=0.2))
          "Calculate pressure loss from mass flow rate" 
          annotation (Placement(transformation(extent={{-24,-64},{24,-16}})));
      equation
        connect(IN_p.ports[1], from_dp.port_a) annotation (Line(
            points={{-40,20},{-24,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_dp.port_b, OUT_dp.ports[1]) annotation (Line(
            points={{24,20},{80,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow.port_b, OUT_mflow.ports[1]) annotation (Line(
            points={{24,-40},{80,-40}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow.port_a, IN_mflow.ports[1]) annotation (Line(
            points={{-24,-40},{-40,-40}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(input_mflow.y, IN_mflow.m_flow_in) annotation (Line(
            points={{-79,-40},{-70,-40},{-70,-32},{-60,-32}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(input_p.y, IN_p.p_in) annotation (Line(
            points={{-79,20},{-72,20},{-72,28},{-62,28}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Documentation(info="<html>
<p>
Switch to the diagram or equation layer to see the model of a <b> Modelica.Fluid bend </b> using <b> Fluid.Dissipation pressure loss calculations </b>.
</p>

<p>
This model executes pressure loss calculations out of the <b> Fluid.Dissipation </b> library for a bend of an incompressible and single-phase fluid flow considering surface roughness. Both the <b> compressible </b> case, where the mass flow rate (M_FLOW) is calculated in dependence of a known pressure loss (dp) and the <b> incompressible </b> case, where the pressure loss (DP) is calculated in dependence of a known mass flow rate (m_flow) are modelled.
</p>
</html>
"),       experiment(StopTime=1.01, NumberOfIntervals=5000),
          experimentSetupOutput,
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={Text(
                extent={{-96,120},{86,58}},
                lineColor={0,0,255},
                textString="Test: Bend functions"), Text(
                extent={{-56,-2},{60,-18}},
                lineColor={255,0,0},
                textString=
                    "set record parameters for chosen pressure loss function (inside flow model)")}));
      end Bend;

      model Orifice "Test cases of pressure loss functions for orifice"

        inner Modelica.Fluid.System system(p_ambient(displayUnit="Pa") = 100000,
            m_flow_small=0.01) annotation (extent=[80, -100; 100, -80]);

        //boundary conditions
        Modelica.Blocks.Sources.Sine input_mflow(
          freqHz=1,
          offset=0,
          amplitude=0.001) annotation (extent=[-100, -52; -80, -32],Placement(
              transformation(extent={{-100,-50},{-80,-30}})));

        Modelica.Blocks.Sources.RealExpression input_p(y=from_mflow.port_a.p) 
          annotation (extent=[-100, 0; -80, 20], Placement(transformation(extent={{-100,
                  10},{-80,30}})));

        Modelica.Fluid.Sources.Boundary_pT IN_p(
          nPorts=1,
          T(displayUnit="K") = system.T_ambient,
          p(displayUnit="Pa") = system.p_ambient,
          use_p_in=true,
          redeclare package Medium = Modelica.Media.Air.DryAirNasa) 
          annotation (Placement(transformation(extent={{-60,10},{-40,30}})));

        Modelica.Fluid.Sources.FixedBoundary OUT_dp(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={90,20})));

        Modelica.Fluid.Sources.FixedBoundary OUT_mflow(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={90,-40})));

        Modelica.Fluid.Sources.MassFlowSource_T IN_mflow(
          T=system.T_ambient,
          nPorts=1,
          use_m_flow_in=true,
          redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-50,-40})));

        //flow models
        Modelica.Fluid.Fittings.Orifices.ThickEdgedOrifice from_dp(
                  redeclare package Medium = Modelica.Media.Air.DryAirNasa)
          "Calculate mass flow rate from pressure loss" 
          annotation (Placement(transformation(extent={{-24,-4},{24,44}})));
        Modelica.Fluid.Fittings.Orifices.ThickEdgedOrifice from_mflow(
                     redeclare package Medium = Modelica.Media.Air.DryAirNasa)
          "Calculate pressure loss from mass flow rate" 
          annotation (Placement(transformation(extent={{-24,-64},{24,-16}})));
      equation
        connect(IN_p.ports[1], from_dp.port_a) annotation (Line(
            points={{-40,20},{-24,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_dp.port_b, OUT_dp.ports[1]) annotation (Line(
            points={{24,20},{80,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow.port_b, OUT_mflow.ports[1]) annotation (Line(
            points={{24,-40},{80,-40}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow.port_a, IN_mflow.ports[1]) annotation (Line(
            points={{-24,-40},{-40,-40}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(input_mflow.y, IN_mflow.m_flow_in) annotation (Line(
            points={{-79,-40},{-70,-40},{-70,-32},{-60,-32}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(input_p.y, IN_p.p_in) annotation (Line(
            points={{-79,20},{-72,20},{-72,28},{-62,28}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Documentation(info="<html>
<p>
Switch to the diagram or equation layer to see the model of a <b> Modelica.Fluid bend </b> using <b> Fluid.Dissipation pressure loss calculations </b>.
</p>

<p>
This model executes pressure loss calculations out of the <b> Fluid.Dissipation </b> library for a bend of an incompressible and single-phase fluid flow considering surface roughness. Both the <b> compressible </b> case, where the mass flow rate (M_FLOW) is calculated in dependence of a known pressure loss (dp) and the <b> incompressible </b> case, where the pressure loss (DP) is calculated in dependence of a known mass flow rate (m_flow) are modelled.
</p>
</html>
"),       experiment(StopTime=1.01, NumberOfIntervals=5000),
          experimentSetupOutput,
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={Text(
                extent={{-96,120},{86,58}},
                lineColor={0,0,255},
                textString="Test: Orifice functions"), Text(
                extent={{-56,-2},{60,-18}},
                lineColor={255,0,0},
                textString=
                    "set record parameters for chosen pressure loss function (inside flow model)")}));
      end Orifice;

      model SeveralTestCases
        "Test cases of pressure loss functions for several devices"

        Modelica.SIunits.Diameter d_hyd=0.1 "Hydraulic diameter";
        Modelica.SIunits.Area A_cross=Modelica.Constants.pi*d_hyd^2/4
          "Cross sectional area";
        Real eta=1e-3 "Dynamic viscosity of Water";
        Real rho=1e3 "Density of Water";
        Real Re_cir=input_mflow.y*d_hyd/(eta*A_cross) "Circular geometry";
        Real Re_rec=input_mflow.y*d_hyd/(eta*d_hyd^2) "Rectangular geometry";
        Real vel_cir=input_mflow.y/(rho*A_cross) "Circular geometry";
        Real vel_rec=input_mflow.y/(rho*d_hyd^2) "Rectangular geometry";

        inner Modelica.Fluid.System system(p_ambient(displayUnit="Pa") = 100000,
            m_flow_small=0.01) annotation (extent=[80, -100; 100, -80], Placement(
              transformation(extent={{-200,-200},{-180,-180}})));

      public
        Modelica.Blocks.Sources.Sine input_mflow(
          offset=0,
          freqHz=1,
          amplitude=10) annotation (extent=[-100, -52; -80, -32], Placement(
              transformation(extent={{-200,-12},{-180,8}})));

      public
        Modelica.Blocks.Sources.RealExpression input_p(y=from_mflow.port_a.p) 
          annotation (extent=[-100, 0; -80, 20], Placement(transformation(extent={{0,
                  156},{20,176}})));
        Modelica.Fluid.Sources.Boundary_pT IN_p(
          nPorts=1,
          T(displayUnit="K") = system.T_ambient,
          p(displayUnit="Pa") = system.p_ambient,
          use_p_in=true,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(extent={{40,158},{60,178}})));

        Modelica.Fluid.Sources.FixedBoundary OUT_dp(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={190,168})));

        Modelica.Fluid.Sources.FixedBoundary OUT_mflow(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={190,128})));

        Modelica.Fluid.Sources.MassFlowSource_T IN_mflow(
          T=system.T_ambient,
          nPorts=1,
          use_m_flow_in=true,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={50,128})));

        Modelica.Fluid.Fittings.Bends.EdgedBend from_dp(redeclare package
            Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater, geometry(d_hyd=
                0.1, delta=3.1415926535898))
          "Calculate mass flow rate from pressure loss" 
          annotation (Placement(transformation(extent={{76,144},{124,192}})));

        Modelica.Fluid.Fittings.Bends.EdgedBend from_mflow(redeclare package
            Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater, geometry(d_hyd=
                0.1, delta=3.1415926535898))
          "Calculate pressure loss from mass flow rate" 
          annotation (Placement(transformation(extent={{76,104},{124,152}})));

      public
        Modelica.Blocks.Sources.RealExpression input_p2(y=from_mflow2.port_a.p) 
          annotation (extent=[-100, 0; -80, 20], Placement(transformation(extent={{0,
                  -4},{20,16}})));
        Modelica.Fluid.Sources.Boundary_pT IN_p2(
          nPorts=1,
          T(displayUnit="K") = system.T_ambient,
          p(displayUnit="Pa") = system.p_ambient,
          use_p_in=true,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(extent={{40,-2},{60,18}})));
        Modelica.Fluid.Sources.FixedBoundary OUT_dp2(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={190,8})));
        Modelica.Fluid.Sources.FixedBoundary OUT_mflow2(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={190,-32})));
        Modelica.Fluid.Sources.MassFlowSource_T IN_mflow2(
          T=system.T_ambient,
          nPorts=1,
          use_m_flow_in=true,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={50,-32})));
        Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate from_dp2(
                                                            redeclare package
            Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          a=1,
          b=0) "Calculate mass flow rate from pressure loss" 
          annotation (Placement(transformation(extent={{76,-16},{124,32}})));

        Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate from_mflow2(
                                                               redeclare
            package Medium = 
                     Modelica.Media.Water.ConstantPropertyLiquidWater,
          a=1,
          b=0) "Calculate pressure loss from mass flow rate" 
          annotation (Placement(transformation(extent={{76,-56},{124,-8}})));

      public
        Modelica.Blocks.Sources.RealExpression input_p3(y=from_mflow3.port_a.p) 
          annotation (extent=[-100, 0; -80, 20], Placement(transformation(extent={{-200,
                  -82},{-180,-62}})));
        Modelica.Fluid.Sources.Boundary_pT IN_p3(
          nPorts=1,
          T(displayUnit="K") = system.T_ambient,
          p(displayUnit="Pa") = system.p_ambient,
          use_p_in=true,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(extent={{-160,-80},{-140,-60}})));
        Modelica.Fluid.Sources.FixedBoundary OUT_dp3(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-10,-70})));
        Modelica.Fluid.Sources.FixedBoundary OUT_mflow3(
          p=system.p_ambient,
          T=system.T_ambient,
          nPorts=1,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-10,-110})));
        Modelica.Fluid.Sources.MassFlowSource_T IN_mflow3(
          T=system.T_ambient,
          nPorts=1,
          use_m_flow_in=true,
          redeclare package Medium = 
              Modelica.Media.Water.ConstantPropertyLiquidWater) 
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-150,-110})));
        Modelica.Fluid.Fittings.Bends.CurvedBend from_dp3(       redeclare
            package Medium = 
                     Modelica.Media.Water.ConstantPropertyLiquidWater, geometry(
              d_hyd=0.1, R_0=0.2))
          "Calculate mass flow rate from pressure loss" 
          annotation (Placement(transformation(extent={{-124,-94},{-76,-46}})));

        Modelica.Fluid.Fittings.Bends.CurvedBend from_mflow3(       redeclare
            package Medium = 
                     Modelica.Media.Water.ConstantPropertyLiquidWater, geometry(
              d_hyd=0.1, R_0=0.2))
          "Calculate pressure loss from mass flow rate" 
          annotation (Placement(transformation(extent={{-124,-134},{-76,-86}})));

      equation
        connect(IN_p.ports[1], from_dp.port_a) annotation (Line(
            points={{60,168},{76,168}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_dp.port_b, OUT_dp.ports[1]) annotation (Line(
            points={{124,168},{180,168}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow.port_b, OUT_mflow.ports[1]) annotation (Line(
            points={{124,128},{180,128}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow.port_a, IN_mflow.ports[1]) annotation (Line(
            points={{76,128},{60,128}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(input_p.y, IN_p.p_in) annotation (Line(
            points={{21,166},{28,166},{28,176},{38,176}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(IN_p2.ports[1], from_dp2.port_a) annotation (Line(
            points={{60,8},{76,8}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_dp2.port_b, OUT_dp2.ports[1]) annotation (Line(
            points={{124,8},{152,8},{152,8},{180,8}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow2.port_b, OUT_mflow2.ports[1]) annotation (Line(
            points={{124,-32},{180,-32}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow2.port_a, IN_mflow2.ports[1]) annotation (Line(
            points={{76,-32},{60,-32}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(input_p2.y, IN_p2.p_in) annotation (Line(
            points={{21,6},{28,6},{28,16},{38,16}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(IN_p3.ports[1], from_dp3.port_a) annotation (Line(
            points={{-140,-70},{-124,-70}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_dp3.port_b, OUT_dp3.ports[1]) annotation (Line(
            points={{-76,-70},{-20,-70}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow3.port_b, OUT_mflow3.ports[1]) annotation (Line(
            points={{-76,-110},{-20,-110}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(from_mflow3.port_a, IN_mflow3.ports[1]) annotation (Line(
            points={{-124,-110},{-140,-110}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(input_p3.y, IN_p3.p_in) annotation (Line(
            points={{-179,-72},{-172,-72},{-172,-62},{-162,-62}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(input_mflow.y, IN_mflow.m_flow_in) annotation (Line(
            points={{-179,-2},{-174,-2},{-174,136},{40,136}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(input_mflow.y, IN_mflow2.m_flow_in) annotation (Line(
            points={{-179,-2},{-174,-2},{-174,-24},{40,-24}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(input_mflow.y, IN_mflow3.m_flow_in) annotation (Line(
            points={{-179,-2},{-174,-2},{-174,-102},{-160,-102}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Documentation(info="<html>
<p>
Switch to the diagram or equation layer to see the model of a <b> Modelica.Fluid bend </b> using <b> Fluid.Dissipation pressure loss calculations </b>.
</p>

<p>
This model executes pressure loss calculations out of the <b> Fluid.Dissipation </b> library for a bend of an incompressible and single-phase fluid flow considering surface roughness. Both the <b> compressible </b> case, where the mass flow rate (M_FLOW) is calculated in dependence of a known pressure loss (dp) and the <b> incompressible </b> case, where the pressure loss (DP) is calculated in dependence of a known mass flow rate (m_flow) are modelled.
</p>
</html>
"),       experiment(StopTime=1.01, NumberOfIntervals=5000),
          experimentSetupOutput,
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,-200},{200,
                  200}}), graphics={
              Text(
                extent={{-50,202},{32,188}},
                lineColor={0,0,255},
                textString="SeveralTestCases"),
              Text(
                extent={{-90,158},{-8,144}},
                lineColor={0,0,255},
                textString="EdgedBend"),
              Text(
                extent={{-100,-6},{-18,-20}},
                lineColor={0,0,255},
                textString="RectangularChannel"),
              Text(
                extent={{10,-83},{92,-97}},
                lineColor={0,0,255},
                textString="StraightPipe")}),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-200,-200},{200,
                  200}})));
      end SeveralTestCases;

    end PressureLoss;
  end TestCases;

annotation (classOrder={"Verifications","Applications","TestCases"});
end FluidDissipation;
