within Modelica.Fluid;
package Fittings
  "Adaptors for connections of fluid components and the regulation of fluid flow"
  package HeatTransfer "Fittings for heat transfer"
  extends Modelica.Fluid.Dissipation.Utilities.Icons.VariantLibrary;

    model ChannelHeatTransferModel
      "Application model for a channel in Modelica_Fluid"

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Channel_i;

      //interfaces
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
        "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
              rotation=0)));

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (Dialog(group="Fluid properties"),
          choicesAllMatching=true);

      //heat transfer calculation
      replaceable package HeatTransferLam =
          BaseClasses.Channel.Laminar constrainedby BaseClasses.Channel.Laminar
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 1), choicesAllMatching=
            true);

      replaceable package HeatTransferOver =
          BaseClasses.Channel.Overall constrainedby BaseClasses.Channel.Overall
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 2), choicesAllMatching=
            true);

      replaceable package HeatTransferTurb =
          BaseClasses.Channel.Turbulent constrainedby
        BaseClasses.Channel.Turbulent
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 3), choicesAllMatching=
            true);

      //channel
      parameter Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap target=1
        "Target variable of calculation (only for laminar regime)" annotation (
          Dialog(group="Even gap", enable=if fluidFlowRegime == 1 or
              fluidFlowRegime == 2 then true else false));
      parameter Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime
        fluidFlowRegime=
         2 "Choice of fluid flow regime"
                                      annotation (Dialog(group="Heat transfer"));
      parameter SI.Length h=0.1 "Height of cross sectional area"
        annotation (Dialog(group="Even gap"));
      parameter SI.Length s=0.01
        "Distance between parallel plates in cross sectional area"
        annotation (Dialog(group="Even gap"));
      parameter SI.Length L=1 "Overflowed length of gap"
        annotation (Dialog(group="Even gap"));

      //input
      input SI.MassFlowRate m_flow "Mass flow rate"
        annotation (Dialog(group="Input"));

      //target
      Real kc "Mean convective heat transfer coefficient for channel";
      SI.HeatFlowRate Q_flow=thermalPort.Q_flow "Heat flow rate over boundary";

      //thermodynamic state from (missing) volume
      //outer Medium.ThermodynamicState state;
      outer Modelica.Fluid.Fittings.HeatTransfer.StateForHeatTransfer
        stateForHeatTransfer;

      //input records
      BaseClasses.Channel.BaseChannelHT.HeatTransferChannel_con IN_con(
        target=target,
        h=h,
        s=s,
        L=L) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

      BaseClasses.Channel.BaseChannelHT.HeatTransferChannel_var IN_var(
        cp=cp,
        eta=eta,
        lambda=lambda,
        rho=rho,
        m_flow=m_flow)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

    protected
      parameter SI.Diameter d_hyd=2*s "Hydraulic diameter of (finite) gap";
      parameter SI.Area A_kc=s*h
        "Heat transfer area for convective heat transfer coefficient (kc)";
      parameter SI.Area A_cross=s*h "cross sectional area";

      //fluid properties
      SI.SpecificHeatCapacityAtConstantPressure cp=Medium.heatCapacity_cp(
          stateForHeatTransfer.state);
      SI.DynamicViscosity eta=Medium.dynamicViscosity(stateForHeatTransfer.state);
      SI.ThermalConductivity lambda=Medium.thermalConductivity(stateForHeatTransfer.state);
      SI.Density rho=Medium.density(stateForHeatTransfer.state);
      SI.Temp_K T=Medium.temperature(stateForHeatTransfer.state) + 273.15;

      SI.Velocity velocity=abs(m_flow)/max(Modelica.Constants.eps, (rho*A_cross))
        "Mean velocity";
      SI.ReynoldsNumber Re=rho*velocity*d_hyd/eta;
      SI.NusseltNumber Nu=kc*d_hyd/lambda;

    equation
      if fluidFlowRegime == 1 then
        kc = HeatTransferLam.coefficientOfHeatTransfer(IN_con, IN_var);
      elseif fluidFlowRegime == 2 then
        kc = HeatTransferOver.coefficientOfHeatTransfer(IN_con, IN_var);
      elseif fluidFlowRegime == 3 then
        kc = HeatTransferTurb.coefficientOfHeatTransfer(IN_con, IN_var);
      else
        kc = 0;
        assert(true, "Fluid flow regime is not selected");
      end if;

      //heat transfer rate is negative if outgoing out of system
      thermalPort.Q_flow = kc*A_kc*(thermalPort.T - T);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-150,-70},{150,-110}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}}), graphics));
    end ChannelHeatTransferModel;

    model GeneralHeatTransferModel
      "Application model for a generic geometry in Modelica_Fluid"

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.General_i;

      //interfaces
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
        "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
              rotation=0)));

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (Dialog(group="Fluid properties"),
          choicesAllMatching=true);

      //heat transfer calculation
      replaceable package HeatTransferTurb =
          BaseClasses.General.Turbulent constrainedby
        BaseClasses.General.Turbulent
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 3), choicesAllMatching=
            true);

      //generic geometry
      Modelica.Fluid.Dissipation.Utilities.Types.kc_general target=Dissipation.Utilities.Types.kc_general.Finest
        "Target correlation" annotation (Dialog(group="Generic geometry"));
      parameter SI.Area A_cross=Modelica.Constants.pi*0.1^2/4
        "Cross sectional area" annotation (Dialog(group="Generic geometry"));
      parameter SI.Length perimeter=Modelica.Constants.pi*0.1
        "Wetted perimeter"
        annotation (Dialog(group="Generic geometry"));
      parameter Real exp_Pr=0.4
        "Exponent for Prandtl number w.r.t. Dittus/Boelter | 0.4 for heating | 0.3 for cooling"
        annotation (Dialog(group="Generic geometry",enable=if target == 1 then true else
                    false));
      parameter SI.Length length=1 "Length"
        annotation (Dialog(group="Generic geometry"));
      SI.DynamicViscosity eta_wall=1e-3
        "Dynamic viscosity of fluid at wall temperature" annotation (Dialog(group=
              "Fluid properties", enable=if target == 2 then true else false));

      //input
      input SI.MassFlowRate m_flow "Mass flow rate"
        annotation (Dialog(group="Input"));

      //target
      Real kc "Mean convective heat transfer coefficient for channel";
      SI.HeatFlowRate Q_flow=thermalPort.Q_flow "Heat flow rate over boundary";

      //thermodynamic state from (missing) volume
      //outer Medium.ThermodynamicState state;
      outer Modelica.Fluid.Fittings.HeatTransfer.StateForHeatTransfer
        stateForHeatTransfer;

      //input records
      BaseClasses.General.BaseGeneralHT.HeatTransferGeneral_con IN_con(
        target=target,
        A_cross=A_cross,
        perimeter=perimeter,
        exp_Pr=exp_Pr)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

      BaseClasses.General.BaseGeneralHT.HeatTransferGeneral_var IN_var(
        cp=cp,
        eta=eta,
        lambda=lambda,
        rho=rho,
        eta_wall=eta_wall,
        m_flow=m_flow)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

    protected
      Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime
        fluidFlowRegime=
          Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Turbulent
        "Choice of fluid flow regime" annotation (Dialog(group="Heat transfer"));

      parameter SI.Area A_kc=perimeter*length "Convective heat transfer area";
      parameter SI.Diameter d_hyd=4*A_cross/perimeter "Hydraulic diameter";

      SI.SpecificHeatCapacityAtConstantPressure cp=Medium.heatCapacity_cp(
          stateForHeatTransfer.state);
      SI.DynamicViscosity eta=Medium.dynamicViscosity(stateForHeatTransfer.state);
      SI.ThermalConductivity lambda=Medium.thermalConductivity(stateForHeatTransfer.state);
      SI.Density rho=Medium.density(stateForHeatTransfer.state);
      SI.Temp_K T=Medium.temperature(stateForHeatTransfer.state) + 273.15;

      SI.Velocity velocity=abs(m_flow)/max(Modelica.Constants.eps, (rho*A_cross))
        "Mean velocity";
      SI.ReynoldsNumber Re=rho*velocity*d_hyd/eta;
      SI.NusseltNumber Nu=kc*d_hyd/lambda;

    equation
      if fluidFlowRegime == Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Turbulent then
        kc = HeatTransferTurb.coefficientOfHeatTransfer(IN_con, IN_var);
      else
        kc = 0;
        assert(true, "Fluid flow regime is not selected");
      end if;

      //heat transfer rate is negative if outgoing out of system
      thermalPort.Q_flow = kc*A_kc*(thermalPort.T - T);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-146,-72},{154,-112}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}));
    end GeneralHeatTransferModel;

    model HeatExchangerHeatTransferModel
      "Application model for a heat exchanger in Modelica_Fluid"

      //icon
      extends
        Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HeatExchanger_i;

      //interfaces
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
        "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
              rotation=0), iconTransformation(extent={{-20,100},{20,120}})));

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (Dialog(group="Fluid properties"),
          choicesAllMatching=true);

      //choice for heat exchanger heat transfer model
      replaceable model HeatTransfer =
          BaseClasses.HeatExchanger.FlatTube.FlatTubeHeatTransferModel
        constrainedby
        BaseClasses.HeatExchanger.BaseHeatExchangerHT.BaseHeatExchangerModel
        "1st: choose heat transfer calculation | 2nd: edit corresponding record"
        annotation (Dialog(group="Heat transfer"), choicesAllMatching=true);

      //input
      input SI.MassFlowRate m_flow "Mass flow rate"
        annotation (Dialog(group="Input"));

      //instance of chosen heat transfer model
      HeatTransfer heatTransferModel(
        m_flow=m_flow,
        cp=cp,
        eta=eta,
        lambda=lambda,
        rho=rho,
        T=T) annotation (Placement(transformation(extent={{-18,-18},{18,18}})));

      //thermodynamic state from (missing) volume
      //outer Medium.ThermodynamicState state;
      outer Modelica.Fluid.Fittings.HeatTransfer.StateForHeatTransfer
        stateForHeatTransfer;

      //fluid properties
    protected
      SI.SpecificHeatCapacityAtConstantPressure cp=Medium.heatCapacity_cp(
          stateForHeatTransfer.state);
      SI.DynamicViscosity eta=Medium.dynamicViscosity(stateForHeatTransfer.state);
      SI.ThermalConductivity lambda=Medium.thermalConductivity(stateForHeatTransfer.state);
      SI.Density rho=Medium.density(stateForHeatTransfer.state);
      SI.Temp_K T=Medium.temperature(stateForHeatTransfer.state) + 273.15;

    equation
      connect(heatTransferModel.thermalPort, thermalPort) annotation (Line(
          points={{0,19.8},{0,70}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                                             Text(
              extent={{-146,-76},{154,-116}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}));
    end HeatExchangerHeatTransferModel;

    model HelicalPipeHeatTransferModel
      "Application model for a helical pipe in Modelica_Fluid"

      //icon
      extends
        Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HelicalPipe_i;

      //interfaces
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
        "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
              rotation=0)));

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (Dialog(group="Fluid properties"),
          choicesAllMatching=true);

      //heat transfer calculation
      /*replaceable package HeatTransfer =
      Fluid.Dissipation.Examples.Applications.HelicalPipe.Overall constrainedby
    Fluid.Dissipation.Examples.Applications.HelicalPipe.BaseHelicalPipeHT
    "characteristic of convective heat transfer" annotation (Dialog(group=
          "Heat transfer"), choicesAllMatching=true);*/
      replaceable package HeatTransferLam =
          BaseClasses.HelicalPipe.Laminar constrainedby
        BaseClasses.HelicalPipe.Laminar
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 1), choicesAllMatching=
            true);
      replaceable package HeatTransferOver =
          BaseClasses.HelicalPipe.Overall constrainedby
        BaseClasses.HelicalPipe.Overall
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 2), choicesAllMatching=
            true);
      replaceable package HeatTransferTurb =
          BaseClasses.HelicalPipe.Turbulent constrainedby
        BaseClasses.HelicalPipe.Turbulent
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 3), choicesAllMatching=
            true);

      parameter Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime
        fluidFlowRegime=
         Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Overall
        "Choice of fluid flow regime" annotation (Dialog(group="Heat transfer"));

      //helicalPipe
      parameter Real n_nt=1 "Total number of turns"
        annotation (Dialog(group="HelicalPipe"));
      parameter SI.Diameter d_hyd=0.01 "Hydraulic diameter"
        annotation (Dialog(group="HelicalPipe"));
      parameter SI.Length h=1.5*d_hyd "Distance between turns"
        annotation (Dialog(group="HelicalPipe"));
      parameter SI.Length L=10 "Total length of helical pipe"
        annotation (Dialog(group="HelicalPipe"));

      //input
      input SI.MassFlowRate m_flow "Mass flow rate"
        annotation (Dialog(group="Input"));

      //target
      Real kc "Mean convective heat transfer coefficient for helicalPipe";
      SI.HeatFlowRate Q_flow=thermalPort.Q_flow "Heat flow rate over boundary";

      //thermodynamic state from (missing) volume
      //outer Medium.ThermodynamicState state;
      outer Modelica.Fluid.Fittings.HeatTransfer.StateForHeatTransfer
        stateForHeatTransfer;

      //input records
      BaseClasses.HelicalPipe.BaseHelicalPipeHT.HeatTransferHelicalPipe_con
        IN_con(
        n_nt=n_nt,
        d_hyd=d_hyd,
        h=h,
        L=L) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

      BaseClasses.HelicalPipe.BaseHelicalPipeHT.HeatTransferHelicalPipe_var
        IN_var(
        cp=cp,
        eta=eta,
        lambda=lambda,
        rho=rho,
        m_flow=m_flow)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

    protected
      parameter SI.Area A_cross=Constants.pi
                                  *d_hyd^2/4 "Cross sectional area";
      parameter SI.Area A_kc=Constants.pi
                               *d_hyd*L "Convective heat transfer area";

      //fluid properties
      SI.SpecificHeatCapacityAtConstantPressure cp=Medium.heatCapacity_cp(
          stateForHeatTransfer.state);
      SI.DynamicViscosity eta=Medium.dynamicViscosity(stateForHeatTransfer.state);
      SI.ThermalConductivity lambda=Medium.thermalConductivity(stateForHeatTransfer.state);
      SI.Density rho=Medium.density(stateForHeatTransfer.state);
      SI.Temp_K T=Medium.temperature(stateForHeatTransfer.state) + 273.15;

      SI.Velocity velocity=abs(m_flow)/max(Modelica.Constants.eps, (rho*A_cross))
        "Mean velocity";
      SI.ReynoldsNumber Re=rho*velocity*d_hyd/eta;
      SI.NusseltNumber Nu=kc*d_hyd/lambda;

    equation
      if fluidFlowRegime == Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Laminar then
        kc = HeatTransferLam.coefficientOfHeatTransfer(IN_con, IN_var);
      elseif fluidFlowRegime == Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Overall then
        kc = HeatTransferOver.coefficientOfHeatTransfer(IN_con, IN_var);
      elseif fluidFlowRegime == Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Turbulent then
        kc = HeatTransferTurb.coefficientOfHeatTransfer(IN_con, IN_var);
      else
        kc = 0;
        assert(true, "Fluid flow regime is not selected");
      end if;

      //heat transfer rate is negative if outgoing out of system
      thermalPort.Q_flow = kc*A_kc*(thermalPort.T - T);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-146,-84},{154,-124}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}));
    end HelicalPipeHeatTransferModel;

    model PlateHeatTransferModel
      "Application model for a plate in Modelica_Fluid"

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Plate_i;

      //interfaces
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
        "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
              rotation=0)));

      replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium in the component"
        annotation (Dialog(group="Fluid properties"), choicesAllMatching=true);

      //heat transfer calculation
      replaceable package HeatTransfer =
          BaseClasses.Plate.Overall constrainedby BaseClasses.Plate.BasePlateHT
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer"), choicesAllMatching=true);

      //plate
      parameter SI.Length length=1 "Length of plate"
        annotation (Dialog(group="Plate"));
      parameter SI.Length width=1 "Width of plate"
        annotation (Dialog(group="Plate"));

      //input
      input SI.Velocity velocity "fluid flow velocity around plate"
        annotation (Dialog(group="Input"));

      //target
      Real kc "mean convective heat transfer coefficient for plate";
      SI.HeatFlowRate Q_flow=thermalPort.Q_flow "heat flow rate over boundary";

      //thermodynamic state from (missing) volume
      //outer Medium.ThermodynamicState state;
      outer Modelica.Fluid.Fittings.HeatTransfer.StateForHeatTransfer
        stateForHeatTransfer;

      //input records
      BaseClasses.Plate.BasePlateHT.HeatTransferPlate_con IN_con(L=length)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

      BaseClasses.Plate.BasePlateHT.HeatTransferPlate_var IN_var(
        eta=eta,
        lambda=lambda,
        rho=rho,
        velocity=velocity)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

    protected
      parameter SI.Area A_kc=length*width "Convective heat transfer area";

      //fluid properties
      SI.SpecificHeatCapacityAtConstantPressure cp=Medium.heatCapacity_cp(
          stateForHeatTransfer.state);
      SI.DynamicViscosity eta=Medium.dynamicViscosity(stateForHeatTransfer.state);
      SI.ThermalConductivity lambda=Medium.thermalConductivity(stateForHeatTransfer.state);
      SI.Density rho=Medium.density(stateForHeatTransfer.state);
      SI.Temp_K T=Medium.temperature(stateForHeatTransfer.state) + 273.15;

      SI.ReynoldsNumber Re=rho*velocity*length/eta;
      SI.NusseltNumber Nu=kc*length/lambda;

    equation
      kc = HeatTransfer.coefficientOfHeatTransfer(IN_con, IN_var);

      //heat transfer rate is negative if outgoing out of system
      thermalPort.Q_flow = kc*A_kc*(thermalPort.T - T);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-138,-64},{162,-104}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}));
    end PlateHeatTransferModel;

    model StraightPipeHeatTransferModel
      "Application model for a straight pipe in Modelica_Fluid"

      //icon
      extends
        Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.StraightPipe_i;

      //interfaces
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
        "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
              rotation=0)));

      replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium in the component"
        annotation (Dialog(group="Fluid properties"), choicesAllMatching=true);

      //heat transfer calculation
      replaceable package HeatTransferLam =
          BaseClasses.StraightPipe.Laminar constrainedby
        BaseClasses.StraightPipe.Laminar
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 1), choicesAllMatching=
            true);
      replaceable package HeatTransferOver =
          BaseClasses.StraightPipe.Overall constrainedby
        BaseClasses.StraightPipe.Overall
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 2), choicesAllMatching=
            true);
      replaceable package HeatTransferTurb =
          BaseClasses.StraightPipe.Turbulent constrainedby
        BaseClasses.StraightPipe.Turbulent
        "Characteristic of convective heat transfer" annotation (Dialog(group=
              "Heat transfer", enable=fluidFlowRegime == 3), choicesAllMatching=
            true);
      parameter Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime
        fluidFlowRegime=
         Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Overall
        "Choice of fluid flow regime" annotation (Dialog(group="Heat transfer"));

      //straightPipe
      parameter Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary
        target=
          Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF
        "Choice of heat transfer boundary condition" annotation (Dialog(group=
              "Straight pipe", enable=if fluidFlowRegime == 1 or fluidFlowRegime
               == 2 then true else false));
      parameter Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
        "Choice of considering surface roughness" annotation (Dialog(group=
              "Straight pipe", enable=if not (fluidFlowRegime == 1) then true else
              false));

      parameter SI.Diameter d_hyd=0.1 "Hydraulic diameter"
        annotation (Dialog(group="Straight pipe"));
      parameter SI.Length L=1 "Length" annotation (Dialog(group="Straight pipe"));

      //input
      input SI.MassFlowRate m_flow "mass flow rate"
        annotation (Dialog(group="Input"));

      //target
      Real kc "Mean convective heat transfer coefficient for StraightPipe";
      SI.HeatFlowRate Q_flow=thermalPort.Q_flow "Heat flow rate over boundary";

      //thermodynamic state from (missing) volume
      //outer Medium.ThermodynamicState state;
      outer Modelica.Fluid.Fittings.HeatTransfer.StateForHeatTransfer
        stateForHeatTransfer;

      //input records
      BaseClasses.StraightPipe.BaseStraightPipeHT.HeatTransferStraightPipe_con
        IN_con(
        d_hyd=d_hyd,
        L=L,
        target=target,
        roughness=roughness)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

      BaseClasses.StraightPipe.BaseStraightPipeHT.HeatTransferStraightPipe_var
        IN_var(
        cp=cp,
        eta=eta,
        lambda=lambda,
        rho=rho,
        m_flow=m_flow)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

    protected
      parameter SI.Area A_cross=Constants.pi
                                  *d_hyd^2/4 "Cross sectional area";
      parameter SI.Area A_kc=Constants.pi
                               *d_hyd*L "Convective heat transfer area";

      //fluid properties
      SI.SpecificHeatCapacityAtConstantPressure cp=Medium.heatCapacity_cp(
          stateForHeatTransfer.state);
      SI.DynamicViscosity eta=Medium.dynamicViscosity(stateForHeatTransfer.state);
      SI.ThermalConductivity lambda=Medium.thermalConductivity(stateForHeatTransfer.state);
      SI.Density rho=Medium.density(stateForHeatTransfer.state);
      SI.Temp_K T=Medium.temperature(stateForHeatTransfer.state) + 273.15;

      SI.Velocity velocity=abs(m_flow)/max(Modelica.Constants.eps, (rho*A_cross))
        "Mean velocity";
      SI.ReynoldsNumber Re=rho*velocity*d_hyd/eta;
      SI.NusseltNumber Nu=kc*d_hyd/lambda;

    equation
      if fluidFlowRegime == Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Laminar then
        kc = HeatTransferLam.coefficientOfHeatTransfer(IN_con, IN_var);
      elseif fluidFlowRegime == Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Overall then
        kc = HeatTransferOver.coefficientOfHeatTransfer(IN_con, IN_var);
      elseif fluidFlowRegime == Modelica.Fluid.Dissipation.Utilities.Types.FluidFlowRegime.Turbulent then
        kc = HeatTransferTurb.coefficientOfHeatTransfer(IN_con, IN_var);
      else
        kc = 0;
        assert(true, "Fluid flow regime is not selected");
      end if;

      //heat transfer rate is negative if outgoing out of system
      thermalPort.Q_flow = kc*A_kc*(thermalPort.T - T);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-144,-66},{156,-106}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}));
    end StraightPipeHeatTransferModel;

    model StateForHeatTransfer "Substitute volume model"

      replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium in the component"
        annotation (Dialog(group="Fluid properties"), choicesAllMatching=true);
      Medium.BaseProperties medium;

      //definition of (missing) thermodynamic state for heat transfer calculation
      Medium.ThermodynamicState state=medium.state;

      Modelica.SIunits.Pressure p_state=1e5 "Pressure of state"
                                                  annotation (Dialog(group="State"));
      Modelica.SIunits.Temp_C t_state=20 "Temperature of state"
                                                  annotation (Dialog(group="State"));

    equation
      medium.p = p_state;
      medium.T = t_state + 273.15;

      annotation (
        defaultComponentName="stateForHeatTransfer",
        defaultComponentPrefixes="inner",
        missingInnerMessage="
Your model is using an outer \"stateForHeatTransfer\" component but
an inner \"stateForHeatTransfer\" component is not defined.
For simulation drag Modelica.Fluid.Fittings.HeatTransfer.StateForHeatTransfer into your model
to specify system properties. The default StateForHeatTransfer setting
is used for the current simulation.
",      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-40,-46},{52,-128}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="%name"),Text(
              extent={{-46,46},{46,-36}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="p,T")}));
    end StateForHeatTransfer;

    package BaseClasses "Base classes for heat transfer applications"
    extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

      partial model BaseHeatTransferModel

        //interfaces
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
          "Thermal port" annotation (Placement(transformation(extent={{-20,60},{20,80}},
                rotation=0), iconTransformation(extent={{-20,100},{20,120}})));

        //input
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //fluid properties
        input SI.SpecificHeatCapacityAtConstantPressure cp
          "Specific heat capacity of fluid at constant pressure";
        input SI.DynamicViscosity eta "Dynamic viscosity of fluid";
        input SI.ThermalConductivity lambda "Thermal conductivity of fluid";
        input SI.Density rho "Density of fluid";
        input SI.Temp_K T "Temperature of fluid";

        //target
        Real kc "Mean convective heat transfer coefficient for channel";
        SI.HeatFlowRate Q_flow=thermalPort.Q_flow
          "Heat flow rate over boundary";

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end BaseHeatTransferModel;

      package Channel
        "Base package for heat transfer application of a channel with Modelica_Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package BaseChannelHT
          "Base package for all heat transfer functions of a channel"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function coefficientOfHeatTransfer
            "Base function for channel"
          extends Modelica.Icons.Function;

          //Input record for channel
          input HeatTransferChannel_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input HeatTransferChannel_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          //Convective heat transfer coefficient as output
          output SI.CoefficientOfHeatTransfer kc
              "Convective heat transfer coefficient";

        end coefficientOfHeatTransfer;

          record HeatTransferChannel_con "Input record for channel functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer functions of <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.Channel\"> channels </a> implemented in Modelica_Fluid as thermo-hydraulic framework.
</html>"));
          end HeatTransferChannel_con;

          record HeatTransferChannel_var "Input record for channel functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer functions of <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.Channel\"> channels </a> implemented in Modelica_Fluid as thermo-hydraulic framework.
</html>"));
          end HeatTransferChannel_var;
        end BaseChannelHT;

        package Laminar "Fluid.Dissipation: Laminar fluid flow in an even gap"
        extends BaseChannelHT;
        constant String fluidFlowRegime="laminar regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(
              IN_con, IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC\"> kc_evenGapLaminar_KC </a> of an even gap out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Fluid.Dissipation.Examples.Applications.Channel\"> channels </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the heat transfer calculation of an even gap at a laminar flow regime of an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of channels is available as <a href=\"Modelica://Fluid.Dissipation.Examples.TestCases.HeatTransfer.Channel\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>"));
        end Laminar;

        package Overall "Fluid.Dissipation: Overall fluid flow of an even gap"
        extends BaseChannelHT;
        constant String fluidFlowRegime="overall regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC(
              IN_con, IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC\"> kc_evenGapOverall_KC </a> of an even gap out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Fluid.Dissipation.Examples.Applications.Channel\"> channels </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the heat transfer calculation of an even gap at an overall flow regime of an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of channels is available as <a href=\"Modelica://Fluid.Dissipation.Examples.TestCases.Channel\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>"));
        end Overall;

        package Turbulent
          "Fluid.Dissipation: Turbulent fluid flow in an even gap"
        extends BaseChannelHT;
        constant String fluidFlowRegime="turbulent regime";

        redeclare function extends coefficientOfHeatTransfer(IN_con, IN_var)

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC(
              IN_con, IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulentRoughness_KC\"> kc_evenGapTurbulentRoughness_KC </a> of an even gap out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Fluid.Dissipation.Examples.Applications.Channel\"> channels </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the heat transfer calculation of an even gap at an turbulent flow regime of an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of channels is available as <a href=\"Modelica://Fluid.Dissipation.Examples.TestCases.Channel\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>"));
        end Turbulent;
      end Channel;

      package General
        "Base package for heat transfer application of a generic geometry with Modelica_Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package BaseGeneralHT
          "Base package for all heat transfer functions of a generic geometry"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function coefficientOfHeatTransfer
            "Base function for generic geometry"
          extends Modelica.Icons.Function;

          //Input record for channel
          input HeatTransferGeneral_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input HeatTransferGeneral_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          //Convective heat transfer coefficient as output
          output SI.CoefficientOfHeatTransfer kc
              "Convective heat transfer coefficient";

        end coefficientOfHeatTransfer;

          record HeatTransferGeneral_con "Input record for generic functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer functions of <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.General\"> generic geometries </a> implemented in Modelica_Fluid as thermo-hydraulic framework.
</html>"));
          end HeatTransferGeneral_con;

          record HeatTransferGeneral_var "Input record for generic functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer functions of <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.General\"> generic geometries </a> implemented in Modelica_Fluid as thermo-hydraulic framework.
</html>"));
          end HeatTransferGeneral_var;
        end BaseGeneralHT;

        package Turbulent
          "Fluid.Dissipation: Turbulent fluid flow in generic geometries"
        extends BaseGeneralHT;
        constant String fluidFlowRegime="turbulent regime";

        redeclare function extends coefficientOfHeatTransfer(IN_con, IN_var)

        algorithm
            kc :=
              Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC(
              IN_con, IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.HeatTransfer.General.kc_approxForcedConvection_KC\"> HeatTransfer.General.kc_approxForcedConvection_KC </a> of a generic geometry out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Fluid.Dissipation.Examples.Applications.General\"> generic geometries </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the heat transfer calculation of an even gap at an turbulent flow regime of an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of channels is available as <a href=\"Modelica://Fluid.Dissipation.Examples.TestCases.General\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>"));
        end Turbulent;
      end General;

      package HeatExchanger
        "Application package for heat transfer for a heat exchanger with Modelica_Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package BaseHeatExchangerHT
          "Base package for all heat transfer functions of a haet exchanger"
          extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

          replaceable partial function coefficientOfHeatTransfer
            "base function for heat Exchanger"
            extends Modelica.Icons.Function;

            //convective heat transfer coefficient as output
            output SI.CoefficientOfHeatTransfer kc
              "convective heat transfer coefficient";

          end coefficientOfHeatTransfer;

          partial model BaseHeatExchangerModel
            "Base heat transfer model for heat exchanger functions in Modelica.Fluid"

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HeatExchanger_i;

            extends BaseClasses.BaseHeatTransferModel;

          end BaseHeatExchangerModel;
        end BaseHeatExchangerHT;

        package FlatTube "Fluid.Dissipation: Heat Exchanger with flat tubes"
          extends BaseHeatExchangerHT;

          redeclare function extends coefficientOfHeatTransfer

            //Input record for heat exchanger
            input HeatTransferHeatExchanger_con IN_con
                     annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
            input HeatTransferHeatExchanger_var IN_var
                     annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC(
              IN_con, IN_var);

          end coefficientOfHeatTransfer;

          model FlatTubeHeatTransferModel
            "Flat tube heat exchanger: Application heat transfer model for flat tube function in Modelica.Fluid"
            extends BaseHeatExchangerHT.BaseHeatExchangerModel;

            parameter
              Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes
              geometry=1 "Choice of fin geometry"
                                       annotation (Dialog(group="HeatExchanger"));

            parameter SI.Area A_fr=1 "Frontal Area"
              annotation (Dialog(group="HeatExchanger"));
            parameter SI.Length D_h=0.0025 "Hydraulic diameter" annotation (Dialog(
                  group="HeatExchanger", enable=if geometry == 2 then true else false));
            parameter SI.Length D_m=0.002 "Major tube diameter for flat tube"
              annotation (Dialog(group="HeatExchanger"));
            parameter SI.Length F_l=0.01 "Fin length" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 1 then true else false));
            parameter SI.Length F_p=0.0015
              "Fin pitch, fin spacing + fin thickness"
              annotation (Dialog(group="HeatExchanger", enable=if geometry == 1 then
                    true else false));
            parameter SI.Length L=0.1 "Heat exchanger length"
              annotation (Dialog(group="HeatExchanger"));
            parameter SI.Length L_l=0.001 "Louver length" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 1 then true else false));
            parameter SI.Length L_p=0.0025 "Louver pitch" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 1 then true else false));
            parameter SI.Length T_d=0.02 "Tube depth" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 1 then true else false));
            parameter SI.Length T_p=0.01 "Tube pitch" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 1 then true else false));

            parameter Real alpha=0.25
              "Lateral fin spacing (s) / free flow height (h)"
              annotation (Dialog(group="HeatExchanger", enable=if geometry == 2 then
                    true else false));
            parameter Real gamma=0.07
              "Fin thickness (t) / lateral fin spacing (s)"
              annotation (Dialog(group="HeatExchanger", enable=if geometry == 2 then
                    true else false));
            parameter Real delta=0.03 "Fin thickness (t) / Fin length (l)" annotation (
                Dialog(group="HeatExchanger", enable=if geometry == 2 then true else
                    false));
            parameter SI.Length delta_f=0.0001 "Fin thickness" annotation (Dialog(group=
                   "HeatExchanger", enable=if geometry == 1 then true else false));
            parameter SI.Angle Phi=10 "Louver angle" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 1 then true else false));

            HeatTransferHeatExchanger_con IN_con(
              geometry=geometry,
              A_fr=A_fr,
              D_h=D_h,
              D_m=D_m,
              F_l=F_l,
              F_p=F_p,
              L_l=L_l,
              L_p=L_p,
              T_d=T_d,
              T_p=T_p,
              alpha=alpha,
              gamma=gamma,
              delta=delta,
              delta_f=delta_f,
              Phi=Phi)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
            HeatTransferHeatExchanger_var IN_var(
              cp=cp,
              eta=eta,
              lambda=lambda,
              rho=rho,
              m_flow=m_flow)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          protected
            SI.Area A_cross=if geometry == 1 then A_fr*((F_l - delta_f)*(F_p - delta_f)
                /((F_l + D_m)*F_p)) else if geometry == 2 then A_fr*(h*s/((h + t + D_m)
                *(s + t))) else 0 "Minimum flow cross-sectional area";
            SI.Length h=if geometry == 2 then D_h*(1 + alpha)/(2*alpha) else 0
              "Free flow height";
            SI.Length l=if geometry == 2 then t/delta else 0 "Fin length";
            SI.Length s=if geometry == 2 then h*alpha else 0
              "Lateral fin spacing (free flow width)";
            SI.Length t=if geometry == 2 then s*gamma else 0 "Fin thickness";

            SI.Area A_kc=if geometry == 1 then L*A_fr*(2*(F_l + F_p - delta_f)/(F_p*(
                F_l + D_m))) else if geometry == 2 then L*A_fr*(2*(h + s)/((s + t)*(h
                 + t + D_m))) else 0
              "Heat transfer area for convective heat transfer coefficient (kc)";

            SI.Velocity velocity=abs(m_flow)/max(Modelica.Constants.eps, (rho*A_cross))
              "Mean velocity";

            SI.ReynoldsNumber Re=if geometry == 1 then rho*velocity*L_p/eta else if
                geometry == 2 then rho*velocity*D_h/eta else 0
              "Reynolds number based on characteristic length";
            SI.NusseltNumber Nu=if geometry == 1 then kc*L_p/lambda else if geometry
                 == 2 then kc*D_h/lambda else 0 "Nusselt number";

          equation
            kc = coefficientOfHeatTransfer(IN_con, IN_var);

            //heat transfer rate is negative if outgoing out of system
            thermalPort.Q_flow = kc*A_kc*(thermalPort.T - T);

          end FlatTubeHeatTransferModel;

          record HeatTransferHeatExchanger_con
            "input record for heat exchanger functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con;

          end HeatTransferHeatExchanger_con;

          record HeatTransferHeatExchanger_var
            "input record for heat exchanger functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var;

          end HeatTransferHeatExchanger_var;
        end FlatTube;

        package RoundTube "Fluid.Dissipation: Heat Exchanger with round tubes"
          extends BaseHeatExchangerHT;

          redeclare function extends coefficientOfHeatTransfer

            //Input record for heat exchanger
            input HeatTransferHeatExchanger_con IN_con
                     annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
            input HeatTransferHeatExchanger_var IN_var
                     annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC(
              IN_con, IN_var);

          end coefficientOfHeatTransfer;

          model RoundTubeHeatTransferModel
            "Round tube heat exchanger: Application heat transfer model for round tube function in Modelica.Fluid"
            extends BaseHeatExchangerHT.BaseHeatExchangerModel;

            Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_roundTubes
              geometry =                                                               1
              "Choice of fin geometry" annotation (Dialog(group="HeatExchanger"));

            parameter SI.Area A_fr=1 "Frontal Area"
              annotation (Dialog(group="HeatExchanger"));
            parameter SI.Length D_c=0.01 "Fin collar diameter"
              annotation (Dialog(group="HeatExchanger"));
            parameter SI.Length F_p=0.002
              "Fin pitch, fin spacing + fin thickness"
              annotation (Dialog(group="HeatExchanger", enable=if geometry == 1 or
                    geometry == 2 or geometry == 3 or geometry == 4 then true else
                    false));
            parameter SI.Length L=0.1 "Heat exchanger length"
              annotation (Dialog(group="HeatExchanger"));
            parameter SI.Length L_h=0.0015 "Louver height" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 2 then true else false));
            parameter SI.Length L_p=0.0025 "Louver pitch" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 2 then true else false));
            parameter Integer N=2 "Number of tube rows" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 1 or geometry == 2 or
                    geometry == 3 then true else false));
            parameter SI.Length P_d=0.0015
              "Pattern depth of wavy fin, wave height"
              annotation (Dialog(group="HeatExchanger", enable=if geometry == 4 then
                    true else false));
            parameter SI.Length P_l=0.02 "Longitudinal tube pitch" annotation (Dialog(
                  group="HeatExchanger", enable=if geometry == 1 or geometry == 2 or
                    geometry == 3 then true else false));
            parameter SI.Length P_t=0.025 "Transverse tube pitch"
              annotation (Dialog(group="HeatExchanger"));
            parameter SI.Length S_h=0.001 "Slit height" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 3 then true else false));
            parameter SI.Length S_p=0.002 "Slit pitch" annotation (Dialog(group=
                    "HeatExchanger", enable=if geometry == 3 then true else false));
            parameter SI.Length X_f=0.005 "Half wave length of wavy fin" annotation (
                Dialog(group="HeatExchanger", enable=if geometry == 4 then true else
                    false));

            parameter SI.Length delta_f=0.0001 "Fin thickness" annotation (Dialog(group=
                   "HeatExchanger", enable=if geometry == 1 or geometry == 2 or
                    geometry == 3 or geometry == 4 then true else false));

            HeatTransferHeatExchanger_con IN_con(
              geometry=geometry,
              A_fr=A_fr,
              D_c=D_c,
              F_p=F_p,
              L_h=L_h,
              L_p=L_p,
              P_d=P_d,
              P_l=P_l,
              P_t=P_t,
              N=N,
              S_h=S_h,
              S_p=S_p,
              X_f=X_f,
              delta_f=delta_f,
              L=L) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
            HeatTransferHeatExchanger_var IN_var(
              cp=cp,
              eta=eta,
              lambda=lambda,
              rho=rho,
              m_flow=m_flow)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          protected
            SI.Area A_cross=A_fr*((F_p*P_t - F_p*D_c - (P_t - D_c)*delta_f)/(F_p*P_t))
              "Minimum flow cross-sectional area";
            SI.Length D_h=if IN_con.geometry == 2 then 4*A_cross/(A_fr*(2*(P_t - D_c +
                F_p)/(F_p*(P_t - D_c)))) else 0 "Hydraulic diameter";

            SI.Area A_kc=if geometry == 1 or geometry == 2 or geometry == 3 then A_fr*(
                (N*Constants.pi
                     *D_c*(F_p - delta_f) + 2*(P_t*L - N*Constants.pi
                                                           *D_c^2/4))/(P_t*F_p)) else
                if geometry == 4 then A_fr*((N*Constants.pi
                                                 *D_c*(F_p - delta_f) + 2*(P_t*L - N*Constants.pi
                *D_c^2/4))/(P_t*F_p)*(sqrt(X_f^2 + P_d^2)/X_f)) else 0
              "Heat transfer area for convective heat transfer coefficient (kc)";

            SI.Velocity velocity=abs(m_flow)/max(Modelica.Constants.eps, (rho*A_cross))
              "Mean velocity";

            SI.ReynoldsNumber Re=rho*velocity*D_c/eta
              "Reynolds number based on fin collar diameter";
            SI.NusseltNumber Nu=kc*D_c/lambda "Nusselt number";

          equation
            kc = coefficientOfHeatTransfer(IN_con, IN_var);

            //heat transfer rate is negative if outgoing out of system
            thermalPort.Q_flow = kc*A_kc*(thermalPort.T - T);

          end RoundTubeHeatTransferModel;

          record HeatTransferHeatExchanger_con
            "input record for heat exchanger functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con;

          end HeatTransferHeatExchanger_con;

          record HeatTransferHeatExchanger_var
            "input record for heat exchanger functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var;

          end HeatTransferHeatExchanger_var;
        end RoundTube;
      end HeatExchanger;

      package HelicalPipe
        "Application package for heat transfer in a helical pipe with Modelica_Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package BaseHelicalPipeHT
          "Base package for all heat transfer functions of a helical pipe"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function coefficientOfHeatTransfer
            "base function for helical pipes"
          extends Modelica.Icons.Function;

          //input record for helical pipe
          input HeatTransferHelicalPipe_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input HeatTransferHelicalPipe_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          //convective heat transfer coefficient as output
          output SI.CoefficientOfHeatTransfer kc
              "convective heat transfer coefficient";

        end coefficientOfHeatTransfer;

          record HeatTransferHelicalPipe_con
            "input record for helical pipe functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer functions of <a href=\"Modelica://Fluid.Dissipation.HeatTransfer.HelicalPipe\"> helical pipes </a> implemented in Modelica_Fluid as thermo-hydraulic framework.
</html>"));
          end HeatTransferHelicalPipe_con;

          record HeatTransferHelicalPipe_var
            "input record for helical pipe functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer functions of <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe\"> helical pipes </a> implemented in Modelica_Fluid as thermo-hydraulic framework.
</html>"));
          end HeatTransferHelicalPipe_var;
        end BaseHelicalPipeHT;

        package Laminar
          "Fluid.Dissipation: Heat transfer for helical pipe in laminar fluid flow regime"
        extends BaseHelicalPipeHT;
        constant String fluidFlowRegime="laminar regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC(IN_con,
              IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC\"> kc_laminar_KC </a> of a helical pipe out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.HelicalPipe\"> helical pipes </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a helical pipe in the laminar regime for an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of helical pipes is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.HelicalPipe\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>
"));
        end Laminar;

        package Overall
          "Fluid.Dissipation: Heat transfer for helical pipe in overall fluid flow regime"
        extends BaseHelicalPipeHT;
        constant String fluidFlowRegime="overall regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC(IN_con,
              IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC\"> kc_overall_KC </a> of a helical pipe out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.HelicalPipe\"> helical pipes </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a helical pipe in the overall regime for an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of helical pipes is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.HelicalPipe\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>
"));
        end Overall;

        package Turbulent
          "Fluid.Dissipation: Heat transfer for helical pipe in turbulent fluid flow regime"
        extends BaseHelicalPipeHT;
        constant String fluidFlowRegime="turbulent regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC(
              IN_con, IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC\"> kc_turbulent_KC </a> of a helical pipe out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.HelicalPipe\"> helical pipes </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a helical pipe in the turbulent regime for an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of helical pipes is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.HelicalPipe\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>
"));
        end Turbulent;
      end HelicalPipe;

      package Plate
        "Application package for heat transfer for a plate with Modelica_Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package BasePlateHT
          "Base package for all heat transfer functions of a plate"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;
          import FD =
            Modelica.Fluid.Fittings.HeatTransfer.BaseClasses.Plate.BasePlateHT;

        replaceable partial function coefficientOfHeatTransfer
            "base function for plate"
          extends Modelica.Icons.Function;

          //input record for plates
          input HeatTransferPlate_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input HeatTransferPlate_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          //convective heat transfer coefficient as output
          output SI.CoefficientOfHeatTransfer kc
              "convective heat transfer coefficient";

        end coefficientOfHeatTransfer;

          record HeatTransferPlate_con "input record for plate functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer functions of <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate\"> plates </a> implemented in Modelica_Fluid as thermo-hydraulic framework.
</html>"));
          end HeatTransferPlate_con;

          record HeatTransferPlate_var "input record for plate functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer functions of <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate\"> plates </a> implemented in Modelica_Fluid as thermo-hydraulic framework.
</html>"));
          end HeatTransferPlate_var;
        end BasePlateHT;

        package Laminar
          "Fluid.Dissipation: fluid flow around plate for laminar fluid flow regime"
        extends BasePlateHT;
        constant String fluidFlowRegime="laminar regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC(IN_con,
              IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC\"> kc_laminar_KC </a> of a plate out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.Plate\"> plates </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a plate at laminar flow regime for an incompressible and single-phase fluid flow. Here the convective heat transfer coefficient (kc) of a fluid is calculated in dependence of its known velocity above the plate.
</p>

<p>
A test case for implemented heat transfer functions of plates is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.Plate\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>"));
        end Laminar;

        package Overall
          "Fluid.Dissipation: fluid flow around plate for overall fluid flow regime"
        extends BasePlateHT;
        constant String fluidFlowRegime="overall regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC(IN_con,
              IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_mean_overall_KC\"> kc_overall_KC </a> of a plate out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.Plate\"> plates </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a plate at overall flow regime for an incompressible and single-phase fluid flow. Here the convective heat transfer coefficient (kc) of a fluid is calculated in dependence of its known velocity above the plate.
</p>

<p>
A test case for implemented heat transfer functions of plates is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.Plate\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>"));
        end Overall;

        package Turbulent
          "Fluid.Dissipation: fluid flow around plate for turbulent fluid flow regime"
        extends BasePlateHT;
        constant String fluidFlowRegime="turbulent regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC(IN_con,
              IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC\"> kc_turbulent_KC </a> of a plate out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.Plate\"> plates </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a plate at turbulent flow regime for an incompressible and single-phase fluid flow. Here the convective heat transfer coefficient (kc) of a fluid is calculated in dependence of its known velocity above the plate.
</p>

<p>
A test case for implemented heat transfer functions of plates is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.Plate\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>"));
        end Turbulent;
      end Plate;

      package StraightPipe
        "Application package for heat transfer in a straight pipe with Modelica_Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package BaseStraightPipeHT
          "Base package for all heat transfer functions of a straight pipe"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function coefficientOfHeatTransfer
            "base function for straight pipe"

          //input record for straight pipe
          input HeatTransferStraightPipe_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input HeatTransferStraightPipe_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          //convective heat transfer coefficient as output
          output SI.CoefficientOfHeatTransfer kc
              "convective heat tranfer coefficient";

        end coefficientOfHeatTransfer;

          record HeatTransferStraightPipe_con
            "input record for straight pipe functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con;

          end HeatTransferStraightPipe_con;

          record HeatTransferStraightPipe_var
            "input record for straight pipe functions"

            extends
              Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var;

          end HeatTransferStraightPipe_var;
        end BaseStraightPipeHT;

        package Laminar
          "Fluid.Dissipation: Heat transfer for straight pipe in laminar fluid flow regime"
        extends BaseStraightPipeHT;
        constant String fluidFlowRegime="laminar regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC(
              IN_con, IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC\"> kc_laminar_KC </a> of a straight pipe out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.StraightPipe\"> straight pipes </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a straight pipe in the laminar regime for an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of straight pipes is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.HeatTransfer.StraightPipe\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>
"));
        end Laminar;

        package Overall
          "Fluid.Dissipation: Heat transfer for straight pipe in overall fluid flow regime"
        extends BaseStraightPipeHT;
        constant String fluidFlowRegime="overall regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(
              IN_con, IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC\"> kc_overall_KC </a> of a straight pipe out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.StraightPipe\"> straight pipes </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a straight pipe in the overall regime for an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of straight pipes is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.HeatTransfer.StraightPipe\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>
"));
        end Overall;

        package Turbulent
          "Fluid.Dissipation: Heat transfer for straight pipe in turbulent fluid flow regime"
        extends BaseStraightPipeHT;
        constant String fluidFlowRegime="turbulent regime";

        redeclare function extends coefficientOfHeatTransfer

        algorithm
            kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC(
              IN_con, IN_var);

        end coefficientOfHeatTransfer;

        annotation (Documentation(info="<html>
<p>
In this package the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC\"> kc_turbulent_KC </a> of a straight pipe out of the <b> Fluid.Dissipation </b> library is implemented into an usable form for replaceable calculations of convective heat transfer coefficients. All functions for <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.StraightPipe\"> straight pipes </a> are integrated within the <b>Modelica_Fluid </b> library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a straight pipe in the turbulent regime for an incompressible and single-phase fluid flow.
</p>

<p>
A test case for implemented heat transfer functions of straight pipes is available as <a href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.HeatTransfer.StraightPipe\"> volume model</a> for Modelica_Fluid as thermo-hydraulic framework.
</p>

</html>
"));
        end Turbulent;
      end StraightPipe;
    end BaseClasses;
  annotation (classOrder={"ChannelHeatTransferModel","GeneralHeatTransferModel",
        "HelicalPipeHeatTransferModel","PlateHeatTransferModel",
        "StraightPipeHeatTransferModel","BaseClasses"});
  end HeatTransfer;

  package PressureLoss "Fittings for pressure loss models"
  extends Modelica.Fluid.Dissipation.Utilities.Icons.VariantLibrary;

    model BendFlowModel
      "Application flow model for bend functions in Modelica.Fluid"

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Bend_i;

      //choice for bend pressure loss model
      replaceable model FlowModel =
          BaseClasses.Bend.CurvedBend.CurvedBendFlowModel constrainedby
        BaseClasses.Bend.BaseBendPL.BaseBendModel
        "1st: choose pressure loss calculation | 2nd: edit corresponding record"
        annotation (choicesAllMatching=true);

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (choicesAllMatching=true);

      //interfaces
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=0),
            iconTransformation(extent={{110,-10},{90,10}})));

      //instance of flow model for chosen generic pressure loss
      //see definition in PartialFlowModel
      FlowModel flowModel(redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(port_a, flowModel.port_a) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowModel.port_b, port_b) annotation (Line(
          points={{10,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-150,102},{150,62}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics));
    end BendFlowModel;

    model ChannelFlowModel
      "Application flow model for channel functions in Modelica.Fluid"

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Channel_i;

      //choice for channel pressure loss model
      replaceable model FlowModel =
          BaseClasses.Channel.Overall.OverallFlowModel constrainedby
        BaseClasses.Channel.BaseChannelPL.BaseChannelModel
        annotation (choicesAllMatching=true);

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (choicesAllMatching=true);

      //interfaces
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=0),
            iconTransformation(extent={{110,-10},{90,10}})));

      //instance of flow model for chosen generic pressure loss
      //see definition in PartialFlowModel
      FlowModel flowModel(redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(port_a, flowModel.port_a) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowModel.port_b, port_b) annotation (Line(
          points={{10,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-146,112},{154,72}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics));
    end ChannelFlowModel;

    model GeneralFlowModel
      "Application flow model for generic functions in Modelica.Fluid"

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.General_i;

      //choice for generic pressure loss model
      replaceable model FlowModel =
          BaseClasses.General.NominalPressureLossLawDensity.NominalPressureLossLawDensityFlowModel
        constrainedby BaseClasses.General.BaseGeneralPL.BaseGeneralModel
        annotation (choicesAllMatching=true);

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (choicesAllMatching=true);

      //interfaces
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=0),
            iconTransformation(extent={{110,-10},{90,10}})));

      //instance of flow model for chosen generic pressure loss
      //see definition in PartialFlowModel
      FlowModel flowModel(redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(port_a, flowModel.port_a) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowModel.port_b, port_b) annotation (Line(
          points={{10,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-150,92},{150,52}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics));
    end GeneralFlowModel;

    model OrificeFlowModel
      "Application flow model for orifice functions in Modelica.Fluid"

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Orifice_i;

      //choice for orifice pressure loss model
      replaceable model FlowModel =
          BaseClasses.Orifice.ThickEdgedOverall.ThickEdgedOverallFlowModel
        constrainedby BaseClasses.Orifice.BaseOrificePL.BaseOrificeModel
        annotation (choicesAllMatching=true);

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (choicesAllMatching=true);

      //interfaces
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=0),
            iconTransformation(extent={{110,-10},{90,10}})));

      //instance of flow model for chosen generic pressure loss
      //see definition in PartialFlowModel
      FlowModel flowModel(redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(port_a, flowModel.port_a) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowModel.port_b, port_b) annotation (Line(
          points={{10,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-146,102},{154,62}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics));
    end OrificeFlowModel;

    model StraightPipeFlowModel
      "Application flow model for straight pipe functions in Modelica.Fluid"

      //icon
      extends
        Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_i;

      //choice for straight pipe pressure loss model
      replaceable model FlowModel =
          BaseClasses.StraightPipe.Overall.OverallFlowModel constrainedby
        BaseClasses.StraightPipe.BaseStraightPipePL.BaseStraightPipeModel
        annotation (choicesAllMatching=true);

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (choicesAllMatching=true);

      //interfaces
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=0),
            iconTransformation(extent={{110,-10},{90,10}})));

      //instance of flow model for chosen generic pressure loss
      //see definition in PartialFlowModel
      FlowModel flowModel(redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(port_a, flowModel.port_a) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowModel.port_b, port_b) annotation (Line(
          points={{10,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-146,100},{154,60}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics));
    end StraightPipeFlowModel;

    model ValveFlowModel
      "Application flow model for valve functions in Modelica.Fluid"

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Valve_i;

      //choice for valve pressure loss model
      replaceable model FlowModel =
          Modelica.Fluid.Fittings.PressureLoss.BaseClasses.Valve.Overall.OverallFlowModel
        constrainedby
        Modelica.Fluid.Fittings.PressureLoss.BaseClasses.Valve.BaseValvePL.BaseValveModel
        annotation (choicesAllMatching=true);

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (choicesAllMatching=true);

      //interfaces
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=0),
            iconTransformation(extent={{110,-10},{90,10}})));

      //instance of flow model for chosen generic pressure loss
      //see definition in PartialFlowModel
      FlowModel flowModel(redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(port_a, flowModel.port_a) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowModel.port_b, port_b) annotation (Line(
          points={{10,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-152,124},{148,84}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics));
    end ValveFlowModel;

    package BaseClasses
    extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

      partial model BaseFlowModel
        "Base flow model for pressure loss functions in Modelica.Fluid"

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.FlowModel;

        //interfaces
        extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

        //new
        // state record for fluid property computations
        Medium.ThermodynamicState state;

        //fluid properties
        parameter Boolean use_nominal=false
          "= true, if eta_nominal and rho_nominal are used, otherwise computed from medium"
          annotation (Evaluate=true, Dialog(group="Fluid properties"));
        parameter SI.DynamicViscosity eta_nominal=Medium.dynamicViscosity(
            Medium.setState_pTX(
            Medium.p_default,
            Medium.T_default,
            Medium.X_default))
          "Nominal dynamic viscosity (e.g. eta_liquidWater = 1e-3, eta_air = 1.8e-5)"
          annotation (Dialog(enable=use_nominal, group="Fluid properties"));
        parameter SI.Density rho_nominal=Medium.density_pTX(
            Medium.p_default,
            Medium.T_default,
            Medium.X_default)
          "Nominal density (e.g. d_liquidWater = 995, d_air = 1.2)"
          annotation (Dialog(enable=use_nominal, group="Fluid properties"));

        SI.Density rho_a=if use_nominal then rho_nominal else Medium.density(state_a);
        SI.Density rho_b=if use_nominal then rho_nominal else Medium.density(state_b);
        SI.Density rho=if use_nominal then rho_nominal else Medium.density(state);

        SI.DynamicViscosity eta_a=if use_nominal then eta_nominal else
            Medium.dynamicViscosity(state_a);
        SI.DynamicViscosity eta_b=if use_nominal then eta_nominal else
            Medium.dynamicViscosity(state_b);
        SI.DynamicViscosity eta=if use_nominal then eta_nominal else
            Medium.dynamicViscosity(state);

        //new
        // Operational conditions
        parameter Boolean from_dp=true
          "= true, use m_flow = f(dp) else dp = f(m_flow)"
          annotation (Evaluate=true, Dialog(tab="Advanced"));
        parameter Medium.AbsolutePressure dp_small=system.dp_small
          "Default small pressure drop for regularization of laminar and zero flow"
          annotation (Dialog(tab="Advanced"));

      equation
        //isenthalpic state transformation (no storage and no loss of energy)
        port_a.h_outflow = inStream(port_b.h_outflow);
        port_b.h_outflow = inStream(port_a.h_outflow);

        //new
        // Fluid properties
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

        annotation (Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics));
      end BaseFlowModel;

      package Bend
        "Application package for pressure loss in a bend with Modelica.Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        partial package BaseBendPL
          "Base package for all pressure loss functions of a bend"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function massFlowRate_dp
          extends Modelica.Icons.Function;

          //mass flow rate as output
          output SI.MassFlowRate M_FLOW;

        end massFlowRate_dp;

          partial model BaseBendModel
            "Base flow model for bend functions in Modelica.Fluid"

            extends BaseClasses.BaseFlowModel(final from_dp=true, final
                allowFlowReversal=
                 true);

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Bend_i;

          end BaseBendModel;
        end BaseBendPL;

        package CurvedBend
          "Fluid.Dissipation: Curved bend considering surface roughness"
        extends BaseBendPL;

        redeclare function extends massFlowRate_dp

          //input records for bend function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall\"> dp_curvedOverall </a> of a curved bend function with surface roughness dependence out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.Bend\"> bend function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a curved bend function at the overall flow regime for an incompressible and single-phase
fluid flow considering surface roughness dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid bend function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.Bend\"> Test: Bend functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model CurvedBendFlowModel
            "Curved bend: Application flow model for bend function in Modelica.Fluid"

            //base flow model
            extends BaseBendPL.BaseBendModel;

            //pressure loss calculation
            parameter Modelica.Fluid.Dissipation.Utilities.Types.Roughness
              roughness=
                Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered
              "Choice of considering surface roughness" annotation (Dialog(group="Bend"));
            parameter Real delta=90 "Angle of turning" annotation (Dialog(group="Bend"));
            parameter SI.Diameter d_hyd=0.1 "Hydraulic diameter"
              annotation (Dialog(group="Bend"));
            parameter SI.Length K=0
              "Roughness (average height of surface asperities)"
              annotation (Dialog(group="Bend"));
            parameter SI.Length L=10*d_hyd "Length of bend along axis"
              annotation (Dialog(group="Bend"));
            parameter SI.Radius R_0=0.5*d_hyd "Curvature radius"
              annotation (Dialog(group="Bend"));

            PressureLossInput_con IN_con(
              roughness=roughness,
              delta=delta,
              d_hyd=d_hyd,
              L=L,
              R_0=R_0,
              K=K) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
            PressureLossInput_var IN_var(final eta=eta, final rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

          end CurvedBendFlowModel;

          record PressureLossInput_con "Input record for dp_curvedOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend\"> curved bend function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var "Input record for dp_curvedOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend\"> curved bend function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end CurvedBend;

        package EdgedBend
          "Fluid.Dissipation: Edged bend considering surface roughness"
        extends BaseBendPL;

        redeclare function extends massFlowRate_dp

          //input records for bend function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall\"> dp_edgedOverall </a> of a edged bend function with surface roughness dependence out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.Bend\"> bend function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a edged bend function at the overall flow regime for an incompressible and single-phase
fluid flow considering surface roughness dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid bend function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.Bend\"> Test: Bend functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model EdgedBendFlowModel
            "Edged bend: Application flow model for bend function in Modelica.Fluid"

            //base flow model
            extends BaseBendPL.BaseBendModel;

            //pressure loss calculation
            Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
              "Choice of considering surface roughness" annotation (Dialog(group="Bend"));
            parameter Real delta=90 "Angle of turning" annotation (Dialog(group="Bend"));
            parameter SI.Diameter d_hyd=0.1 "Hydraulic diameter"
              annotation (Dialog(group="Bend"));
            parameter SI.Length K=0
              "Roughness (average height of surface asperities)"
              annotation (Dialog(group="Bend"));
            parameter SI.Length L=1 "Length of bend along axis"
              annotation (Dialog(group="Bend"));

            PressureLossInput_con IN_con(
              roughness=roughness,
              delta=delta,
              d_hyd=d_hyd,
              K=K,
              L=L) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(final eta=eta, final rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

          end EdgedBendFlowModel;

          record PressureLossInput_con "Input record for dp_edgedOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend\"> edged bend function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var "Input record for dp_edgedOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend\"> edged bend function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end EdgedBend;
      end Bend;

      package Channel
        "Application package for pressure loss in a channel with Modelica.Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        partial package BaseChannelPL
          "Base package for all pressure loss functions of a channel"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function massFlowRate_dp
          extends Modelica.Icons.Function;

          //mass flow rate as output
          output SI.MassFlowRate M_FLOW;

        end massFlowRate_dp;

          partial model BaseChannelModel
            "Base flow model for channel functions in Modelica.Fluid"

            extends BaseClasses.BaseFlowModel(final from_dp=true, final
                allowFlowReversal=
                 true);

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Channel_i;

          end BaseChannelModel;
        end BaseChannelPL;

        package Overall "Fluid.Dissipation: Overall regime of channel"
        extends BaseChannelPL;

        redeclare function extends massFlowRate_dp

          //input records for channel function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\"> dp_internalFlowOverall </a> of a channel out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.Channel\"> channel </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a channel function at the overall flow regime for an incompressible and single-phase
fluid flow. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid channel function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.Channel\"> Test: channel functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model OverallFlowModel
            "Channel (overall): Application flow model for channel function in Modelica.Fluid"

            //base flow model
            extends BaseChannelPL.BaseChannelModel;

            //pressure loss calculation
            Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
              "Choice of considering surface roughness"
              annotation (Dialog(group="Channel"));
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow
              geometry=
                Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Circular
              "Choice of geometry for internal flow" annotation (Dialog(group="Channel"));
            parameter SI.Length K=0
              "Roughness (average height of surface asperities)"
              annotation (Dialog(group="Channel"));
            parameter SI.Length L=1 "Length" annotation (Dialog(group="Channel"));
            parameter SI.Diameter d_ann=d_cir "Small diameter"
              annotation (Dialog(group="Channel"));
            parameter SI.Diameter D_ann=2*d_ann "Large diameter"
              annotation (Dialog(group="Channel"));
            parameter SI.Diameter d_cir=0.1 "Internal diameter"
              annotation (Dialog(group="Channel"));
            parameter SI.Length a_ell=(3/4)*d_cir
              "Half length of long base line"
              annotation (Dialog(group="Channel"));
            parameter SI.Length b_ell=0.5*a_ell
              "Half length of short base line"
              annotation (Dialog(group="Channel"));
            parameter SI.Length a_rec=d_cir "Horizontal length"
              annotation (Dialog(group="Channel"));
            parameter SI.Length b_rec=a_rec "Vertical length"
              annotation (Dialog(group="Channel"));
            parameter SI.Length a_tri=d_cir*(1 + 2^0.5) "Length of base line"
              annotation (Dialog(group="Channel"));
            parameter SI.Length h_tri=0.5*a_tri
              "Heigth to top angle perpendicular to base line"
              annotation (Dialog(group="Channel"));
            parameter Real beta=90 "Top angle" annotation (Dialog(group="Channel"));

            PressureLossInput_con IN_con(
              roughness=roughness,
              geometry=geometry,
              K=K,
              L=L,
              d_ann=d_ann,
              D_ann=D_ann,
              d_cir=d_cir,
              a_ell=a_ell,
              b_ell=b_ell,
              a_rec=a_rec,
              b_rec=b_rec,
              a_tri=a_tri,
              h_tri=h_tri,
              beta=beta)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(eta=eta, rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

            annotation (Diagram(graphics));
          end OverallFlowModel;

          record PressureLossInput_con
            "Input record for dp_severalGeometryOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel\"> channel function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var
            "Input record for dp_severalGeometryOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel\"> channel function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end Overall;
      end Channel;

      package General
        "Application package for a generic pressure loss with Modelica.Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package BaseGeneralPL
          "Base package for all generic pressure loss functions"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function massFlowRate_dp
          extends Modelica.Icons.Function;

          //mass flow rate as output
          output SI.MassFlowRate M_FLOW;

        end massFlowRate_dp;

          partial model BaseGeneralModel
            "Base flow model for generic functions in Modelica.Fluid"

            extends BaseClasses.BaseFlowModel(final from_dp=true, final
                allowFlowReversal=
                 true);

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.General_i;

          end BaseGeneralModel;
        end BaseGeneralPL;

        package IdealGas
          "Fluid.Dissipation: Generic pressure loss law with ideal gas dependence"
        extends BaseGeneralPL;

        redeclare function extends massFlowRate_dp

          //input record for generic function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW := Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas\">
dp_idealGas </a> of a generic function with volume flow rate dependence out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.General\"> generic function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a generic function at the overall flow regime for an incompressible and single-phase
fluid flow considering volume flow rate dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid generic function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.General\"> Test: Generic functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model IdealGasFlowModel
            "IdealGas: Application flow model for generic function in Modelica.Fluid"

            //base flow model
            extends BaseGeneralPL.BaseGeneralModel;

            //pressure loss calculation
            parameter Real exp=2 "Exponent of pressure loss law"
              annotation (Dialog(group="Generic variables"));
            parameter Real Km=R_s*(2e3)/((10)^exp/rho_m)
              "Coefficient for pressure loss law [(Pa)^2/{(kg/s)^exp*K}]"
              annotation (Dialog(group="Generic variables"));
            parameter SI.SpecificHeatCapacity R_s=287
              "Specific gas constant of ideal gas"
              annotation (Dialog(group="Generic variables"));
            parameter SI.Density rho_m=p_m/(R_s*T_m)
              "Mean density of ideal gas"
              annotation (Dialog(group="Generic variables"));
            parameter SI.Temp_K T_m=(293 + 293)/2
              "Mean temperature of ideal gas"
              annotation (Dialog(group="Generic variables"));
            parameter SI.Pressure p_m=(1e5 + 1e5)/2
              "Mean pressure of ideal gas"
              annotation (Dialog(group="Generic variables"));

            //linearisation
            parameter SI.Pressure dp_smooth=1e-3
              "Start linearisation for decreasing pressure loss"
              annotation (Dialog(group="Linearisation"));

            PressureLossInput_con IN_con(
              exp=exp,
              R_s=R_s,
              Km=Km,
              dp_smooth=dp_smooth)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(
              rho_m=rho_m,
              T_m=T_m,
              p_m=p_m) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

          end IdealGasFlowModel;

          record PressureLossInput_con "Input record for dp_idealGas"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic ideal gas function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var "Input record for dp_idealGas"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic ideal gas function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end IdealGas;

        package NominalDensityViscosity
          "Fluid.Dissipation: Generic pressure loss law with density and viscosity dependence"
        extends BaseGeneralPL;

        redeclare function extends massFlowRate_dp

          //input record for generic function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity\">
dp_nominalDensityViscosity </a> of a generic function with volume flow rate dependence out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.General\"> generic function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a generic function at the overall flow regime for an incompressible and single-phase
fluid flow considering volume flow rate dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid generic function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.General\"> Test: Generic functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model NominalDensityViscosityFlowModel
            "NominalDensityViscosity: Application flow model for generic function in Modelica.Fluid"

            //base flow model
            extends BaseGeneralPL.BaseGeneralModel;

            //pressure loss calculation
            parameter SI.Pressure dp_nom=2
              "Nominal pressure loss (at nominal values of mass flow rate and density)"
              annotation (Dialog(group="Generic variables"));
            parameter Real exp=2 "Exponent of pressure loss law"
              annotation (Dialog(group="Generic variables"));
            parameter SI.MassFlowRate m_flow_nom=1
              "Nominal mass flow rate (at nominal values of pressure loss and density)"
              annotation (Dialog(group="Generic variables"));
            parameter SI.Density rho_nom=1e3
              "Nominal density (at nominal values of mass flow rate and pressure loss)"
              annotation (Dialog(group="Generic variables"));
            parameter Real exp_eta=1
              "Exponent for dynamic viscosity dependence"
              annotation (Dialog(group="Generic variables"));
            parameter SI.DynamicViscosity eta_nom=1e-3
              "Dynamic viscosity at nominal pressure loss"
              annotation (Dialog(group="Generic variables"));

            PressureLossInput_con IN_con(
              dp_nom=dp_nom,
              exp=exp,
              m_flow_nom=m_flow_nom,
              rho_nom=rho_nom,
              exp_eta=exp_eta,
              eta_nom=eta_nom)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(eta=eta, rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

          end NominalDensityViscosityFlowModel;

          record PressureLossInput_con
            "Input record for dp_nominalDensityViscosity"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic ideal gas function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var
            "Input record for dp_nominalDensityViscosity"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic ideal gas function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end NominalDensityViscosity;

        package NominalPressureLossLawDensity
          "Fluid.Dissipation: Generic pressure loss law with density dependence"
        extends BaseGeneralPL;

        redeclare function extends massFlowRate_dp

          //input records for generic density function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\">
dp_nominalPressureLossLawDensity_MFLOW </a> of a generic function with density dependence out of the <b> Fluid.Dissipation </b>
library is implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.General\"> generic function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a generic function at the overall flow regime for an incompressible and single-phase
fluid flow considering density dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known pressure loss
(dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid generic function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.General\"> Test: Generic functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model NominalPressureLossLawDensityFlowModel
            "NominalPressureLossLawDensity: Application flow model for generic function in Modelica.Fluid"

            //base flow model
            extends BaseGeneralPL.BaseGeneralModel;

            //pressure loss calculation
            Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate
              target=
                Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate
              "1 == use nominal mass flow rate | 2 == use nominal volume flow rate"
              annotation (Dialog(group="Generic variables"));

            parameter SI.Area A_cross=A_cross_nom "Cross sectional area"
              annotation (Dialog(group="Generic variables"));
            parameter SI.Area A_cross_nom=Modelica.Constants.pi*0.1^2/4
              "Nominal cross sectional area"
              annotation (Dialog(group="Generic variables"));
            parameter SI.Pressure dp_nom=2
              "Nominal pressure loss (at nominal values of mass flow rate and density)"
              annotation (Dialog(group="Generic variables"));
            parameter SI.MassFlowRate m_flow_nom=1
              "Nominal mass flow rate (at nominal values of pressure loss and density)"
              annotation (Dialog(group="Generic variables"));
            parameter Real exp=2 "Exponent of pressure loss law"
              annotation (Dialog(group="Generic variables"));
            parameter SI.VolumeFlowRate V_flow_nom=m_flow_nom/rho_nom
              "Nominal volume flow rate (at nominal values of pressure loss and density)"
              annotation (Dialog(group="Generic variables",enable=not (
                    NominalMassFlowRate)));
            parameter SI.Density rho_nom=1e3
              "Nominal density (at nominal values of mass flow rate and pressure loss)"
              annotation (Dialog(group="Generic variables"));
            parameter
              Modelica.Fluid.Dissipation.Utilities.Types.PressureLossCoefficient
              zeta_TOT=zeta_TOT_nom "Pressure loss coefficient"
              annotation (Dialog(group="Generic variables"));
            parameter
              Modelica.Fluid.Dissipation.Utilities.Types.PressureLossCoefficient
              zeta_TOT_nom=0.02*1/0.1
              "Nominal pressure loss coefficient (for nominal values)"
              annotation (Dialog(group="Generic variables"));

            PressureLossInput_con IN_con(
              final exp=exp,
              final m_flow_nom=m_flow_nom,
              final target=target,
              final A_cross=A_cross,
              final A_cross_nom=A_cross_nom,
              final dp_nom=dp_nom,
              final V_flow_nom=V_flow_nom,
              final rho_nom=rho_nom,
              final zeta_TOT_nom=zeta_TOT_nom)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(final zeta_TOT=zeta_TOT, final rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

          end NominalPressureLossLawDensityFlowModel;

          record PressureLossInput_con
            "Input record for dp_nominalPressureLossLawDensity"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic density function </a> implemented in Modelica.Fluid as
thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var
            "Input record for dp_nominalPressureLossLawDensity"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic density function </a> implemented in Modelica.Fluid as
thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end NominalPressureLossLawDensity;

        package PressureLossCoefficient
          "Fluid.Dissipation: Generic function with pressure loss coefficient dependence"
        extends BaseGeneralPL;

        redeclare function extends massFlowRate_dp

          //input records for generic pressure loss coefficient (zeta_TOT) function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_genericPressureLossCoefficient_MFLOW\">
dp_genericPressureLossCoefficient_MFLOW </a> of a generic function with pressure loss coefficient dependence out of the <b>
Fluid.Dissipation </b> library is implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.General\"> generic function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a generic function at the overall flow regime for an incompressible and single-phase
fluid flow considering pressure loss coefficient (zeta) dependency. Here the mass flow rate (M_FLOW) is calculated in dependence
of a known pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid generic function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.General\"> Test: Generic functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model PressureLossCoefficientFlowModel
            "PressureLossCoefficient: Application flow model for generic function in Modelica.Fluid"

            //base flow model
            extends BaseGeneralPL.BaseGeneralModel;

            //pressure loss calculation
            parameter SI.Area A_cross=Modelica.Constants.pi*0.1^2/4
              "cross sectional area" annotation (Dialog(group="Generic variables"));
            parameter
              Modelica.Fluid.Dissipation.Utilities.Types.PressureLossCoefficient
              zeta_TOT=0.5 "pressure loss coefficient"
              annotation (Dialog(group="Generic variables"));

            //linearisation
            parameter SI.Pressure dp_smooth=1e-3
              "Start linearisation for decreasing pressure loss"
              annotation (Dialog(group="Linearisation"));

            PressureLossInput_con IN_con(final A_cross=A_cross, final dp_smooth
                =dp_smooth)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(final zeta_TOT=zeta_TOT, final rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

          end PressureLossCoefficientFlowModel;

          record PressureLossInput_con
            "Input record for generic function with pressure loss coefficient dependence"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic pressure loss coefficient function </a> implemented in
Modelica.Fluid as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var
            "Input record for generic function with pressure loss coefficient dependence"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic pressure loss coefficient function </a> implemented in
Modelica.Fluid as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end PressureLossCoefficient;

        package VolumeFlowRate
          "Fluid.Dissipation: Generic pressure loss law with volume flow rate dependence"
        extends BaseGeneralPL;

        redeclare function extends massFlowRate_dp

          //input record for generic function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate\">
dp_volumeFlowRate </a> of a generic function with volume flow rate dependence out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.General\"> generic function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a generic function at the overall flow regime for an incompressible and single-phase
fluid flow considering volume flow rate dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid generic function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.general\"> Test: Generic functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          record PressureLossInput_con "Input record for dp_volumeFlowRate"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic volume flow rate function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var "Input record for dp_volumeFlowRate"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.General\"> generic volume flow rate function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;

          model VolumeFlowRateFlowModel
            "VolumeFlowRate: Application flow model for generic function in Modelica.Fluid"

            //base flow model
            extends BaseGeneralPL.BaseGeneralModel;

            //pressure loss calculation
            parameter Real a=15 "Coefficient for quadratic term"
              annotation (Dialog(group="Generic variables"));
            parameter Real b=0 "Coefficient for linear term"
              annotation (Dialog(group="Generic variables"));

            PressureLossInput_con IN_con(
              a=a,
              b=b,
              dp_min=dp_small)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

          end VolumeFlowRateFlowModel;
        end VolumeFlowRate;
      end General;

      package Orifice
        "Application package for pressure loss in an orifice with Modelica.Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package BaseOrificePL
          "Base package for all pressure loss functions of an orifice"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function massFlowRate_dp
          extends Modelica.Icons.Function;

          //mass flow rate as output
          output SI.MassFlowRate M_FLOW;

        end massFlowRate_dp;

          partial model BaseOrificeModel
            "Base flow model for orifice functions in Modelica.Fluid"

            extends BaseClasses.BaseFlowModel(final from_dp=true, final
                allowFlowReversal=
                 true);

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Orifice_i;

          end BaseOrificeModel;
        end BaseOrificePL;

        package ThickEdgedOverall
          "Fluid.Dissipation: Overall flow regime in an thicked edged orifice"
        extends BaseOrificePL;

        redeclare function extends massFlowRate_dp

          //input records for orifice function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall\"> dp_thickEdgedOverall </a> of a orifice function with surface roughness dependence
out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.Orifice\"> orifice function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a orifice function at the overall flow regime for an incompressible and single-phase
fluid flow considering surface roughness dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid orifice function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.Orifice\"> Test: Orifice functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          record PressureLossInput_con "Input record for dp_thickEdgedOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice\"> orifice function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var "Input record for dp_thickEdgedOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice\"> orifice function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;

          model ThickEdgedOverallFlowModel
            "Orifice (thick edged): Application flow model for orifice function in Modelica.Fluid"

            //base flow model
            extends BaseOrificePL.BaseOrificeModel;

            //pressure loss parameter
            SI.Area A_0=0.1*A_1 "Cross sectional area of vena contraction"
              annotation (Dialog(group="Orifice"));
            parameter SI.Area A_1=Constants.pi
                                    *0.01^2/4
              "Small cross sectional area of orifice"
              annotation (Dialog(group="Orifice"));
            parameter SI.Length C_0=0.1*C_1 "Perimeter of vena contraction"
              annotation (Dialog(group="Orifice"));
            parameter SI.Length C_1=Constants.pi
                                      *0.01 "Small perimeter of orifice"
              annotation (Dialog(group="Orifice"));
            parameter SI.Length L=1e-3 "Length of vena contraction"
              annotation (Dialog(group="Orifice"));

            PressureLossInput_con IN_con(
              A_0=A_0,
              A_1=A_1,
              C_0=C_0,
              C_1=C_1,
              L=L) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
            PressureLossInput_var IN_var(eta=eta, rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);
          end ThickEdgedOverallFlowModel;
        end ThickEdgedOverall;

        package SuddenChange
          "Fluid.Dissipation: Turbulent flow regime in a sharp edged orifice with sudden change in cross sectional area"
        extends BaseOrificePL;

        redeclare function extends massFlowRate_dp

          //input record for orifice function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChangeSectionBidirectionalTurbulentSmooth\"> dp_suddenChangeSectionBidirectionalTurbulentSmooth </a> of an sharp edged orifice with a sudden change in its cross sectional area neglecting surface roughness out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.Orifice\"> orifice function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a orifice function at the overall flow regime for an incompressible and single-phase
fluid flow neglecting surface roughness. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid orifice function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.Orifice\"> Test: Orifice functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          record PressureLossInput_con
            "Input record for dp_suddenChangeSectionBidirectionalTurbulentSmooth"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice\"> orifice function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var
            "Input record for dp_suddenChangeSectionBidirectionalTurbulentSmooth"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice\"> orifice function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;

          model SuddenChangeFlowModel
            "Orifice (sudden section change): Application flow model for orifice function in Modelica.Fluid"

            //base flow model
            extends BaseOrificePL.BaseOrificeModel;

            //pressure loss parameter
            parameter SI.Area A_1=Constants.pi
                                    *0.01^2/4
              "Small cross sectional area of orifice";
            parameter SI.Area A_2=A_1 "Large cross sectional area of orifice";
            parameter SI.Length C_1=Constants.pi
                                      *0.01 "Small perimeter of orifice";
            parameter SI.Length C_2=C_1 "Large perimeter of orifice";

            PressureLossInput_con IN_con(
              A_1=A_1,
              A_2=A_2,
              C_1=C_1,
              C_2=C_2) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(eta=eta, rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);
          end SuddenChangeFlowModel;
        end SuddenChange;
      end Orifice;

      package StraightPipe
        "Application package for pressure loss in a straight pipe with Modelica.Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        partial package BaseStraightPipePL
          "Base package for all pressure loss functions of a straight pipe"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function massFlowRate_dp
          extends Modelica.Icons.Function;

          //mass flow rate as output
          output SI.MassFlowRate M_FLOW;

        end massFlowRate_dp;

          partial model BaseStraightPipeModel
            "Base flow model for straight pipe functions in Modelica.Fluid"

            extends BaseClasses.BaseFlowModel(final from_dp=true, final
                allowFlowReversal=
                 true);

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_i;

          end BaseStraightPipeModel;
        end BaseStraightPipePL;

        package Laminar "Fluid.Dissipation: Laminar regime of straight pipe"
        extends BaseStraightPipePL;

        redeclare function extends massFlowRate_dp

          //input records for straight pipe function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar\"> dp_laminar </a> of a straight pipe function with surface roughness dependence out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.StraightPipe\"> straight pipe function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a straight pipe function at the overall flow regime for an incompressible and single-phase
fluid flow considering surface roughness dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid straight pipe function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.StraightPipe\"> Test: Straight pipe functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model LaminarFlowModel
            "Straight pipe (laminar): Application flow model for straight pipe function in Modelica.Fluid"

            //base flow model
            extends BaseStraightPipePL.BaseStraightPipeModel;

            //pressure loss calculation
            parameter SI.Diameter d_hyd=0.1 "Hydraulic diameter"
              annotation (Dialog(group="Straight pipe"));
            parameter SI.Length L=1 "Length" annotation (Dialog(group="Straight pipe"));

            PressureLossInput_con IN_con(d_hyd=d_hyd, L=L)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(eta=eta, rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

            annotation (Diagram(graphics));
          end LaminarFlowModel;

          record PressureLossInput_con "Input record for dp_laminar"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe\"> straight pipe function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var "Input record for dp_laminar"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe\"> straight pipe function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end Laminar;

        package Overall "Fluid.Dissipation: Overall regime of straight pipe"
        extends BaseStraightPipePL;

        redeclare function extends massFlowRate_dp

          //input records for straight pipe function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall\"> dp_overall </a> of a straight pipe function with surface roughness dependence out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.StraightPipe\"> straight pipe function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a straight pipe function at the overall flow regime for an incompressible and single-phase
fluid flow considering surface roughness dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid straight pipe function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.StraightPipe\"> Test: Straight pipe functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          model OverallFlowModel
            "Straight pipe (overall): Application flow model for straight pipe function in Modelica.Fluid"

            //base flow model
            extends BaseStraightPipePL.BaseStraightPipeModel;

            //pressure loss calculation
            Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
              "Choice of considering surface roughness"
              annotation (Dialog(group="Straight pipe"));
            parameter SI.Diameter d_hyd=0.1 "Hydraulic diameter"
              annotation (Dialog(group="Straight pipe"));
            parameter SI.Length L=1 "Length" annotation (Dialog(group="Straight pipe"));
            parameter SI.Length K=0
              "Roughness (average height of surface asperities)"
              annotation (Dialog(group="Straight pipe"));

            PressureLossInput_con IN_con(
              d_hyd=d_hyd,
              L=L,
              roughness=roughness,
              K=K) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(eta=eta, rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

            annotation (Diagram(graphics));
          end OverallFlowModel;

          record PressureLossInput_con "Input record for dp_overall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe\"> straight pipe function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var "Input record for dp_overall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe\"> straight pipe function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end Overall;

        package Turbulent
          "Fluid.Dissipation: Turbulent regime of straight pipe"
        extends BaseStraightPipePL;

        redeclare function extends massFlowRate_dp

          //input records for straight pipe function
          input PressureLossInput_con IN_con
                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          input PressureLossInput_var IN_var
                   annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

        algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                          IN_con,
                          IN_var,
                          dp);

          annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent\"> dp_turbulent </a> of a straight pipe function with surface roughness dependence out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.StraightPipe\"> straight pipe function </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a straight pipe function at the turbulent flow regime for an incompressible and single-phase
fluid flow considering surface roughness dependence. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid straight pipe function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.StraightPipe\"> Test: Straight pipe functions </a>.
</p>

</html>
"));
        end massFlowRate_dp;

          record PressureLossInput_con "Input record for dp_turbulent"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe\"> straight pipe function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var "Input record for dp_turbulent"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe\"> straight pipe function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;

          model TurbulentFlowModel
            "Straight pipe (turbulent): Application flow model for straight pipe function in Modelica.Fluid"

            //base flow model
            extends BaseStraightPipePL.BaseStraightPipeModel;

            //pressure loss calculation
            Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
              "Choice of considering surface roughness"
              annotation (Dialog(group="Straight pipe"));
            parameter SI.Diameter d_hyd=0.1 "Hydraulic diameter"
              annotation (Dialog(group="Straight pipe"));
            parameter SI.Length L=1 "Length" annotation (Dialog(group="Straight pipe"));
            parameter SI.Length K=0
              "Roughness (average height of surface asperities)"
              annotation (Dialog(group="Straight pipe"));

            PressureLossInput_con IN_con(
              d_hyd=d_hyd,
              L=L,
              roughness=roughness,
              K=K) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(eta=eta, rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

            annotation (Diagram(graphics));
          end TurbulentFlowModel;
        end Turbulent;
      end StraightPipe;

      package Valve
        "Application package for pressure loss in a valves with Modelica.Fluid as thermo-hydraulic framework"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        package Overall "Fluid.Dissipation: Overall regime of valve"
          extends BaseValvePL;

          redeclare function extends massFlowRate_dp

            //input records for valve function
            input PressureLossInput_con IN_con
                     annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
            input PressureLossInput_var IN_var
                     annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
            input SI.Pressure dp "Pressure loss" annotation (Dialog(tab="Input"));

          algorithm
            M_FLOW :=
              Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW(
                            IN_con,
                            IN_var,
                            dp);

            annotation (Documentation(info="<html>
<p>
In this package the pressure loss function <a href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\"> dp_severalGeometryOverall </a> of a valve out of the <b> Fluid.Dissipation </b> library is
implemented into an usable form for the replaceable pressure loss calculations of a <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.Applications.PressureLoss.Valve\"> valve </a> with the <b>Modelica.Fluid </b>
library as thermo-hydraulic framework.
</p>

<p>
This function executes the calculation of a valve function at the overall flow regime for an incompressible and single-phase
fluid flow. Here the mass flow rate (M_FLOW) is calculated in dependence of a known
pressure loss (dp).
</p>

<p>
A test case ready for the simulation of a Modelica.Fluid valve function can be found in <a
href=\"Modelica://Modelica.Fluid.Dissipation.Examples.TestCases.PressureLoss.Valve\"> Test: Valve functions </a>.
</p>

</html>
"));
          end massFlowRate_dp;

          model OverallFlowModel
            "Valve (overall): Application flow model for valve function in Modelica.Fluid"

            //base flow model
            extends BaseValvePL.BaseValveModel;

            //pressure loss calculation
            Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry geometry=Dissipation.Utilities.Types.ValveGeometry.Ball
              "Choice of geometry for valve" annotation (Dialog(group="Valve"));
            Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient
              valveCoefficient=
                Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient.AV
              "Choice of valve coefficient" annotation (Dialog(group="Valve"));

            parameter Real opening=1
              "Opening of valve | 0==closed and 1== fully openend"
              annotation (Dialog(group="Valve"));
            parameter Real Av=Constants.pi
                                *0.1^2/4
              "Av (metric) flow coefficient [Av]=m^2"
              annotation (Dialog(group="Valve"));
            parameter Real Kv=Av/27.7e-6
              "Kv (metric) flow coefficient [Kv]=m^3/h"
              annotation (Dialog(group="Valve"));
            parameter Real Cv=Av/24.6e-6
              "Cv (US) flow coefficient [Cv]=USG/min"
              annotation (Dialog(group="Valve"));
            parameter SI.Pressure dp_nominal=1e3 "Nominal pressure loss"
              annotation (Dialog(group="Valve"));
            parameter SI.MassFlowRate m_flow_nominal=opening_nominal*Av*(rho_nominal*
                dp_nominal)^0.5 "Nominal mass flow rate"
              annotation (Dialog(group="Valve"));
            parameter Real opening_nominal=0.5 "Nominal opening"
              annotation (Dialog(group="Valve"));
            parameter Real zeta_TOT_min=1e-3
              "Minimal pressure loss coefficient at full opening"
              annotation (Dialog(group="Valve"));
            parameter Real zeta_TOT_max=1e8
              "Maximum pressure loss coefficient at closed opening"
              annotation (Dialog(group="Valve"));

            PressureLossInput_con IN_con(
              geometry=geometry,
              valveCoefficient=valveCoefficient,
              Av=Av,
              Kv=Kv,
              Cv=Cv,
              dp_nominal=dp_nominal,
              m_flow_nominal=m_flow_nominal,
              rho_nominal=rho_nominal,
              opening_nominal=opening_nominal,
              zeta_TOT_min=zeta_TOT_min,
              zeta_TOT_max=zeta_TOT_max,
              dp_small=dp_small)
              annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

            PressureLossInput_var IN_var(opening=opening, rho=rho)
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

          equation
            m_flow = massFlowRate_dp(
                        IN_con,
                        IN_var,
                        dp);

            annotation (Diagram(graphics));
          end OverallFlowModel;

          record PressureLossInput_con
            "Input record for dp_severalGeometryOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve\"> valve function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_con;

          record PressureLossInput_var
            "Input record for dp_severalGeometryOverall"

            extends
              Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var;

            annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss of the <a
href=\"Modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve\"> valve function </a> implemented in Modelica.Fluid
as thermo-hydraulic framework.
</html>"));

          end PressureLossInput_var;
        end Overall;

        partial package BaseValvePL
          "Base package for all pressure loss functions of a valve"
        extends Modelica.Fluid.Dissipation.Utilities.Icons.BaseLibrary;

        replaceable partial function massFlowRate_dp
          extends Modelica.Icons.Function;

          //mass flow rate as output
          output SI.MassFlowRate M_FLOW;

        end massFlowRate_dp;

          partial model BaseValveModel
            "Base flow model for valve functions in Modelica.Fluid"

            extends BaseClasses.BaseFlowModel(final from_dp=true, final
                allowFlowReversal=
                 true);

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Valve_i;

          end BaseValveModel;
        end BaseValvePL;
      end Valve;
    end BaseClasses;
  end PressureLoss;
     extends Modelica.Fluid.Icons.VariantLibrary;

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
  extends BaseClasses.QuadraticTurbulent.BaseModelNonconstantCrossSectionArea(final data
        = BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(
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
    parameter Integer nPorts_b=1
      "Number of outlet ports (mass is distributed evenly between the outlet ports"
      annotation(Dialog(__Dymola_connectorSizing=true));

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
    extends Modelica.Fluid.Icons.BaseClassLibrary;

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
  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"),    Documentation(info="<html>
<p>
This sublibrary contains models and functions providing pressure
loss correlations. All models in this library have the property
that no mass and no energy is stored in the component. Therefore,
none of the models has a state. The basic correlations are implemented
with functions of sublibrary
<a href=\"Modelica://Modelica.Fluid.PressureLosses.Utilities\">PressureLosses.Utilities</a>
These functions might also be directly called
(e.g. in another component implementation).
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
