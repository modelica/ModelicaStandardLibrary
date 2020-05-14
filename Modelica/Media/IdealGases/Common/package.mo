within Modelica.Media.IdealGases;
package Common "Common packages and data for the ideal gas models"
  extends Modelica.Icons.Package;

record DataRecord
  "Coefficient data record for properties of ideal gases based on NASA source"
  extends Modelica.Icons.Record;
  String name "Name of ideal gas";
  SI.MolarMass MM "Molar mass";
  SI.SpecificEnthalpy Hf "Enthalpy of formation at 298.15K";
  SI.SpecificEnthalpy H0 "H0(298.15K) - H0(0K)";
  SI.Temperature Tlimit "Temperature limit between low and high data sets";
  Real alow[7] "Low temperature coefficients a";
  Real blow[2] "Low temperature constants b";
  Real ahigh[7] "High temperature coefficients a";
  Real bhigh[2] "High temperature constants b";
  SI.SpecificHeatCapacity R_s "Gas constant";
  annotation (Documentation(info="<html>
<p>
This data record contains the coefficients for the
ideal gas equations according to:
</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <strong>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</strong>. NASA
  report TP-2002-211556</p>
</blockquote>
<p>
The equations have the following structure:
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/Common/singleEquations.png\"></div>
<p>
The polynomials for h(T) and s0(T) are derived via integration from the one for cp(T)  and contain the integration constants b1, b2 that define the reference specific enthalpy and entropy. For entropy differences the reference pressure p0 is arbitrary, but not for absolute entropies. It is chosen as 1 standard atmosphere (101325 Pa).
</p>
<p>
For most gases, the region of validity is from 200 K to 6000 K.
The equations are split into two regions that are separated
by Tlimit (usually 1000 K). In both regions the gas is described
by the data above. The two branches are continuous and in most
gases also differentiable at Tlimit.
</p>
</html>"));
end DataRecord;

partial package SingleGasNasa
  "Medium model of an ideal gas based on NASA source"

  extends Interfaces.PartialPureSubstance(
     ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
     redeclare final record FluidConstants =
        Modelica.Media.Interfaces.Types.IdealGas.FluidConstants,
     mediumName=data.name,
     substanceNames={data.name},
     singleState=false,
     Temperature(min=200, max=6000, start=500, nominal=500),
     SpecificEnthalpy(start=if Functions.referenceChoice==ReferenceEnthalpy.ZeroAt0K then data.H0 else
        if Functions.referenceChoice==ReferenceEnthalpy.UserDefined then Functions.h_offset else 0, nominal=1.0e5),
     Density(start=10, nominal=10),
     AbsolutePressure(start=10e5, nominal=10e5));

  redeclare record extends ThermodynamicState
    "Thermodynamic state variables for ideal gases"
    AbsolutePressure p "Absolute pressure of medium";
    Temperature T "Temperature of medium";
  end ThermodynamicState;

  import Modelica.Math;
  import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

  constant IdealGases.Common.DataRecord data
    "Data record of ideal gas substance";

  constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

  redeclare model extends BaseProperties(
   T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
   p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))
    "Base properties of ideal gas medium"
  equation
    assert(T >= 200 and T <= 6000, "
Temperature T (= " + String(T) + " K) is not in the allowed range
200 K <= T <= 6000 K required from medium model \"" + mediumName + "\".
");
    MM = data.MM;
    R_s = data.R_s;
    h = Modelica.Media.IdealGases.Common.Functions.h_T(
            data, T,
            Modelica.Media.IdealGases.Common.Functions.excludeEnthalpyOfFormation,
            Modelica.Media.IdealGases.Common.Functions.referenceChoice,
            Modelica.Media.IdealGases.Common.Functions.h_offset);
    u = h - R_s*T;

    // Has to be written in the form d=f(p,T) in order that static
    // state selection for p and T is possible
    d = p/(R_s*T);
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
  end BaseProperties;

    redeclare function setState_pTX
    "Return thermodynamic state as function of p, T and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p=p,T=T);
      annotation(Inline=true,smoothOrder=2);
    end setState_pTX;

    redeclare function setState_phX
    "Return thermodynamic state as function of p, h and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p=p,T=T_h(h));
      annotation(Inline=true,smoothOrder=2);
    end setState_phX;

    redeclare function setState_psX
    "Return thermodynamic state as function of p, s and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p=p,T=T_ps(p,s));
      annotation(Inline=true,smoothOrder=2);
    end setState_psX;

    redeclare function setState_dTX
    "Return thermodynamic state as function of d, T and composition X"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p=d*data.R_s*T,T=T);
      annotation(Inline=true,smoothOrder=2);
    end setState_dTX;

      redeclare function extends setSmoothState
    "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      algorithm
        state := ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                    T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
        annotation(Inline=true,smoothOrder=2);
      end setSmoothState;

  redeclare function extends pressure "Return pressure of ideal gas"
  algorithm
    p := state.p;
    annotation(Inline=true,smoothOrder=2);
  end pressure;

  redeclare function extends temperature "Return temperature of ideal gas"
  algorithm
    T := state.T;
    annotation(Inline=true,smoothOrder=2);
  end temperature;

  redeclare function extends density "Return density of ideal gas"
  algorithm
    d := state.p/(data.R_s*state.T);
    annotation(Inline=true,smoothOrder=2);
  end density;

  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := Modelica.Media.IdealGases.Common.Functions.h_T(
             data,state.T);
    annotation(Inline=true,smoothOrder=2);
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := Modelica.Media.IdealGases.Common.Functions.h_T(
             data,state.T) - data.R_s*state.T;
    annotation(Inline=true,smoothOrder=2);
  end specificInternalEnergy;

  redeclare function extends specificEntropy "Return specific entropy"
    extends Modelica.Icons.Function;
  algorithm
    s := Modelica.Media.IdealGases.Common.Functions.s0_T(
              data, state.T) - data.R_s*Modelica.Math.log(state.p/reference_p);
    annotation(Inline=true,smoothOrder=2);
  end specificEntropy;

  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := Modelica.Media.IdealGases.Common.Functions.h_T(
             data,state.T) - state.T*specificEntropy(state);
    annotation(Inline=true,smoothOrder=2);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := Modelica.Media.IdealGases.Common.Functions.h_T(
             data,state.T) - data.R_s*state.T - state.T*specificEntropy(state);
    annotation(Inline=true,smoothOrder=2);
  end specificHelmholtzEnergy;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
  algorithm
    cp := Modelica.Media.IdealGases.Common.Functions.cp_T(
               data, state.T);
    annotation(Inline=true,smoothOrder=2);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Compute specific heat capacity at constant volume from temperature and gas data"
  algorithm
    cv := Modelica.Media.IdealGases.Common.Functions.cp_T(
               data, state.T) - data.R_s;
    annotation(Inline=true,smoothOrder=2);
  end specificHeatCapacityCv;

  redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
    gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
    annotation(Inline=true,smoothOrder=2);
  end isentropicExponent;

  redeclare function extends velocityOfSound "Return velocity of sound"
    extends Modelica.Icons.Function;
  algorithm
    a := sqrt(max(0,data.R_s*state.T*Modelica.Media.IdealGases.Common.Functions.cp_T(
                                        data, state.T)/specificHeatCapacityCv(state)));
    annotation(Inline=true,smoothOrder=2);
  end velocityOfSound;

  function isentropicEnthalpyApproximation
    "Approximate method of calculating h_is from upstream properties and downstream pressure"
    extends Modelica.Icons.Function;
    input SI.Pressure p2 "Downstream pressure";
    input ThermodynamicState state "Properties at upstream location";
    input Boolean exclEnthForm=Functions.excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input ReferenceEnthalpy refChoice=Functions.referenceChoice
      "Choice of reference enthalpy";
    input SpecificEnthalpy h_off=Functions.h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h_is "Isentropic enthalpy";
  protected
    IsentropicExponent gamma =  isentropicExponent(state) "Isentropic exponent";
  algorithm
    h_is := Modelica.Media.IdealGases.Common.Functions.h_T(
                data,state.T,exclEnthForm,refChoice,h_off) +
      gamma/(gamma - 1.0)*state.p/density(state)*((p2/state.p)^((gamma - 1)/gamma) - 1.0);
    annotation(Inline=true,smoothOrder=2);
  end isentropicEnthalpyApproximation;

  redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
  input Boolean exclEnthForm=Functions.excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input ReferenceEnthalpy refChoice=Functions.referenceChoice
      "Choice of reference enthalpy";
  input SpecificEnthalpy h_off=Functions.h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  algorithm
    h_is := isentropicEnthalpyApproximation(p_downstream,refState,exclEnthForm,refChoice,h_off);
    annotation(Inline=true,smoothOrder=2);
  end isentropicEnthalpy;

  redeclare function extends isobaricExpansionCoefficient
    "Returns overall the isobaric expansion coefficient beta"
  algorithm
    beta := 1/state.T;
    annotation(Inline=true,smoothOrder=2);
  end isobaricExpansionCoefficient;

  redeclare function extends isothermalCompressibility
    "Returns overall the isothermal compressibility factor"
  algorithm
    kappa := 1.0/state.p;
    annotation(Inline=true,smoothOrder=2);
  end isothermalCompressibility;

  redeclare function extends density_derp_T
    "Returns the partial derivative of density with respect to pressure at constant temperature"
  algorithm
    ddpT := 1/(state.T*data.R_s);
    annotation(Inline=true,smoothOrder=2);
  end density_derp_T;

  redeclare function extends density_derT_p
    "Returns the partial derivative of density with respect to temperature at constant pressure"
  algorithm
    ddTp := -state.p/(state.T*state.T*data.R_s);
    annotation(Inline=true,smoothOrder=2);
  end density_derT_p;

  redeclare function extends density_derX
    "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
  algorithm
    dddX := fill(0,nX);
    annotation(Inline=true,smoothOrder=2);
  end density_derX;

  redeclare replaceable function extends dynamicViscosity "Dynamic viscosity"
  algorithm
    assert(fluidConstants[1].hasCriticalData,
    "Failed to compute dynamicViscosity: For the species \"" + mediumName + "\" no critical data is available.");
    assert(fluidConstants[1].hasDipoleMoment,
    "Failed to compute dynamicViscosity: For the species \"" + mediumName + "\" no critical data is available.");
    eta := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
                                       state.T,
                       fluidConstants[1].criticalTemperature,
                       fluidConstants[1].molarMass,
                       fluidConstants[1].criticalMolarVolume,
                       fluidConstants[1].acentricFactor,
                       fluidConstants[1].dipoleMoment);
    annotation (smoothOrder=2);
  end dynamicViscosity;

  redeclare replaceable function extends thermalConductivity
    "Thermal conductivity of gas"
  //  input IdealGases.Common.DataRecord data "Ideal gas data";
    input Integer method=Functions.methodForThermalConductivity
      "1: Eucken Method, 2: Modified Eucken Method";
  algorithm
    assert(fluidConstants[1].hasCriticalData,
    "Failed to compute thermalConductivity: For the species \"" + mediumName + "\" no critical data is available.");
    lambda := Modelica.Media.IdealGases.Common.Functions.thermalConductivityEstimate(
                                          specificHeatCapacityCp(state),
      dynamicViscosity(state), method=method,data=data);
    annotation (smoothOrder=2);
  end thermalConductivity;

  redeclare function extends molarMass "Return the molar mass of the medium"
  algorithm
    MM := data.MM;
    annotation(Inline=true,smoothOrder=2);
  end molarMass;

  function T_h "Compute temperature from specific enthalpy"
    extends Modelica.Icons.Function;
    input SpecificEnthalpy h "Specific enthalpy";
    output Temperature T "Temperature";

  protected
    function f_nonlinear "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input DataRecord data "Ideal gas data";
      input SpecificEnthalpy h "Specific enthalpy";
    algorithm
      y := Functions.h_T(data=data, T=u) - h;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(data=data, h=h), 200, 6000);
  end T_h;

  function T_ps "Compute temperature from pressure and specific entropy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    output Temperature T "Temperature";

  protected
    function f_nonlinear "Solve s(data,T) for T with given s (use only indirectly via temperature_psX)"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input DataRecord data "Ideal gas data";
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
    algorithm
      y := Functions.s0_T(data=data, T=u) - data.R_s*Modelica.Math.log(p/reference_p) - s;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(data=data, p=p, s=s), 200, 6000);
  end T_ps;

// the functions below are not strictly necessary, there are just here for compatibility reasons

  function dynamicViscosityLowPressure
    "Dynamic viscosity of low pressure gases"
    extends Modelica.Icons.Function;
    input SI.Temperature T "Gas temperature";
    input SI.Temperature Tc "Critical temperature of gas";
    input SI.MolarMass M "Molar mass of gas";
    input SI.MolarVolume Vc "Critical molar volume of gas";
    input Real w "Acentric factor of gas";
    input Modelica.Media.Interfaces.Types.DipoleMoment mu
      "Dipole moment of gas molecule";
    input Real k =  0.0 "Special correction for highly polar substances";
    output Modelica.Media.Interfaces.Types.DynamicViscosity eta
      "Dynamic viscosity of gas";
  protected
    parameter Real Const1_SI=40.785*10^(-9.5)
      "Constant in formula for eta converted to SI units";
    parameter Real Const2_SI=131.3/1000.0
      "Constant in formula for mur converted to SI units";
    Real mur=Const2_SI*mu/sqrt(Vc*Tc)
      "Dimensionless dipole moment of gas molecule";
    Real Fc=1 - 0.2756*w + 0.059035*mur^4 + k
      "Factor to account for molecular shape and polarities of gas";
    Real Tstar "Dimensionless temperature defined by equation below";
    Real Ov "Viscosity collision integral for the gas";

  algorithm
    eta := Functions.dynamicViscosityLowPressure(T,Tc,M,Vc,w,mu,k);
    annotation (smoothOrder=2,
                Documentation(info="<html>
<p>
The used formula are based on the method of Chung et al (1984, 1988) referred to in ref [1] chapter 9.
The formula 9-4.10 is the one being used. The formula is given in non-SI units, the following conversion constants were used to
transform the formula to SI units:
</p>

<ul>
<li> <strong>Const1_SI:</strong> The factor 10^(-9.5) =10^(-2.5)*1e-7 where the
     factor 10^(-2.5) originates from the conversion of g/mol->kg/mol + cm^3/mol->m^3/mol
      and the factor 1e-7 is due to conversion from microPoise->Pa.s.</li>
<li>  <strong>Const2_SI:</strong> The factor 1/3.335641e-27 = 1e-3/3.335641e-30
      where the factor 3.335641e-30 comes from debye->C.m and
      1e-3 is due to conversion from cm^3/mol->m^3/mol</li>
</ul>

<h4>References</h4>
<p>
[1] Bruce E. Poling, John E. Prausnitz, John P. O'Connell, \"The Properties of Gases and Liquids\" 5th Ed. Mc Graw Hill.
</p>

<h4>Author</h4>
<p>T. Skoglund, Lund, Sweden, 2004-08-31</p>

</html>"));
  end dynamicViscosityLowPressure;

  function thermalConductivityEstimate
    "Thermal conductivity of polyatomic gases(Eucken and Modified Eucken correlation)"
    extends Modelica.Icons.Function;
    input Modelica.Media.Interfaces.Types.SpecificHeatCapacity Cp
      "Constant pressure heat capacity";
    input Modelica.Media.Interfaces.Types.DynamicViscosity eta
      "Dynamic viscosity";
    input Integer method(min=1,max=2)=1
      "1: Eucken Method, 2: Modified Eucken Method";
    input IdealGases.Common.DataRecord data "Ideal gas data";
    output Modelica.Media.Interfaces.Types.ThermalConductivity lambda
      "Thermal conductivity [W/(m.k)]";
  algorithm
    lambda := Functions.thermalConductivityEstimate(Cp,eta,method,data);
    annotation (smoothOrder=2,
                Documentation(info="<html>
<p>
This function provides two similar methods for estimating the
thermal conductivity of polyatomic gases.
The Eucken method (input method == 1) gives good results for low temperatures,
but it tends to give an underestimated value of the thermal conductivity
(lambda) at higher temperatures.<br>
The Modified Eucken method (input method == 2) gives good results for
high-temperatures, but it tends to give an overestimated value of the
thermal conductivity (lambda) at low temperatures.
</p>
</html>"));
  end thermalConductivityEstimate;

  annotation (
    Documentation(info="<html>
<p>
This model calculates medium properties
for an ideal gas of a single substance, or for an ideal
gas consisting of several substances where the
mass fractions are fixed. Independent variables
are temperature <strong>T</strong> and pressure <strong>p</strong>.
Only density is a function of T and p. All other quantities
are solely a function of T. The properties
are valid in the range:
</p>
<blockquote><pre>
200 K &le; T &le; 6000 K
</pre></blockquote>
<p>
The following quantities are always computed:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Variable</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy h = h(T)</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy u = u(T)</td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density d = d(p,T)</td></tr>
</table>
<p>
For the other variables, see the functions in
Modelica.Media.IdealGases.Common.SingleGasNasa.
Note, dynamic viscosity and thermal conductivity are only provided
for gases that use a data record from Modelica.Media.IdealGases.FluidData.
Currently these are the following gases:
</p>
<blockquote><pre>
Ar
C2H2_vinylidene
C2H4
C2H5OH
C2H6
C3H6_propylene
C3H7OH
C3H8
C4H8_1_butene
C4H9OH
C4H10_n_butane
C5H10_1_pentene
C5H12_n_pentane
C6H6
C6H12_1_hexene
C6H14_n_heptane
C7H14_1_heptene
C8H10_ethylbenz
CH3OH
CH4
CL2
CO
CO2
F2
H2
H2O
He
N2
N2O
NH3
NO
O2
SO2
SO3
</pre></blockquote>
<p>
<strong>Sources for model and literature:</strong><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><strong>Known limits of validity:</strong><br>
The data is valid for
temperatures between 200K and 6000K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library
and adapted to the Modelica.Media package.
</p>
</html>"));
end SingleGasNasa;

partial package MixtureGasNasa
  "Medium model of a mixture of ideal gases based on NASA source"

  import Modelica.Math;
  import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

  extends Modelica.Media.Interfaces.PartialMixtureMedium(
     ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX,
     substanceNames=data[:].name,
     reducedX = false,
     singleState=false,
     reference_X=fill(1/nX,nX),
     SpecificEnthalpy(start=if referenceChoice==ReferenceEnthalpy.ZeroAt0K then 3e5 else
        if referenceChoice==ReferenceEnthalpy.UserDefined then h_offset else 0, nominal=1.0e5),
     Density(start=10, nominal=10),
     AbsolutePressure(start=10e5, nominal=10e5),
     Temperature(min=200, max=6000, start=500, nominal=500));

    redeclare record extends ThermodynamicState "Thermodynamic state variables"
    end ThermodynamicState;

//   redeclare record extends FluidConstants "Fluid constants"
//   end FluidConstants;

  constant Modelica.Media.IdealGases.Common.DataRecord[:] data
    "Data records of ideal gas substances";
    // ={Common.SingleGasesData.N2,Common.SingleGasesData.O2}

  constant Boolean excludeEnthalpyOfFormation=true
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  constant ReferenceEnthalpy referenceChoice=ReferenceEnthalpy.ZeroAt0K
    "Choice of reference enthalpy";
  constant SpecificEnthalpy h_offset=0.0
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";

//   constant FluidConstants[nX] fluidConstants
//     "Additional data needed for transport properties";
  constant MolarMass[nX] MMX=data[:].MM "Molar masses of components";
  constant Integer methodForThermalConductivity(min=1,max=2)=1;
  redeclare replaceable model extends BaseProperties(
    T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    final standardOrderComponents=true)
    "Base properties (p, d, T, h, u, R_s, MM, X, and Xi of NASA mixture gas"
  equation
    assert(T >= 200 and T <= 6000, "
Temperature T (=" + String(T) + " K = 200 K) is not in the allowed range
200 K <= T <= 6000 K
required from medium model \"" + mediumName + "\".");

    MM = molarMass(state);
    h = h_TX(T, X);
    R_s = data.R_s*X;
    u = h - R_s*T;
    d = p/(R_s*T);
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
    state.X = if fixedX then reference_X else X;
  end BaseProperties;

    redeclare function setState_pTX
    "Return thermodynamic state as function of p, T and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T,X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T, X=X) else
             ThermodynamicState(p=p,T=T, X=cat(1,X,{1-sum(X)}));
    annotation(Inline=true,smoothOrder=2);
    end setState_pTX;

    redeclare function setState_phX
    "Return thermodynamic state as function of p, h and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T_hX(h,reference_X),X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T_hX(h,X),X=X) else
             ThermodynamicState(p=p,T=T_hX(h,X), X=cat(1,X,{1-sum(X)}));
      annotation(Inline=true,smoothOrder=2);
    end setState_phX;

    redeclare function setState_psX
    "Return thermodynamic state as function of p, s and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T_psX(p,s,reference_X),X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T_psX(p,s,X),X=X) else
             ThermodynamicState(p=p,T=T_psX(p,s,X), X=cat(1,X,{1-sum(X)}));
      annotation(Inline=true,smoothOrder=2);
    end setState_psX;

    redeclare function setState_dTX
    "Return thermodynamic state as function of d, T and composition X"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == 0 then ThermodynamicState(p=d*(data.R_s*reference_X)*T,T=T,X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=d*(data.R_s*X)*T,T=T,X=X) else
             ThermodynamicState(p=d*(data.R_s*cat(1,X,{1-sum(X)}))*T,T=T, X=cat(1,X,{1-sum(X)}));
      annotation(Inline=true,smoothOrder=2);
    end setState_dTX;

      redeclare function extends setSmoothState
    "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      algorithm
        state := ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                    T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small),
                                    X=Media.Common.smoothStep(x, state_a.X, state_b.X, x_small));
        annotation(Inline=true,smoothOrder=2);
      end setSmoothState;

    redeclare function extends pressure "Return pressure of ideal gas"
    algorithm
      p := state.p;
      annotation(Inline=true,smoothOrder=2);
    end pressure;

    redeclare function extends temperature "Return temperature of ideal gas"
    algorithm
      T := state.T;
      annotation(Inline=true,smoothOrder=2);
    end temperature;

    redeclare function extends density "Return density of ideal gas"
    algorithm
      d := state.p/((state.X*data.R_s)*state.T);
      annotation(Inline = true, smoothOrder = 3);
    end density;

  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := h_TX(state.T,state.X);
    annotation(Inline=true,smoothOrder=2);
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := h_TX(state.T,state.X) - gasConstant(state)*state.T;
    annotation(Inline=true,smoothOrder=2);
  end specificInternalEnergy;

  redeclare function extends specificEntropy "Return specific entropy"
    extends Modelica.Icons.Function;
  algorithm
    s := specificEntropyOfpTX(state.p, state.T, state.X);
    annotation(Inline=true,smoothOrder=2);
  end specificEntropy;

  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := h_TX(state.T,state.X) - state.T*specificEntropy(state);
    annotation(Inline=true,smoothOrder=2);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := h_TX(state.T,state.X) - gasConstant(state)*state.T - state.T*specificEntropy(state);
    annotation(Inline=true,smoothOrder=2);
  end specificHelmholtzEnergy;

  function h_TX "Return specific enthalpy"
    import Modelica.Media.Interfaces.Choices;
     extends Modelica.Icons.Function;
     input SI.Temperature T "Temperature";
     input MassFraction X[nX]=reference_X
      "Independent Mass fractions of gas mixture";
     input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
     input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                     refChoice=referenceChoice
      "Choice of reference enthalpy";
     input SI.SpecificEnthalpy h_off=h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
     output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
  algorithm
    h :=(if fixedX then reference_X else X)*
         {Modelica.Media.IdealGases.Common.Functions.h_T(
                            data[i], T, exclEnthForm, refChoice, h_off) for i in 1:nX};
    annotation(Inline=false,smoothOrder=2);
  end h_TX;

  function h_TX_der "Return specific enthalpy derivative"
    import Modelica.Media.Interfaces.Choices;
     extends Modelica.Icons.Function;
     input SI.Temperature T "Temperature";
     input MassFraction X[nX] "Independent Mass fractions of gas mixture";
     input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
     input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                     refChoice=referenceChoice
      "Choice of reference enthalpy";
     input SI.SpecificEnthalpy h_off=h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    input Real dT "Temperature derivative";
    input Real dX[nX] "Independent mass fraction derivative";
    output Real h_der "Specific enthalpy at temperature T";
  algorithm
    h_der := if fixedX then
      dT*sum((Modelica.Media.IdealGases.Common.Functions.cp_T(
                                 data[i], T)*reference_X[i]) for i in 1:nX) else
      dT*sum((Modelica.Media.IdealGases.Common.Functions.cp_T(
                                 data[i], T)*X[i]) for i in 1:nX)+
      sum((Modelica.Media.IdealGases.Common.Functions.h_T(
                             data[i], T)*dX[i]) for i in 1:nX);
    annotation (Inline = false, smoothOrder=1);
  end h_TX_der;

  redeclare function extends gasConstant "Return gasConstant"
  algorithm
    R_s := data.R_s*state.X;
    annotation(Inline = true, smoothOrder = 3);
  end gasConstant;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
  algorithm
    cp := {Modelica.Media.IdealGases.Common.Functions.cp_T(
                              data[i], state.T) for i in 1:nX}*state.X;
    annotation(Inline=true,smoothOrder=1);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Return specific heat capacity at constant volume from temperature and gas data"
  algorithm
    cv := {Modelica.Media.IdealGases.Common.Functions.cp_T(
                              data[i], state.T) for i in 1:nX}*state.X -data.R_s*state.X;
    annotation(Inline=true, smoothOrder = 1);
  end specificHeatCapacityCv;

  function MixEntropy "Return mixing entropy of ideal gases / R"
    extends Modelica.Icons.Function;
    input SI.MoleFraction x[:] "Mole fraction of mixture";
    output Real smix "Mixing entropy contribution, divided by gas constant";
  algorithm
    smix := sum(if x[i] > Modelica.Constants.eps then -x[i]*Modelica.Math.log(x[i]) else
                     x[i] for i in 1:size(x,1));
    annotation(Inline=true,smoothOrder=2);
  end MixEntropy;

  function s_TX
    "Return temperature dependent part of the entropy, expects full entropy vector"
    extends Modelica.Icons.Function;
    input Temperature T "Temperature";
    input MassFraction[nX] X "Mass fraction";
    output SpecificEntropy s "Specific entropy";
  algorithm
    s := sum(Modelica.Media.IdealGases.Common.Functions.s0_T(
                                data[i], T)*X[i] for i in 1:size(X,1));
    annotation(Inline=true,smoothOrder=2);
  end s_TX;

  redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
    gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
    annotation(Inline=true,smoothOrder=2);
  end isentropicExponent;

  redeclare function extends velocityOfSound "Return velocity of sound"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Properties at upstream location";
  algorithm
    a := sqrt(max(0,gasConstant(state)*state.T*specificHeatCapacityCp(state)/specificHeatCapacityCv(state)));
    annotation(Inline=true,smoothOrder=2);
  end velocityOfSound;

  function isentropicEnthalpyApproximation
    "Approximate method of calculating h_is from upstream properties and downstream pressure"
    extends Modelica.Icons.Function;
    input AbsolutePressure p2 "Downstream pressure";
    input ThermodynamicState state "Thermodynamic state at upstream location";
    output SpecificEnthalpy h_is "Isentropic enthalpy";
  protected
    SpecificEnthalpy h "Specific enthalpy at upstream location";
    SpecificEnthalpy h_component[nX] "Specific enthalpy at upstream location";
    IsentropicExponent gamma =  isentropicExponent(state) "Isentropic exponent";
  protected
    MassFraction[nX] X "Complete X-vector";
  algorithm
    X := if reducedX then cat(1,state.X,{1-sum(state.X)}) else state.X;
    h_component :={Modelica.Media.IdealGases.Common.Functions.h_T(
                                     data[i], state.T, excludeEnthalpyOfFormation,
      referenceChoice, h_offset) for i in 1:nX};
    h :=h_component*X;
    h_is := h + gamma/(gamma - 1.0)*(state.T*gasConstant(state))*
      ((p2/state.p)^((gamma - 1)/gamma) - 1.0);
    annotation(smoothOrder=2);
  end isentropicEnthalpyApproximation;

  redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
    input Boolean exact = false
      "Flag whether exact or approximate version should be used";
  algorithm
    h_is := if exact then specificEnthalpy_psX(p_downstream,specificEntropy(refState),refState.X) else
           isentropicEnthalpyApproximation(p_downstream,refState);
    annotation(Inline=true,smoothOrder=2);
  end isentropicEnthalpy;

function gasMixtureViscosity
    "Return viscosities of gas mixtures at low pressures (Wilke method)"
  extends Modelica.Icons.Function;
  input MoleFraction[:] yi "Mole fractions";
  input MolarMass[size(yi,1)] M "Mole masses";
  input DynamicViscosity[size(yi,1)] eta "Pure component viscosities";
  output DynamicViscosity etam "Viscosity of the mixture";
  protected
  Real fi[size(yi,1),size(yi,1)];
algorithm
  for i in 1:size(eta,1) loop
    assert(fluidConstants[i].hasDipoleMoment,"Dipole moment for " + fluidConstants[i].chemicalFormula +
       " not known. Can not compute viscosity.");
    assert(fluidConstants[i].hasCriticalData, "Critical data for "+ fluidConstants[i].chemicalFormula +
       " not known. Can not compute viscosity.");
    for j in 1:size(eta,1) loop
      if i==1 then
        fi[i,j] := (1 + (eta[i]/eta[j])^(1/2)*(M[j]/M[i])^(1/4))^2/(8*(1 + M[i]/M[j]))^(1/2);
      elseif j<i then
          fi[i,j] := eta[i]/eta[j]*M[j]/M[i]*fi[j,i];
        else
          fi[i,j] := (1 + (eta[i]/eta[j])^(1/2)*(M[j]/M[i])^(1/4))^2/(8*(1 + M[i]/M[j]))^(1/2);
      end if;
    end for;
  end for;
  etam := sum(yi[i]*eta[i]/sum(yi[j]*fi[i,j] for j in 1:size(eta,1)) for i in 1:size(eta,1));

  annotation (smoothOrder=2,
             Documentation(info="<html>

<p>
Simplification of the kinetic theory (Chapman and Enskog theory)
approach neglecting the second-order effects.<br>
<br>
This equation has been extensively tested (Amdur and Mason, 1958;
Bromley and Wilke, 1951; Cheung, 1958; Dahler, 1959; Gandhi and Saxena,
1964; Ranz and Brodowsky, 1962; Saxena and Gambhir, 1963a; Strunk, et
al., 1964; Vanderslice, et al. 1962; Wright and Gray, 1962). In most
cases, only nonpolar mixtures were compared, and very good results
obtained. For some systems containing hydrogen as one component, less
satisfactory agreement was noted. Wilke's method predicted mixture
viscosities that were larger than experimental for the H2-N2 system,
but for H2-NH3, it underestimated the viscosities.<br>
Gururaja, et al. (1967) found that this method also overpredicted in
the H2-O2 case but was quite accurate for the H2-CO2 system.<br>
Wilke's approximation has proved reliable even for polar-polar gas
mixtures of aliphatic alcohols (Reid and Belenyessy, 1960). The
principal reservation appears to lie in those cases where Mi&gt;&gt;Mj
and etai&gt;&gt;etaj.<br>
</p>

</html>"));
end gasMixtureViscosity;

    redeclare replaceable function extends dynamicViscosity
    "Return mixture dynamic viscosity"
  protected
      DynamicViscosity[nX] etaX "Component dynamic viscosities";
    algorithm
      for i in 1:nX loop
    etaX[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
                                                         state.T,
                       fluidConstants[i].criticalTemperature,
                       fluidConstants[i].molarMass,
                       fluidConstants[i].criticalMolarVolume,
                       fluidConstants[i].acentricFactor,
                       fluidConstants[i].dipoleMoment);
      end for;
      eta := gasMixtureViscosity(massToMoleFractions(state.X,
                             fluidConstants[:].molarMass),
                 fluidConstants[:].molarMass,
                 etaX);
      annotation (smoothOrder=2);
    end dynamicViscosity;

  function mixtureViscosityChung
    "Return the viscosity of gas mixtures without access to component viscosities (Chung, et. al. rules)"
  extends Modelica.Icons.Function;

    input Temperature T "Temperature";
    input Temperature[nX] Tc "Critical temperatures";
    input MolarVolume[nX] Vcrit "Critical volumes (m3/mol)";
    input Real[nX] w "Acentric factors";
    input Real[nX] mu "Dipole moments (debyes)";
    input MolarMass[nX] MolecularWeights "Molecular weights (kg/mol)";
    input MoleFraction[nX] y "Molar Fractions";
    input Real[nX] kappa =  zeros(nX) "Association Factors";
    output DynamicViscosity etaMixture "Mixture viscosity (Pa.s)";
  protected
  constant Real[size(y,1)] Vc =  Vcrit*1000000 "Critical volumes (cm3/mol)";
  constant Real[size(y,1)] M =  MolecularWeights*1000
      "Molecular weights (g/mol)";
  Integer n = size(y,1) "Number of mixed elements";
  Real sigmam3 "Mixture sigma3 in Angstrom";
  Real sigma[size(y,1),size(y,1)];
  Real edivkm;
  Real edivk[size(y,1),size(y,1)];
  Real Mm;
  Real Mij[size(y,1),size(y,1)];
  Real wm "Acentric factor";
  Real wij[size(y,1),size(y,1)];
  Real kappam
      "Correlation for highly polar substances such as alcohols and acids";
  Real kappaij[size(y,1),size(y,1)];
  Real mum;
  Real Vcm;
  Real Tcm;
  Real murm "Dimensionless dipole moment of the mixture";
  Real Fcm "Factor to correct for shape and polarity";
  Real omegav;
  Real Tmstar;
  Real etam "Mixture viscosity in microP";
  algorithm
  //combining rules
  for i in 1:n loop
    for j in 1:n loop
      Mij[i,j] := 2*M[i]*M[j]/(M[i]+M[j]);
      if i==j then
        sigma[i,j] := 0.809*Vc[i]^(1/3);
        edivk[i,j] := Tc[i]/1.2593;
        wij[i,j] := w[i];
        kappaij[i,j] := kappa[i];
      else
        sigma[i,j] := (0.809*Vc[i]^(1/3)*0.809*Vc[j]^(1/3))^(1/2);
        edivk[i,j] := (Tc[i]/1.2593*Tc[j]/1.2593)^(1/2);
        wij[i,j] := (w[i] + w[j])/2;
        kappaij[i,j] := (kappa[i]*kappa[j])^(1/2);
      end if;
    end for;
  end for;
  //mixing rules
  sigmam3 := (sum(sum(y[i]*y[j]*sigma[i,j]^3 for j in 1:n) for i in 1:n));
  //(epsilon/k)m
  edivkm := (sum(sum(y[i]*y[j]*edivk[i,j]*sigma[i,j]^3 for j in 1:n) for i in 1:n))/sigmam3;
  Mm := ((sum(sum(y[i]*y[j]*edivk[i,j]*sigma[i,j]^2*Mij[i,j]^(1/2) for j in 1:n) for i in 1:n))/(edivkm*sigmam3^(2/3)))^2;
  wm := (sum(sum(y[i]*y[j]*wij[i,j]*sigma[i,j]^3 for j in 1:n) for i in 1:n))/sigmam3;
  mum := (sigmam3*(sum(sum(y[i]*y[j]*mu[i]^2*mu[j]^2/sigma[i,j]^3 for j in 1:n) for i in 1:n)))^(1/4);
  Vcm := sigmam3/(0.809)^3 "eq. (4)";
  Tcm := 1.2593*edivkm "eq. (5)";
  murm := 131.3*mum/(Vcm*Tcm)^(1/2) "eq. (8)";
  kappam := (sigmam3*(sum(sum(y[i]*y[j]*kappaij[i,j] for j in 1:n) for i in 1:n)));
  Fcm := 1 - 0.275*wm + 0.059035*murm^4 + kappam "eq. (7)";
  Tmstar := T/edivkm "eq. (3)";
  omegav := 1.16145*(Tmstar)^(-0.14874) + 0.52487*Modelica.Math.exp(-0.77320*Tmstar) + 2.16178*Modelica.Math.exp(-2.43787*Tmstar) "eq. (2)";
  etam := 26.69*Fcm*(Mm*T)^(1/2)/(sigmam3^(2/3)*omegav) "eq. (1)";
  etaMixture := etam*1e-7; // conversion from microPoise->Pa.s

    annotation (smoothOrder=2,
              Documentation(info="<html>

<p>
Equation to estimate the viscosity of gas mixtures at low pressures.<br>
It is a simplification of an extension of the rigorous kinetic theory
of Chapman and Enskog to determine the viscosity of multicomponent
mixtures, at low pressures and with a factor to correct for molecule
shape and polarity.
</p>

<p>
The input argument Kappa is a special correction for highly polar substances such as
alcohols and acids.<br>
Values of kappa for a few such materials:
</p>

<table style=\"text-align: left; width: 302px; height: 200px;\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody>
<tr>
<td style=\"vertical-align: top;\">Compound<br>
</td>
<td style=\"vertical-align: top; text-align: center;\">Kappa<br>
</td>
<td style=\"vertical-align: top;\">Compound<br>
</td>
<td style=\"vertical-align: top;\">Kappa<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">Methanol<br>
</td>
<td style=\"vertical-align: top;\">0.215<br>
</td>
<td style=\"vertical-align: top;\">n-Pentanol<br>
</td>
<td style=\"vertical-align: top;\">0.122<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">Ethanol<br>
</td>
<td style=\"vertical-align: top;\">0.175<br>
</td>
<td style=\"vertical-align: top;\">n-Hexanol<br>
</td>
<td style=\"vertical-align: top;\">0.114<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">n-Propanol<br>
</td>
<td style=\"vertical-align: top;\">0.143<br>
</td>
<td style=\"vertical-align: top;\">n-Heptanol<br>
</td>
<td style=\"vertical-align: top;\">0.109<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">i-Propanol<br>
</td>
<td style=\"vertical-align: top;\">0.143<br>
</td>
<td style=\"vertical-align: top;\">Acetic Acid<br>
</td>
<td style=\"vertical-align: top;\">0.0916<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">n-Butanol<br>
</td>
<td style=\"vertical-align: top;\">0.132<br>
</td>
<td style=\"vertical-align: top;\">Water<br>
</td>
<td style=\"vertical-align: top;\">0.076<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">i-Butanol<br>
</td>
<td style=\"vertical-align: top;\">0.132</td>
<td style=\"vertical-align: top;\"><br>
</td>
<td style=\"vertical-align: top;\"><br>
</td>
</tr>
</tbody>
</table>
<p>
Chung, et al. (1984) suggest that for other alcohols not shown in the
table:<br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp; kappa = 0.0682 + 4.704*[(number of -OH
groups)]/[molecular weight]<br>
<br>
<span style=\"font-weight: normal;\">S.I. units relation for the
debyes:&nbsp;</span><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 1 debye = 3.162e-25 (J.m^3)^(1/2)<br>
</p>
<h4>References</h4>
<p>
[1] THE PROPERTIES OF GASES AND LIQUIDS, Fifth Edition,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; Bruce E. Poling, John M.
Prausnitz, John P. O'Connell.<br>
[2] Chung, T.-H., M. Ajlan, L. L. Lee, and K. E. Starling: Ind. Eng.
Chem. Res., 27: 671 (1988).<br>
[3] Chung, T.-H., L. L. Lee, and K. E. Starling; Ing. Eng. Chem.
Fundam., 23: 3 ()1984).<br>
</p>
</html>"));
  end mixtureViscosityChung;

function lowPressureThermalConductivity
    "Return thermal conductivities of low-pressure gas mixtures (Mason and Saxena Modification)"
  extends Modelica.Icons.Function;
  input MoleFraction[:] y "Mole fraction of the components in the gas mixture";
  input Temperature T "Temperature";
  input Temperature[size(y,1)] Tc "Critical temperatures";
  input AbsolutePressure[size(y,1)] Pc "Critical pressures";
  input MolarMass[size(y,1)] M "Molecular weights";
  input ThermalConductivity[size(y,1)] lambda
      "Thermal conductivities of the pure gases";
  output ThermalConductivity lambdam "Thermal conductivity of the gas mixture";
  protected
  MolarMass[size(y,1)] gamma;
  Real[size(y,1)] Tr "Reduced temperature";
  Real[size(y,1),size(y,1)] A "Mason and Saxena Modification";
  constant Real epsilon =  1.0 "Numerical constant near unity";
algorithm
  for i in 1:size(y,1) loop
    gamma[i] := 210*(Tc[i]*M[i]^3/Pc[i]^4)^(1/6);
    Tr[i] := T/Tc[i];
  end for;
  for i in 1:size(y,1) loop
    for j in 1:size(y,1) loop
      A[i,j] := epsilon*(1 + (gamma[j]*(Math.exp(0.0464*Tr[i]) - Math.exp(-0.2412*Tr[i]))/
      (gamma[i]*(Math.exp(0.0464*Tr[j]) - Math.exp(-0.2412*Tr[j]))))^(1/2)*(M[i]/M[j])^(1/4))^2/
      (8*(1 + M[i]/M[j]))^(1/2);
    end for;
  end for;
  lambdam := sum(y[i]*lambda[i]/(sum(y[j]*A[i,j] for j in 1:size(y,1))) for i in 1:size(y,1));

  annotation (smoothOrder=2,
              Documentation(info="<html>

<p>
This function applies the Masson and Saxena modification of the
Wassiljewa Equation for the thermal conductivity for gas mixtures of
n elements at low pressure.
</p>

<p>
For nonpolar gas mixtures errors will generally be less than 3 to 4%.
For mixtures of nonpolar-polar and polar-polar gases, errors greater
than 5 to 8% may be expected. For mixtures in which the sizes and
polarities of the constituent molecules are not greatly different, the
thermal conductivity can be estimated satisfactorily by a mole fraction
average of the pure component conductivities.
</p>

</html>"));
end lowPressureThermalConductivity;

    redeclare replaceable function extends thermalConductivity
    "Return thermal conductivity for low pressure gas mixtures"
      input Integer method=methodForThermalConductivity
      "Method to compute single component thermal conductivity";
  protected
      ThermalConductivity[nX] lambdaX "Component thermal conductivities";
      DynamicViscosity[nX] eta "Component thermal dynamic viscosities";
      SpecificHeatCapacity[nX] cp "Component heat capacity";
    algorithm
      for i in 1:nX loop
    assert(fluidConstants[i].hasCriticalData, "Critical data for "+ fluidConstants[i].chemicalFormula +
       " not known. Can not compute thermal conductivity.");
    eta[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
                                                        state.T,
                       fluidConstants[i].criticalTemperature,
                       fluidConstants[i].molarMass,
                       fluidConstants[i].criticalMolarVolume,
                       fluidConstants[i].acentricFactor,
                       fluidConstants[i].dipoleMoment);
    cp[i] := Modelica.Media.IdealGases.Common.Functions.cp_T(
                                data[i],state.T);
    lambdaX[i] :=Modelica.Media.IdealGases.Common.Functions.thermalConductivityEstimate(
                                                           Cp=cp[i], eta=
          eta[i], method=method,data=data[i]);
      end for;
      lambda := lowPressureThermalConductivity(massToMoleFractions(state.X,
                                   fluidConstants[:].molarMass),
                           state.T,
                           fluidConstants[:].criticalTemperature,
                           fluidConstants[:].criticalPressure,
                           fluidConstants[:].molarMass,
                           lambdaX);
      annotation (smoothOrder=2);
    end thermalConductivity;

  redeclare function extends isobaricExpansionCoefficient
    "Return isobaric expansion coefficient beta"
  algorithm
    beta := 1/state.T;
    annotation(Inline=true,smoothOrder=2);
  end isobaricExpansionCoefficient;

  redeclare function extends isothermalCompressibility
    "Return isothermal compressibility factor"
  algorithm
    kappa := 1.0/state.p;
    annotation(Inline=true,smoothOrder=2);
  end isothermalCompressibility;

  redeclare function extends density_derp_T
    "Return density derivative by pressure at constant temperature"
  algorithm
    ddpT := 1/(state.T*gasConstant(state));
    annotation(Inline=true,smoothOrder=2);
  end density_derp_T;

  redeclare function extends density_derT_p
    "Return density derivative by temperature at constant pressure"
  algorithm
    ddTp := -state.p/(state.T*state.T*gasConstant(state));
    annotation(Inline=true,smoothOrder=2);
  end density_derT_p;

  redeclare function density_derX "Return density derivative by mass fraction"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
  algorithm
    dddX := {-state.p/(state.T*gasConstant(state))*molarMass(state)/data[
      i].MM for i in 1:nX};
    annotation(Inline=true,smoothOrder=2);
  end density_derX;

  redeclare function extends molarMass "Return molar mass of mixture"
  algorithm
    MM := 1/sum(state.X[j]/data[j].MM for j in 1:size(state.X, 1));
    annotation(Inline=true,smoothOrder=2);
  end molarMass;

  function T_hX "Return temperature from specific enthalpy and mass fraction"
    extends Modelica.Icons.Function;
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction[nX] X "Mass fractions of composition";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                     refChoice=referenceChoice
      "Choice of reference enthalpy";
    input SI.SpecificEnthalpy h_off=h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output Temperature T "Temperature";

  protected
    function f_nonlinear "Solve h_TX(T,X) for T with given h"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction[nX] X "Mass fractions of composition";
      input Boolean exclEnthForm "If true, enthalpy of formation Hf is not included in specific enthalpy h";
      input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy refChoice "Choice of reference enthalpy";
      input SpecificEnthalpy h_off "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    algorithm
      y := h_TX(T=u, X=X, exclEnthForm=exclEnthForm, refChoice=refChoice, h_off=h_off) - h;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(h=h, X=X, exclEnthForm=exclEnthForm, refChoice=refChoice, h_off=h_off), 200, 6000);
    annotation(inverse(h = h_TX(T,X,exclEnthForm,refChoice,h_off)));
  end T_hX;

  function T_psX
    "Return temperature from pressure, specific entropy and mass fraction"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input MassFraction[nX] X "Mass fractions of composition";
    output Temperature T "Temperature";

  protected
    function f_nonlinear "Solve specificEntropyOfpTX(p,T,X) for T with given s"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction[nX] X "Mass fractions of composition";
    algorithm
      y := specificEntropyOfpTX(p=p, T=u, X=X) - s;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(p=p, s=s, X=X), 200, 6000);
    annotation(inverse(s = specificEntropyOfpTX(p,T,X)));
  end T_psX;

  protected
    function specificEntropyOfpTX
      "Return specific entropy from pressure, temperature and mass fractions"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction[nX] X "Mass fractions of composition";
      output SpecificEntropy s "Specific entropy";
    protected
      Real[nX] Y(each unit="mol/mol") = massToMoleFractions(X, data.MM) "Molar fractions";
    algorithm
      s := s_TX(T, X) - sum(X[i]*Modelica.Constants.R/MMX[i]*
        (if X[i] < Modelica.Constants.eps then Y[i] else
        Modelica.Math.log(Y[i]*p/reference_p)) for i in 1:nX);
      annotation(Inline=true,smoothOrder=2);
    end specificEntropyOfpTX;

  annotation (Documentation(info="<html>
<p>
This model calculates the medium properties for single component ideal gases.
</p>
<p>
<strong>Sources for model and literature:</strong><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><strong>Known limits of validity:</strong><br>
The data is valid for
temperatures between 200 K and 6000 K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000 K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library.
It has been developed by Hubertus Tummescheit.
</p>
</html>"));
end MixtureGasNasa;
annotation (Documentation(info="<html>
</html>"));
end Common;
