within ModelicaTest;
package Media
  extends Modelica.Icons.ExamplesPackage;
  package TestAllProperties
    extends Modelica.Icons.ExamplesPackage;
    model PartialMediumFunctions
      import SI = Modelica.SIunits;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium model";
      parameter Real eps_h_is=1e-10;
      Medium.ThermodynamicState state=Medium.setState_pTX(
              Medium.reference_p,
              Medium.reference_T,
              Medium.reference_X);
      Medium.DynamicViscosity eta=Medium.dynamicViscosity(state);
      Medium.ThermalConductivity lambda=Medium.thermalConductivity(state);
      Medium.PrandtlNumber Pr=Medium.prandtlNumber(state);
      Medium.AbsolutePressure p=Medium.pressure(state);
      Medium.Temperature T=Medium.temperature(state);
      Medium.Density d=Medium.density(state);
      Medium.SpecificEnthalpy h=Medium.specificEnthalpy(state);
      Medium.SpecificEnergy u=Medium.specificInternalEnergy(state);
      Medium.SpecificEntropy s=Medium.specificEntropy(state);
      Medium.SpecificEnergy g=Medium.specificGibbsEnergy(state);
      Medium.SpecificEnergy f=Medium.specificHelmholtzEnergy(state);
      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
      Medium.SpecificHeatCapacity cp2=Medium.heatCapacity_cp(state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
      Medium.SpecificHeatCapacity cv2=Medium.heatCapacity_cv(state);
      Medium.SpecificEnthalpy h_is=Medium.isentropicEnthalpy(2*Medium.reference_p,
          state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(state);
      Medium.IsobaricExpansionCoefficient beta=
          Medium.isobaricExpansionCoefficient(state);
      Medium.IsobaricExpansionCoefficient beta2=Medium.beta(state);
      SI.IsothermalCompressibility kappa=Medium.isothermalCompressibility(state);
      SI.IsothermalCompressibility kappa2=Medium.kappa(state);
      Medium.DerDensityByPressure ddpT=Medium.density_derp_T(state);
      Medium.DerDensityByTemperature ddTp=Medium.density_derT_p(state);
      Medium.Density dddX[Medium.nX]=Medium.density_derX(state);
      Medium.MolarMass MM=Medium.molarMass(state);
      Medium.SpecificEnthalpy h2=Medium.specificEnthalpy_pTX(
              Medium.reference_p,
              Medium.reference_T,
              Medium.reference_X);
      Medium.Density d2=Medium.density_pTX(
              Medium.reference_p,
              Medium.reference_T,
              Medium.reference_X);
      Medium.ThermodynamicState state2=Medium.setState_phX(
              Medium.reference_p,
              h,
              Medium.reference_X);
      Medium.ThermodynamicState state3=Medium.setState_psX(
              Medium.reference_p,
              s,
              Medium.reference_X);
      Medium.ThermodynamicState state4=if Medium.singleState then state else
          Medium.setState_dTX(
              d,
              T,
              Medium.reference_X);
      Medium.ThermodynamicState state5=Medium.setSmoothState(
              0.1,
              state,
              state2,
              0.001);
      Medium.BaseProperties medium(
        preferredMediumStates=true,
        p(start=Medium.reference_p),
        T(start=Medium.reference_T),
        X(start=Medium.reference_X));
      Real err_T=abs(medium.T - T);
      Real err_d=abs(medium.d - d);
      Real err_u=abs(medium.u - u);

      // check isentropicEnthalpy
      Medium.ThermodynamicState state_h_is=Medium.setState_phX(
              2*Medium.reference_p,
              h_is,
              Medium.reference_X);
      Medium.SpecificEntropy s_is=Medium.specificEntropy(state_h_is);
      Real err_h_is=abs(s - s_is);
      constant Real eps=1e-10;
    equation
      medium.p = p;
      medium.h = h;
      medium.Xi = Medium.reference_X[1:Medium.nXi];

      // When iterating at the initial time the asserts below could be violated.
      // To avoid an error, the check is only performed at the end of the simulation.
      when terminal() then
        assert(err_T <= eps, "Error: abs(medium.T - T) > eps\n" + "(err_T = "
           + String(err_T) + ", eps = " + String(eps) + ")");
      end when;

      when terminal() then
        assert(err_d <= eps, "Error: abs(medium.d - d) > eps" + "(err_d = " +
          String(err_d) + ", eps = " + String(eps) + ")");
      end when;

      when terminal() then
        assert(err_u <= eps, "Error: abs(medium.u - u) > eps" + "(err_u = " +
          String(err_u) + ", eps = " + String(eps) + ")");
      end when;

      // when terminal() then
      assert(err_h_is <= eps_h_is,
        "Error: entropy not constant for isentropicEnthalpy" + "(err_h_is = "
         + String(err_h_is) + ", eps = " + String(eps_h_is) + ")");
      // end when;
    end PartialMediumFunctions;

    model DryAirNasa
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Air.DryAirNasa, eps_h_is=0.1);
      annotation (experiment(StopTime=0.1));
    end DryAirNasa;

    model LinearColdWater
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.CompressibleLiquids.LinearColdWater);
      annotation (experiment(StopTime=0.1));
    end LinearColdWater;

    model LinearWater_pT_Ambient
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient);
      annotation (experiment(StopTime=0.1));
    end LinearWater_pT_Ambient;

    model CO2
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.IdealGases.SingleGases.CO2, eps_h_is=0.2);
      annotation (experiment(StopTime=0.1));
    end CO2;

    model FlueGasSixComponents
      "A copy of PartialMediumFunctions, but isentropicEnthalpy gets the additional argument exact=true"
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;
      package Medium =
          Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents
        "Medium model";
      parameter Real eps_h_is=1e-10;
      Medium.ThermodynamicState state=Medium.setState_pTX(
              Medium.reference_p,
              Medium.reference_T,
              Medium.reference_X);
      Medium.DynamicViscosity eta=Medium.dynamicViscosity(state);
      Medium.ThermalConductivity lambda=Medium.thermalConductivity(state);
      Medium.PrandtlNumber Pr=Medium.prandtlNumber(state);
      Medium.AbsolutePressure p=Medium.pressure(state);
      Medium.Temperature T=Medium.temperature(state);
      Medium.Density d=Medium.density(state);
      Medium.SpecificEnthalpy h=Medium.specificEnthalpy(state);
      Medium.SpecificEnergy u=Medium.specificInternalEnergy(state);
      Medium.SpecificEntropy s=Medium.specificEntropy(state);
      Medium.SpecificEnergy g=Medium.specificGibbsEnergy(state);
      Medium.SpecificEnergy f=Medium.specificHelmholtzEnergy(state);
      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
      Medium.SpecificHeatCapacity cp2=Medium.heatCapacity_cp(state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
      Medium.SpecificHeatCapacity cv2=Medium.heatCapacity_cv(state);
      Medium.SpecificEnthalpy h_is=Medium.isentropicEnthalpy(
              2*Medium.reference_p,
              state,
              exact=true);
      Medium.VelocityOfSound a=Medium.velocityOfSound(state);
      Medium.IsobaricExpansionCoefficient beta=
          Medium.isobaricExpansionCoefficient(state);
      Medium.IsobaricExpansionCoefficient beta2=Medium.beta(state);
      SI.IsothermalCompressibility kappa=Medium.isothermalCompressibility(state);
      SI.IsothermalCompressibility kappa2=Medium.kappa(state);
      Medium.DerDensityByPressure ddpT=Medium.density_derp_T(state);
      Medium.DerDensityByTemperature ddTp=Medium.density_derT_p(state);
      Medium.Density dddX[Medium.nX]=Medium.density_derX(state);
      Medium.MolarMass MM=Medium.molarMass(state);
      Medium.SpecificEnthalpy h2=Medium.specificEnthalpy_pTX(
              Medium.reference_p,
              Medium.reference_T,
              Medium.reference_X);
      Medium.Density d2=Medium.density_pTX(
              Medium.reference_p,
              Medium.reference_T,
              Medium.reference_X);
      Medium.ThermodynamicState state2=Medium.setState_phX(
              Medium.reference_p,
              h,
              Medium.reference_X);
      Medium.ThermodynamicState state3=Medium.setState_psX(
              Medium.reference_p,
              s,
              Medium.reference_X);
      Medium.ThermodynamicState state4=if Medium.singleState then state else
          Medium.setState_dTX(
              d,
              T,
              Medium.reference_X);
      Medium.ThermodynamicState state5=Medium.setSmoothState(
              0.1,
              state,
              state2,
              0.001);
      Medium.BaseProperties medium(
        preferredMediumStates=true,
        p(start=Medium.reference_p),
        T(start=Medium.reference_T),
        X(start=Medium.reference_X));
      Real err_T=abs(medium.T - T);
      Real err_d=abs(medium.d - d);
      Real err_u=abs(medium.u - u);

      // check isentropicEnthalpy
      Medium.ThermodynamicState state_h_is=Medium.setState_phX(
              2*Medium.reference_p,
              h_is,
              Medium.reference_X);
      Medium.SpecificEntropy s_is=Medium.specificEntropy(state_h_is);
      Real err_h_is=abs(s - s_is);
      constant Real eps=1e-9;
    equation
      medium.p = p;
      medium.h = h;
      medium.Xi = Medium.reference_X[1:Medium.nXi];

      // When iterating at the initial time the asserts below could be violated.
      // To avoid an error, the check is only performed at the end of the simulation.
      when terminal() then
        assert(err_T <= eps, "Error: abs(medium.T - T) > eps\n" + "(err_T = "
           + String(err_T) + ", eps = " + String(eps) + ")");
      end when;

      when terminal() then
        assert(err_d <= eps, "Error: abs(medium.d - d) > eps" + "(err_d = " +
          String(err_d) + ", eps = " + String(eps) + ")");
      end when;

      when terminal() then
        assert(err_u <= eps, "Error: abs(medium.u - u) > eps" + "(err_u = " +
          String(err_u) + ", eps = " + String(eps) + ")");
      end when;

      // when terminal() then
      assert(err_h_is <= eps_h_is,
        "Error: entropy not constant for isentropicEnthalpy" + "(err_h_is = "
         + String(err_h_is) + ", eps = " + String(eps_h_is) + ")");
      // end when;
      annotation (experiment(StopTime=1.01));
    end FlueGasSixComponents;

    model ConstantPropertyLiquidWater
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater);
      annotation (experiment(StopTime=0.1));
    end ConstantPropertyLiquidWater;

    model SimpleAir
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Air.SimpleAir);
      annotation (experiment(StopTime=0.1));
    end SimpleAir;

    model MoistAir
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Air.MoistAir);
    end MoistAir;

    model ReferenceAir
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Air.ReferenceAir);
    end ReferenceAir;

    model ReferenceMoistAir
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Air.ReferenceMoistAir);
    end ReferenceMoistAir;

    model R134a
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.R134a);
    end R134a;

    package IncompleteMedia
      extends Modelica.Icons.ExamplesPackage;

      model Glycol47
        extends PartialMediumFunctions(redeclare package Medium =
              Modelica.Media.Incompressible.Examples.Glycol47);
      end Glycol47;

      model WaterIF97_pT
        extends PartialMediumFunctions(redeclare package Medium =
              Modelica.Media.Water.WaterIF97_pT);
      end WaterIF97_pT;

      model WaterIF97_ph
        extends PartialMediumFunctions(redeclare package Medium =
              Modelica.Media.Water.WaterIF97_ph);
      end WaterIF97_ph;
    end IncompleteMedia;
  end TestAllProperties;

  package TestOnly "examples for testing purposes "
    extends Modelica.Icons.ExamplesPackage;
    model MixIdealGasAir "Ideal gas air medium model"
      extends Modelica.Icons.Example;
      package Medium = Modelica.Media.IdealGases.MixtureGases.CombustionAir
        "Medium model";
      Medium.BaseProperties medium(
        T(start=200.0,fixed=true),
        X(start={0.2,0.8}),
        p(start=1.0e5,fixed=true));
      Medium.BaseProperties medium2(
        T(start=300.0,fixed=true),
        X(start={0.2,0.8},fixed=true),
        p(start=2.0e5,fixed=true));
      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(medium.state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium.state);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
      Medium.SpecificEntropy s2=Medium.specificEntropy(medium2.state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(medium.state);
      Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
      Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
      Real beta=Medium.isobaricExpansionCoefficient(medium.state);
      Real gamma2=Medium.isothermalCompressibility(medium2.state);
      Medium.SpecificEnthalpy h_is=Medium.isentropicEnthalpyApproximation(2.0e5,
          medium.state);
    equation
      der(medium.p) = 1000.0;
      der(medium.T) = 1000;
      medium.X = {0.2,0.8};
      der(medium2.p) = 1.0e3;
      der(medium2.T) = 0.0;
      der(medium2.X) = {0.0,0.0};
      //  s2 = s;
      annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</html>"),experiment(StopTime=1));
    end MixIdealGasAir;

    model FlueGas "Ideal gas flue gas  model"
      extends Modelica.Icons.Example;
      package Medium =
          Modelica.Media.IdealGases.MixtureGases.FlueGasLambdaOnePlus
        "Medium model";
      Medium.ThermodynamicState state(
        T(start=200.0,fixed=true),
        X(start={0.2,0.3,0.4,0.1}),
        p(start=1.0e5,fixed=true));
      Medium.BaseProperties medium2(
        T(start=300.0,fixed=true),
        X(start={0.2,0.1,0.3,0.4},fixed=true),
        p(start=2.0e5,fixed=true));
      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(state);
      Medium.SpecificEntropy s=Medium.specificEntropy(state);
      Medium.SpecificEntropy s2=Medium.specificEntropy(medium2.state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(state);
      Real beta=Medium.isobaricExpansionCoefficient(state);
      Real gamma2=Medium.isothermalCompressibility(medium2.state);
      Medium.SpecificEnthalpy h_is=Medium.isentropicEnthalpyApproximation(2.0e5,
          medium2.state);
      parameter Medium.MolarMass[4] MMx=Medium.data.MM
        "Molar masses of flue gas";
      Medium.MolarMass MM=1/sum(state.X[j]/MMx[j] for j in 1:4) "molar mass";
      Real[4] dddX=Medium.density_derX(medium2.state);
    equation
      der(state.p) = 1000.0;
      der(state.T) = 1000;
      state.X = {0.2,0.2,0.4,0.2};
      der(medium2.p) = 1.0e3;
      der(medium2.T) = 0.0;
      der(medium2.X[1:Medium.nX]) = {0.0,0.0,0.0,0.0};
      annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</html>"),experiment(StopTime=1));
    end FlueGas;

    package N2AsMix "air and steam mixture (no condensation!, pseudo-mixture)"
      extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
        mediumName="Nitrogen",
        data={Modelica.Media.IdealGases.Common.SingleGasesData.N2},
        fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2},
        substanceNames={"Nitrogen"},
        reference_X={1.0});
      annotation (Documentation(info="<html>

</html>"));
    end N2AsMix;

    model IdealGasN2 "Test IdealGas.SingleMedia.N2 medium model"
      extends Modelica.Icons.Example;

      parameter Modelica.SIunits.Volume V=1 "Size of fixed volume";
      parameter Medium.MassFlowRate m_flow_ext=0.01
        "Mass flow rate into volume";
      parameter Medium.EnthalpyFlowRate H_flow_ext=5000
        "Enthalpy flow rate into volume";

      package Medium = Modelica.Media.IdealGases.SingleGases.N2 "Medium model";
      // initType=Medium.Choices.Init.SteadyState,

      Medium.BaseProperties medium(
        preferredMediumStates=true,
        p(start=1.e5, fixed=true),
        T(start=300, fixed=true));

      Real m(quantity=Medium.mediumName, start=1.0);
      Modelica.SIunits.InternalEnergy U;

      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(medium.state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium.state);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(medium.state);
    equation

      m = medium.d*V;
      U = m*medium.u;

      // Mass balance
      der(m) = m_flow_ext;

      // Energy balance
      der(U) = H_flow_ext;
      annotation (Documentation(info="<html>

</html>"),experiment(StopTime=1));
    end IdealGasN2;

    //   package TestMedia "Test interfaces of media"
    //     extends Modelica.Icons.Package;
    //     model TemplateMedium "Test Interfaces.TemplateMedium"
    //       extends Modelica.Icons.Example;
    //       package Medium = Interfaces.TemplateMedium "Medium model";
    //       Medium.ThermodynamicState state;
    //
    //       Medium.DynamicViscosity eta=Medium.dynamicViscosity(state);
    //       Medium.ThermalConductivity lambda=Medium.thermalConductivity(state);
    //       Medium.SpecificEntropy s=Medium.specificEntropy(state);
    //       Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
    //       Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
    //       Medium.IsentropicExponent gamma=Medium.isentropicExponent(state);
    //       Medium.VelocityOfSound a=Medium.velocityOfSound(state);
    //     equation
    //       state.p = 1.0e5;
    //       state.T = 300 + time/1000;
    //       annotation (Documentation(info="<html>
    //
    // </html>"),
    //          experiment(StopTime=1.01));
    //     end TemplateMedium;
    //
    //     annotation (Documentation(info="<html>
    //
    // </html>"));
    //   end TestMedia;

    model IdealGasN2Mix "Test IdealGas.SingleMedia.N2 medium model"
      extends Modelica.Icons.Example;

      parameter Modelica.SIunits.Volume V=1 "Size of volume";
      parameter Medium.MassFlowRate m_flow_ext=0.01
        "Mass flow rate flowing into volume";
      parameter Medium.EnthalpyFlowRate H_flow_ext=5000
        "Enthalpy flow rate flowing into volume";

      package Medium = N2AsMix "Medium model";
      // initType=Medium.Choices.Init.SteadyState,

      Medium.BaseProperties medium(
        preferredMediumStates=true,
        p(start=1.e5, fixed=true),
        T(start=300, fixed=true));

      Real m(quantity=Medium.mediumName, start=1.0);
      Modelica.SIunits.InternalEnergy U;

      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(medium.state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium.state);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(medium.state);
    equation

      m = medium.d*V;
      U = m*medium.u;
      medium.X = {1.0};
      // Mass balance
      der(m) = m_flow_ext;

      // Energy balance
      der(U) = H_flow_ext;
      annotation (Documentation(info="<html>

</html>"),experiment(StopTime=1));
    end IdealGasN2Mix;
    annotation (Documentation(info="<html>

</html>"));
  end TestOnly;

  package TestsWithFluid
    "Library to test that all media models simulate and fulfill the expected structural properties"

    extends Modelica.Icons.ExamplesPackage;

    package Components
      "Functions, connectors and models needed for the media model tests"

      extends Modelica.Icons.Library;

      connector FluidPort
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"
        extends Modelica.Icons.ObsoleteModel;
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        Medium.AbsolutePressure p "Pressure in the connection point";
        flow Medium.MassFlowRate m_flow
          "Mass flow rate from the connection point into the component";

        Medium.SpecificEnthalpy h
          "Specific mixture enthalpy in the connection point";
        flow Medium.EnthalpyFlowRate H_flow
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";

        Medium.MassFraction Xi[Medium.nXi]
          "Independent mixture mass fractions m_i/m in the connection point";
        flow Medium.MassFlowRate mXi_flow[Medium.nXi]
          "Mass flow rates of the independent substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";

        Medium.ExtraProperty C[Medium.nC]
          "properties c_i/m in the connection point";
        flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC]
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";

        annotation (Documentation(info="<html>

</html>"));
      end FluidPort;

      connector FluidPort_a "Fluid connector with filled icon"
        extends FluidPort;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,127,255},
                      fillColor={0,127,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,0},
                      fillColor={0,127,255},
                      fillPattern=FillPattern.Solid),Text(
                      extent={{-88,206},{112,112}},
                      textString="%name",
                      lineColor={0,0,255})}),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,127,255},
                      fillColor={0,127,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,0},
                      fillColor={0,127,255},
                      fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>Modelica.Media.Examples.Tests.Components.FluidPort_a
</html>"));
      end FluidPort_a;

      connector FluidPort_b "Fluid connector with outlined icon"
        extends FluidPort;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,127,255},
                      fillColor={0,127,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,0},
                      fillColor={0,127,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-80,80},{80,-80}},
                      lineColor={0,127,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Text(
                      extent={{-88,192},{112,98}},
                      textString="%name",
                      lineColor={0,0,255})}),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,127,255},
                      fillColor={0,127,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,0},
                      fillColor={0,127,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-80,80},{80,-80}},
                      lineColor={0,127,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>

</html>"));
      end FluidPort_b;

      model PortVolume
        "Fixed volume associated with a port by the finite volume method"
        extends Modelica.Icons.ObsoleteModel;
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        parameter Modelica.SIunits.Volume V=1e-6
          "Fixed size of junction volume";

        parameter Boolean use_p_start=true "select p_start or d_start"
          annotation (Evaluate=true, Dialog(group=
                "Initial pressure or initial density"));
        parameter Medium.AbsolutePressure p_start=101325 "Initial pressure"
          annotation (Dialog(group="Initial pressure or initial density",
              enable=use_p_start));
        parameter Medium.Density d_start=1 "Initial density" annotation (Dialog(
              group="Initial pressure or initial density", enable=not
                use_p_start));
        parameter Boolean use_T_start=true "select T_start or h_start"
          annotation (Evaluate=true, Dialog(group=
                "Initial temperature or initial specific enthalpy"));
        parameter Medium.Temperature T_start=
            Modelica.SIunits.Conversions.from_degC(20) "Initial temperature"
          annotation (Dialog(group=
                "Initial temperature or initial specific enthalpy", enable=
                use_T_start));
        parameter Medium.SpecificEnthalpy h_start=1.e4
          "Initial specific enthalpy" annotation (Dialog(group=
                "Initial temperature or initial specific enthalpy", enable=not
                use_T_start));
        parameter Medium.MassFraction X_start[Medium.nX]
          "Initial mass fractions m_i/m" annotation (Dialog(group=
                "Only for multi-substance flow", enable=Medium.nX > 0));

        FluidPort_a port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
        Medium.BaseProperties medium(preferredMediumStates=true);
        Modelica.SIunits.Energy U "Internal energy of port volume";
        Modelica.SIunits.Mass m "Mass of junction volume";
        Modelica.SIunits.Mass mXi[Medium.nXi]
          "Independent substance masses of junction volume";

      initial equation
        if not Medium.singleState then
          if use_p_start then
            medium.p = p_start;
          else
            medium.d = d_start;
          end if;
        end if;

        if use_T_start then
          medium.T = T_start;
        else
          medium.h = h_start;
        end if;

        medium.Xi = X_start[1:Medium.nXi];
      equation
        // Connect port to medium variables
        medium.p = port.p;
        medium.h = port.h;
        medium.Xi = port.Xi;

        // Total quantities
        m = V*medium.d;
        mXi = m*medium.Xi;
        U = m*medium.u;

        // Mass and energy balance
        der(m) = port.m_flow;
        der(mXi) = port.mXi_flow;
        der(U) = port.H_flow;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Ellipse(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.Sphere,
                      fillColor={170,213,255}),Text(
                      extent={{-144,178},{146,116}},
                      textString="%name",
                      lineColor={0,0,255}),Text(
                      extent={{-130,-108},{144,-150}},
                      lineColor={0,0,0},
                      textString="V=%V")}), Documentation(info="<html>
<p>
This component models the <b>volume</b> of <b>fixed size</b> that is
associated with the <b>fluid port</b> to which it is connected.
This means that all medium properties inside the volume, are identical
to the port medium properties. In particular, the specific enthalpy
inside the volume (= medium.h) is always identical to the specific enthalpy
in the port (port.h = medium.h). Usually, this model is used when
discretizing a component according to the finite volume method into
volumes in internal ports that only store energy and mass and into
transport elements that just transport energy, mass and momentum
between the internal ports without storing these quantities during the
transport.
</p>
</html>"));
      end PortVolume;

      model FixedMassFlowRate
        "Ideal pump that produces a constant mass flow rate from a large reservoir at fixed temperature and mass fraction"
        extends Modelica.Icons.ObsoleteModel;
        parameter Medium.MassFlowRate m_flow
          "Fixed mass flow rate from an infinite reservoir to the fluid port";

        parameter Boolean use_T_ambient=true "select T_ambient or h_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.SIunits.Conversions.from_degC(20) "Ambient temperature"
          annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=1.e4
          "Ambient specific enthalpy" annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=not
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX]
          "Ambient mass fractions m_i/m of reservoir";

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
      equation
        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;

        medium.Xi = X_ambient[1:Medium.nXi];
        medium.p = port.p;
        port.m_flow = -m_flow;
        port.mXi_flow = semiLinear(
                port.m_flow,
                port.Xi,
                medium.Xi);
        port.H_flow = semiLinear(
                port.m_flow,
                port.h,
                medium.h);
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Rectangle(
                      extent={{20,60},{100,-60}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={192,192,192}),Rectangle(
                      extent={{38,40},{100,-40}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={0,127,255}),Ellipse(
                      extent={{-100,80},{60,-80}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid,
                      lineColor={0,0,255}),Polygon(
                      points={{-60,70},{60,0},{-60,-68},{-60,70}},
                      lineColor={0,0,255},
                      fillColor={0,0,255},
                      fillPattern=FillPattern.Solid),Text(
                      extent={{-54,32},{16,-30}},
                      lineColor={255,0,0},
                      textString="m"),Text(
                      extent={{-142,142},{156,88}},
                      textString="%name",
                      lineColor={0,0,255}),Text(
                      extent={{-154,-88},{150,-132}},
                      lineColor={0,0,0},
                      textString="%m_flow"),Ellipse(
                      extent={{-26,30},{-18,22}},
                      lineColor={255,0,0},
                      fillColor={255,0,0},
                      fillPattern=FillPattern.Solid)}), Documentation(info="<html>

</html>"));
      end FixedMassFlowRate;

      model FixedAmbient
        "Ambient pressure, temperature and mass fraction source"
        extends Modelica.Icons.ObsoleteModel;
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        parameter Boolean use_p_ambient=true "select p_ambient or d_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient pressure or ambient density"));
        parameter Medium.AbsolutePressure p_ambient=101325 "Ambient pressure"
          annotation (Dialog(group="Ambient pressure or ambient density",
              enable=use_p_ambient));
        parameter Medium.Density d_ambient=1 "Ambient density" annotation (
            Dialog(group="Ambient pressure or ambient density", enable=not
                use_p_ambient));
        parameter Boolean use_T_ambient=true "select T_ambient or h_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.SIunits.Conversions.from_degC(20) "Ambient temperature"
          annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=1.e4
          "Ambient specific enthalpy" annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=not
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX]
          "Ambient mass fractions m_i/m" annotation (Dialog(group=
                "Only for multi-substance flow", enable=Medium.nX > 0));

        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));

      equation
        if use_p_ambient or Medium.singleState then
          medium.p = p_ambient;
        else
          medium.d = d_ambient;
        end if;

        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;

        medium.Xi = X_ambient[1:Medium.nXi];

        port.p = medium.p;
        port.H_flow = semiLinear(
                port.m_flow,
                port.h,
                medium.h);
        port.mXi_flow = semiLinear(
                port.m_flow,
                port.Xi,
                medium.Xi);
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Ellipse(
                      extent={{-100,80},{100,-80}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.Sphere,
                      fillColor={0,127,255}),Text(
                      extent={{-136,144},{132,82}},
                      textString="%name",
                      lineColor={0,0,255})}), Documentation(info="<html>
<p>
Model <b>FixedAmbient_pt</b> defines constant values for ambient conditions:
</p>
<ul>
<li> Ambient pressure.</li>
<li> Ambient temperature.</li>
<li> Ambient mass fractions (only for multi-substance flow).</li>
</ul>
<p>
Note, that ambient temperature
and mass fractions have only an effect if the mass flow
is from the ambient into the port. If mass is flowing from
the port into the ambient, the ambient definitions,
with exception of ambient pressure, do not have an effect.
</p>
</html>"));
      end FixedAmbient;

      model ShortPipe "Simple pressure loss in pipe"
        extends Modelica.Icons.ObsoleteModel;
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        parameter Medium.AbsolutePressure dp_nominal(min=1.e-10)
          "Nominal pressure drop";
        parameter Medium.MassFlowRate m_flow_nominal(min=1.e-10)
          "Nominal mass flow rate at nominal pressure drop";

        FluidPort_a port_a(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
        FluidPort_b port_b(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{120,-10},{100,10}}, rotation=0)));
        // Medium.BaseProperties medium_a(p=port_a.p, h=port_a.h, Xi=port_a.Xi)
        //   "Medium properties in port_a";
        // Medium.BaseProperties medium_b(p=port_b.p, h=port_b.h, Xi=port_b.Xi)
        //   "Medium properties in port_b";
        Medium.MassFlowRate m_flow
          "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
        Modelica.SIunits.Pressure dp "Pressure drop from port_a to port_b";
      equation
        /* Handle reverse and zero flow */
        port_a.H_flow = semiLinear(
                port_a.m_flow,
                port_a.h,
                port_b.h);
        port_a.mXi_flow = semiLinear(
                port_a.m_flow,
                port_a.Xi,
                port_b.Xi);

        /* Energy, mass and substance mass balance */
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

        // Design direction of mass flow rate
        m_flow = port_a.m_flow;

        // Pressure drop
        dp = port_a.p - port_b.p;
        m_flow = (m_flow_nominal/dp_nominal)*dp;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                      extent={{-100,60},{100,-60}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={192,192,192}),Rectangle(
                      extent={{-100,34},{100,-36}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={0,127,255}),Text(
                      extent={{-150,140},{150,80}},
                      lineColor={0,0,0},
                      textString="%name"),Text(
                      extent={{-136,-62},{122,-108}},
                      lineColor={0,0,0},
                      textString="k=%m_flow_nominal/%dp_nominal")}),
            Documentation(info="<html>
<p>
Model <b>ShortPipe</b> defines a simple pipe model
with pressure loss due to friction. It is assumed that
no mass or energy is stored in the pipe.
</p>
</html>"));
      end ShortPipe;

      partial model PartialTestModel "Basic test model to test a medium"

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);
        parameter Modelica.SIunits.AbsolutePressure p_start=Medium.p_default
          "Initial value of pressure";
        parameter Modelica.SIunits.Temperature T_start=Medium.T_default
          "Initial value of temperature";
        parameter Modelica.SIunits.SpecificEnthalpy h_start=Medium.h_default
          "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX]=Medium.X_default
          "Initial value of mass fractions";

        /*
  parameter SI.AbsolutePressure p_start = 1.0e5 "Initial value of pressure";
  parameter SI.Temperature T_start = 300 "Initial value of temperature";
  parameter SI.Density h_start = 1 "Initial value of specific enthalpy";
  parameter Real X_start[Medium.nX] = Medium.reference_X
    "Initial value of mass fractions";
*/
        Modelica.Fluid.Vessels.ClosedVolume volume(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1,
          nPorts=2,
          use_portsData=false) annotation (Placement(transformation(extent={{-40,
                  0},{-20,20}}, rotation=0)));
        Modelica.Fluid.Sources.MassFlowSource_T fixedMassFlowRate(
          redeclare package Medium = Medium,
          m_flow=1,
          T=system.T_ambient,
          nPorts=1) annotation (Placement(transformation(extent={{-80,-2},{-60,
                  18}}, rotation=0)));
        Modelica.Fluid.Sources.FixedBoundary ambient(
          redeclare package Medium = Medium,
          nPorts=1,
          p=p_start,
          T=T_start) annotation (Placement(transformation(extent={{60,0},{40,20}},
                rotation=0)));
        Modelica.Fluid.Pipes.StaticPipe shortPipe(
          redeclare package Medium = Medium,
          length=1,
          redeclare model FlowModel =
              Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
                dp_nominal=1000000000, m_flow_nominal=1.0),
          diameter=0.05) annotation (Placement(transformation(extent={{0,0},{20,
                  20}}, rotation=0)));
        inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      equation
        connect(fixedMassFlowRate.ports[1], volume.ports[1]) annotation (Line(
            points={{-60,8},{-46,8},{-46,0},{-32,0}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(volume.ports[2], shortPipe.port_a) annotation (Line(
            points={{-28,0},{-16,0},{-16,10},{0,10}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(shortPipe.port_b, ambient.ports[1]) annotation (Line(
            points={{20,10},{40,10}},
            color={0,127,255},
            smooth=Smooth.None));
        annotation (Documentation(info="<html>

</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics));
      end PartialTestModel;

      partial model PartialTestModel2
        "slightly larger test model to test a medium"

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);
        parameter Modelica.SIunits.AbsolutePressure p_start=1.0e5
          "Initial value of pressure";
        parameter Modelica.SIunits.Temperature T_start=300
          "Initial value of temperature";
        parameter Modelica.SIunits.SpecificEnthalpy h_start=1
          "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX]=Medium.reference_X
          "Initial value of mass fractions";
        Modelica.Fluid.Vessels.ClosedVolume volume(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1,
          nPorts=2,
          use_portsData=false) annotation (Placement(transformation(extent={{-60,
                  20},{-40,40}}, rotation=0)));
        Modelica.Fluid.Sources.MassFlowSource_T fixedMassFlowRate(
          redeclare package Medium = Medium,
          m_flow=1,
          T=system.T_ambient,
          nPorts=1) annotation (Placement(transformation(extent={{-100,0},{-80,
                  20}}, rotation=0)));
        Modelica.Fluid.Sources.FixedBoundary ambient(
          redeclare package Medium = Medium,
          p=p_start,
          T=T_start,
          nPorts=1) annotation (Placement(transformation(extent={{60,0},{40,20}},
                rotation=0)));
        Modelica.Fluid.Pipes.StaticPipe shortPipe(
          redeclare package Medium = Medium,
          length=1,
          redeclare model FlowModel =
              Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
                dp_nominal=1000000000, m_flow_nominal=1.0),
          diameter=0.05) annotation (Placement(transformation(extent={{-42,0},{
                  -22,20}}, rotation=0)));
        inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
          annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
        Modelica.Fluid.Pipes.StaticPipe shortPipe1(
          redeclare package Medium = Medium,
          length=1,
          redeclare model FlowModel =
              Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
                dp_nominal=1000000000, m_flow_nominal=1.0),
          diameter=0.05) annotation (Placement(transformation(extent={{0,0},{20,
                  20}}, rotation=0)));
        Modelica.Fluid.Vessels.ClosedVolume volume1(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1,
          nPorts=2,
          use_portsData=false) annotation (Placement(transformation(extent={{-18,
                  20},{2,40}}, rotation=0)));
      equation
        connect(fixedMassFlowRate.ports[1], volume.ports[1]) annotation (Line(
            points={{-80,10},{-50,10},{-50,20},{-52,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(volume.ports[2], shortPipe.port_a) annotation (Line(
            points={{-48,20},{-50,20},{-50,10},{-42,10}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(shortPipe1.port_a, volume1.ports[1]) annotation (Line(
            points={{0,10},{-8,10},{-8,20},{-10,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(shortPipe.port_b, volume1.ports[2]) annotation (Line(
            points={{-22,10},{-8,10},{-8,20},{-6,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(shortPipe1.port_b, ambient.ports[1]) annotation (Line(
            points={{20,10},{40,10}},
            color={0,127,255},
            smooth=Smooth.None));
        annotation (Documentation(info="<html>

</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics));
      end PartialTestModel2;
      annotation (Documentation(info="<html>

</html>"));
    end Components;

    package MediaTestModels "Test models to test all media"
      extends Modelica.Icons.ExamplesPackage;
      package Air "Test models of library Modelica.Media.Air"
        extends Modelica.Icons.ExamplesPackage;
        model SimpleAir "Test Modelica.Media.Air.SimpleAir"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium = Modelica.Media.Air.SimpleAir);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end SimpleAir;

        model DryAirNasa "Test Modelica.Media.Air.DryAirNasa"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium = Modelica.Media.Air.DryAirNasa);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end DryAirNasa;

        model MoistAir "Test Modelica.Media.Air.MoistAir"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium = Modelica.Media.Air.MoistAir);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end MoistAir;
        annotation (Documentation(info="<html>

</html>"));
      end Air;

      package IdealGases "Test models of library Modelica.Media.IdealGases"
        extends Modelica.Icons.ExamplesPackage;

        model Air "Test single gas Modelica.Media.IdealGases.SingleGases.Air"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium = Modelica.Media.Air.DryAirNasa);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end Air;

        model Nitrogen
          "Test single gas Modelica.Media.IdealGases.SingleGases.N2"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium =
                Modelica.Media.IdealGases.SingleGases.N2);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end Nitrogen;

        model SimpleNaturalGas
          "Test mixture gas Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium =
                Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end SimpleNaturalGas;

        model SimpleNaturalGasFixedComposition
          "Test mixture gas Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium =
                Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGasFixedComposition);
          annotation (experiment(StopTime=1.01));
        end SimpleNaturalGasFixedComposition;
      end IdealGases;

      package Incompressible
        "Test models of library Modelica.Media.Incompressible"
        extends Modelica.Icons.ExamplesPackage;
        model Glycol47 "Test Modelica.Media.Incompressible.Examples.Glycol47"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium =
                Modelica.Media.Incompressible.Examples.Glycol47 (final
                  singleState=true, final enthalpyOfT=true));
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end Glycol47;

        model Essotherm650
          "Test Modelica.Media.Incompressible.Examples.Essotherm65"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium =
                Modelica.Media.Incompressible.Examples.Essotherm650);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end Essotherm650;
        annotation (Documentation(info="<html>

</html>"));
      end Incompressible;

      package Water "Test models of library Modelica.Media.Water"
        extends Modelica.Icons.ExamplesPackage;
        model ConstantPropertyLiquidWater
          "Test Modelica.Media.Water.ConstantPropertyLiquidWater"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium =
                Modelica.Media.Water.ConstantPropertyLiquidWater);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end ConstantPropertyLiquidWater;

        model IdealSteam "Test Modelica.Media.Water.IdealSteam"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium = Modelica.Media.Water.IdealSteam);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end IdealSteam;

        model WaterIF97OnePhase_ph
          "Test Modelica.Media.Water.WaterIF97OnePhase_ph"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
            redeclare package Medium =
                Modelica.Media.Water.WaterIF97OnePhase_ph,
            system(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),

            volume(medium(h(fixed=true), p(fixed=true))));

          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end WaterIF97OnePhase_ph;

        model WaterIF97_pT "Test Modelica.Media.Water.WaterIF97_pT"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
            redeclare package Medium = Modelica.Media.Water.WaterIF97_pT,
            system(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),

            volume(medium(T(fixed=true), p(fixed=true))));

          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end WaterIF97_pT;

        model WaterIF97_ph "Test Modelica.Media.Water.WaterIF97_ph"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
            redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
            system(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),

            volume(medium(h(fixed=true), p(fixed=true))));

          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end WaterIF97_ph;
        /*
        model WaterIF97_dT "Test Modelica.Media.Water.WaterIF97_dT"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.WaterIF97_dT,
              ambient(use_p_ambient=false, d_ambient=996.557));
        end WaterIF97_dT;
*/
        annotation (Documentation(info="<html>

</html>"));
      end Water;

      package LinearFluid
        "Test models of library Modelica.Media.Incompressible"
        extends Modelica.Icons.ExamplesPackage;
        model LinearColdWater
          "Test Modelica.Media.Incompressible.Examples.Glycol47"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium =
                Modelica.Media.CompressibleLiquids.LinearColdWater);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end LinearColdWater;

        model LinearWater_pT
          "Test Modelica.Media.Incompressible.Examples.Essotherm65"
          extends Modelica.Icons.Example;
          extends ModelicaTest.Media.TestsWithFluid.Components.PartialTestModel(
              redeclare package Medium =
                Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient);
          annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
        end LinearWater_pT;
        annotation (Documentation(info="<html>

</html>"));
      end LinearFluid;
      annotation (Documentation(info="<html>

</html>"));
    end MediaTestModels;
    annotation (Documentation(info="<html>

</html>"));
  end TestsWithFluid;
end Media;
