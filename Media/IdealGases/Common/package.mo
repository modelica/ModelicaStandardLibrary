package Common "Common packages and data for the ideal gas models"
extends Modelica.Icons.Library;


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
  SI.SpecificHeatCapacity R "Gas constant";
  annotation (Documentation(info="<HTML>
<p>
This data record contains the coefficients for the
ideal gas equations according to:
</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA
  report TP-2002-211556</p>
</blockquote>
<p>
The equations have the following structure:
</p>
<IMG SRC=\"../Images/Media/IdealGases/singleEquations.png\">
<p>
The polynomials for h(T) and s0(T) are derived via integration from the one for cp(T)  and contain the integration constants b1, b2 that define the reference specific enthalpy and entropy. For entropy differences the reference pressure p0 is arbitrary, but not for absolute entropies. It is chosen as 1 standard atmosphere (101325 Pa).
</p>
<p>
For most gases, the region of validity is from 200 K to 6000 K.
The equations are splitted into two regions that are separated
by Tlimit (usually 1000 K). In both regions the gas is described
by the data above. The two branches are continuous and in most
gases also differentiable at Tlimit.
</p>
</HTML>"));
end DataRecord;


partial package SingleGasNasa 
  "Medium model of an ideal gas based on NASA source" 
  
  annotation (
    Documentation(info="<HTML>
<p>
This model calculates medium properties
for an ideal gas of a single substance, or for an ideal
gas consisting of several substances where the
mass fractions are fixed. Independent variables
are temperature <b>T</b> and pressure <b>p</b>.
Only density is a function of T and p. All other quantities
are solely a function of T. The properties
are valid in the range:
</p>
<pre>
   200 K &le; T &le; 6000 K
</pre>
<p>
The following quantities are always computed:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy h = h(T)</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy u = u(T)</b></td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density d = d(p,T)</td></tr>
</table>
<p>
The following variables are only computed, if the
corresponding function is called:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Function</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>s</td>
      <td>J/(kg.K)</td>
      <td>specificEntropy(medium)</td>
      <td>specific entropy s = s(p,T)</td></tr>
  <tr><td>cp</td>
      <td>J/(kg.K)</td>
      <td>heatCapacity_cp(medium)</td>
      <td>specific heat capacity at constant pressure cp = heatCapacity_cp(T)</td></tr>
  <tr><td>cv</td>
      <td>J/(kg.K)</td>
      <td>heatCapacity_cv(medium)</td>
      <td>specific heat capacity at constant density cv = heatCapacity_cv(T)</td></tr>
  <tr><td>kappa</td>
      <td>1</td>
      <td>isentropicExponent(medium)</td>
      <td>isentropic exponent kappa = kappa(T)</td></tr>
  <tr><td>a</td>
      <td>m/s</td>
      <td>velocityOfSound(medium)</td>
      <td>velocity of sound a = a(T)</td></tr>
</table>
<p>
<b>Sources for model and literature:</b><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><b>Known limits of validity:</p></br>
The data is valid for
temperatures between 200K and 6000K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library
and adapted to the Modelica.Media package.
</p>
</HTML>"),
    Icon,
    Diagram);
  
  extends Interfaces.PartialPureSubstance(
     mediumName=data.name,
     substanceNames={data.name},
     final reducedX=true,
     singleState=false,
     Temperature(min=200, max=6000, start=500, nominal=500),
     SpecificEnthalpy(start=if referenceChoice==ReferenceEnthalpy.ZeroAt0K then data.H0 else 
        if referenceChoice==ReferenceEnthalpy.UserDefined then h_offset else 0, nominal=1.0e5),
     Density(start=10, nominal=10),
     AbsolutePressure(start=10e5, nominal=10e5));
  
  redeclare replaceable record extends ThermodynamicState 
    "thermodynamic state variables for ideal gases" 
    AbsolutePressure p "Absolute pressure of medium";
    Temperature T "Temperature of medium";
  end ThermodynamicState;
  
  import SI = Modelica.SIunits;
  import Modelica.Math;
  import Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEnthalpy;
  
  constant Boolean excludeEnthalpyOfFormation=true 
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  constant ReferenceEnthalpy.Temp referenceChoice=Choices.
        ReferenceEnthalpy.ZeroAt0K "Choice of reference enthalpy";
  constant SpecificEnthalpy h_offset=0.0 
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  
  constant IdealGases.Common.DataRecord data 
    "Data record of ideal gas substance";
  
  replaceable constant FluidConstants fluidConstants 
    "constant data for the fluid";
  
  redeclare model extends BaseProperties(
   T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
   p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)) 
    "Base properties of ideal gas medium" 
   annotation(structurallyIncomplete);
  equation 
    assert(T >= 200 and T <= 6000, "
Temperature T (= " + String(T) + " K) is not in the allowed range
200 K <= T <= 6000 K required from medium model \"" + mediumName + "\".
");
    MM = data.MM;
    R = data.R;
    h = h_T(data, T, excludeEnthalpyOfFormation, referenceChoice, h_offset);
    u = h - R*T;
    
    // Has to be written in the form d=f(p,T) in order that static
    // state selection for p and T is possible
    d = p/(R*T);
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
  end BaseProperties;
  
  function density "return density of ideal gas" 
    extends Modelica.Icons.Function;
    input ThermodynamicState state "thermodynamic state";
    output Density d "density";
  algorithm 
    d := state.p/(data.R*state.T);
  end density;
  
  redeclare function extends heatCapacity_cp 
    "Return specific heat capacity at constant pressure" 
  algorithm 
    cp := cp_T(data, state.T);
  end heatCapacity_cp;
  
  redeclare function extends heatCapacity_cv 
    "Compute specific heat capacity at constant volume from temperature and gas data" 
  algorithm 
    cv := cp_T(data, state.T) - data.R;
  end heatCapacity_cv;
  
  redeclare function extends isentropicExponent "Return isentropic exponent" 
  algorithm 
    gamma := heatCapacity_cp(state)/heatCapacity_cv(state);
  end isentropicExponent;
  
  redeclare function extends specificEntropy "Return specific entropy" 
    extends Modelica.Icons.Function;
  algorithm 
    s := s0_T(data, state.T) - data.R*Modelica.Math.log(state.p/reference_p);
  end specificEntropy;
  
  redeclare function extends velocityOfSound "Return velocity of sound" 
    extends Modelica.Icons.Function;
  algorithm 
    a := sqrt(data.R*state.T*cp_T(data, state.T)/heatCapacity_cv(state));
  end velocityOfSound;
  
  function isentropicEnthalpyApproximation 
    "approximate method of calculating h_is from upstream properties and downstream pressure" 
    extends Modelica.Icons.Function;
    input SI.Pressure p2 "downstream pressure";
    input ThermodynamicState state "properties at upstream location";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input ReferenceEnthalpy.Temp refChoice=referenceChoice 
      "Choice of reference enthalpy";
    input SpecificEnthalpy h_off=h_offset 
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h_is "isentropic enthalpy";
  protected 
    IsentropicExponent gamma =  isentropicExponent(state) "Isentropic exponent";
  algorithm 
    h_is := h_T(data,state.T,exclEnthForm,refChoice,h_off) +
      gamma/(gamma - 1.0)*state.p/density(state)*((p2/state.p)^((gamma - 1)/gamma) - 1.0);
  end isentropicEnthalpyApproximation;
  
  redeclare function extends isentropicEnthalpy "Return isentropic enthalpy" 
  input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input ReferenceEnthalpy.Temp refChoice=referenceChoice 
      "Choice of reference enthalpy";
  input SpecificEnthalpy h_off=h_offset 
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  algorithm 
    h_is := isentropicEnthalpyApproximation(p_downstream,refState,exclEnthForm,refChoice,h_off);
  end isentropicEnthalpy;
  
  redeclare function extends isobaricExpansionCoefficient 
    "Returns overall the isobaric expansion coefficient beta" 
  algorithm 
    beta := 1/state.T;
  end isobaricExpansionCoefficient;
  
  redeclare function extends isothermalCompressibility 
    "Returns overall the isothermal compressibility factor" 
  algorithm 
    kappa := 1.0/state.p;
  end isothermalCompressibility;
  
  redeclare function extends density_derp_T 
    "density derivative by temperature at constant pressure" 
  algorithm 
    ddpT := 1/(state.p*data.R);
  end density_derp_T;
  
  redeclare function extends density_derT_p 
    "density derivative by temperature at constant pressure" 
  algorithm 
    ddTp := -state.p/(state.T*state.T*data.R);
  end density_derT_p;
  
  function cp_T 
    "Compute specific heat capacity at constant pressure from temperature and gas data" 
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    output SI.SpecificHeatCapacity cp "Specific heat capacity at temperature T";
    annotation (InlineNoEvent=false);
  algorithm 
    cp := smooth(0,if T < data.Tlimit then data.R*(1/(T*T)*(data.alow[1] + T*(
      data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T
      *(data.alow[6] + data.alow[7]*T))))))) else data.R*(1/(T*T)*(data.ahigh[1]
       + T*(data.ahigh[2] + T*(1.*data.ahigh[3] + T*(data.ahigh[4] + T*(data.
      ahigh[5] + T*(data.ahigh[6] + data.ahigh[7]*T))))))));
  end cp_T;
  
  function cp_Tlow 
    "Compute specific heat capacity at constant pressure, low T region" 
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    output SI.SpecificHeatCapacity cp "Specific heat capacity at temperature T";
    //    annotation (Inline=false,
    //      derivative(noDerivative=data) = cp_Tlow_der);
  algorithm 
    cp := data.R*(1/(T*T)*(data.alow[1] + T*(
      data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T
      *(data.alow[6] + data.alow[7]*T)))))));
  end cp_Tlow;
  
  function cp_Tlow_der 
    "Compute specific heat capacity at constant pressure, low T region" 
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input SI.Temperature dT "Temperature derivative";
    output SI.SpecificHeatCapacity cp_der 
      "Derivative of specific heat capacity";
  algorithm 
    cp_der := dT*data.R/(T*T*T)*(-2*data.alow[1] + T*(
      -data.alow[2] + T*T*(data.alow[4] + T*(2.*data.alow[5] + T
      *(3.*data.alow[6] + 4.*data.alow[7]*T)))));
  end cp_Tlow_der;
  
  function h_T "Compute specific enthalpy from temperature and gas data; reference is decided by the 
    refChoice input, or by the referenceChoice package constant by default" 
    import Modelica.Media.Interfaces.PartialMedium.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input Choices.ReferenceEnthalpy.Temp refChoice=referenceChoice 
      "Choice of reference enthalpy";
    input SI.SpecificEnthalpy h_off=h_offset 
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
    annotation (InlineNoEvent=false, Inline = false);
  algorithm 
    h := smooth(0,(if T < data.Tlimit then data.R*((-data.alow[1] + T*(data.
      blow[1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.
      alow[4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))
      /T) else data.R*((-data.ahigh[1] + T*(data.bhigh[1] + data.ahigh[2]*
      Math.log(T) + T*(1.*data.ahigh[3] + T*(0.5*data.ahigh[4] + T*(1/3*data.
      ahigh[5] + T*(0.25*data.ahigh[6] + 0.2*data.ahigh[7]*T))))))/T)) + (if 
      exclEnthForm then -data.Hf else 0.0) + (if (refChoice
       == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0 else 0.0) + (if 
      refChoice == Choices.ReferenceEnthalpy.UserDefined then h_off else 
            0.0));
  end h_T;
  
  function h_Tlow "Compute specific enthalpy, low T region; reference is decided by the 
    refChoice input, or by the referenceChoice package constant by default" 
    import Modelica.Media.Interfaces.PartialMedium.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input Choices.ReferenceEnthalpy.Temp refChoice=referenceChoice 
      "Choice of reference enthalpy";
    input SI.SpecificEnthalpy h_off=h_offset 
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
    //    annotation (Inline=false,
    //      derivative(noDerivative=data,
    //                 noDerivative=excludeEnthalpyOfFormation,
    //                 noDerivative=referenceChoice,
    //                 noDerivative=h_offset) = h_Tlow_der);
  algorithm 
    h := data.R*((-data.alow[1] + T*(data.
      blow[1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.
      alow[4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))
      /T) + (if 
      exclEnthForm then -data.Hf else 0.0) + (if (refChoice
       == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0 else 0.0) + (if 
      refChoice == Choices.ReferenceEnthalpy.UserDefined then h_off else 
            0.0);
  end h_Tlow;
  
  function h_Tlow_der "Compute specific enthalpy, low T region; reference is decided by the 
    refChoice input, or by the referenceChoice package constant by default" 
    import Modelica.Media.Interfaces.PartialMedium.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input Choices.ReferenceEnthalpy.Temp refChoice=referenceChoice 
      "Choice of reference enthalpy";
    input SI.SpecificEnthalpy h_off=h_offset 
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    input SI.Temperature dT "Temperature derivative";
    output SI.SpecificEnthalpy h_der "Specific enthalpy at temperature T";
  algorithm 
    h_der := dT*cp_Tlow(data,T);
  end h_Tlow_der;
  
  function s0_T "Compute specific entropy from temperature and gas data" 
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    output SI.SpecificEntropy s "Specific entropy at temperature T";
    //    annotation (InlineNoEvent=false);
  algorithm 
    s := noEvent(if T < data.Tlimit then data.R*(data.blow[2] - 0.5*data.alow[
      1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(noEvent(abs(T))) + T*(
      data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
      7]*T)))) else data.R*(data.bhigh[2] - 0.5*data.ahigh[1]/(T*T) - data.
      ahigh[2]/T + data.ahigh[3]*Math.log(noEvent(abs(T))) + T*(data.ahigh[4]
       + T*(0.5*data.ahigh[5] + T*(1/3*data.ahigh[6] + 0.25*data.ahigh[7]*T)))));
  end s0_T;
  
  function s0_Tlow "Compute specific entropy, low T region" 
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    output SI.SpecificEntropy s "Specific entropy at temperature T";
    //    annotation (InlineNoEvent=false);
  algorithm 
    s := data.R*(data.blow[2] - 0.5*data.alow[
      1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(noEvent(abs(T))) + T*(
      data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
      7]*T))));
  end s0_Tlow;
  
  function dynamicViscosityLowPressure 
    "Dynamic viscosity of low pressure gases" 
    extends Modelica.Icons.Function;
    input SI.Temp_K T "Gas temperature";
    input SI.Temp_K Tc "Critical temperature of gas";
    input SI.MolarMass M "Molar mass of gas";
    input SI.MolarVolume Vc "Critical molar volume of gas";
    input Real w "Acentric factor of gas";
    input SI.ElectricDipoleMomentOfMolecule mu "Dipole moment of gas molecule";
    input Real k =  0.0 "Special correction for highly polar substances";
    output SI.DynamicViscosity eta "Dynamic viscosity of gas";
  protected 
    parameter Real Const1_SI=40.785*10^(-9.5) 
      "Constant in formula for eta converted to SI units";
    parameter Real Const2_SI=131.3/3.335641e-27 
      "Constant in formula for mur converted to SI units";
    parameter Real mur=Const2_SI*mu/sqrt(Vc*Tc) 
      "Dimensionless dipole moment of gas molecule";
    parameter Real Fc=1 - 0.2756*w + 0.059035*mur^4 + k 
      "Factor to account for molecular shape and polarities of gas";
    Real Tstar "Dimensionless temperature defined by equation below";
    Real Ov "Viscosity collision integral for the gas";
    
    annotation (Documentation(info="<html>
<body>
<h3>Function that calculates the dynamic viscosity of low pressure gases</h3>
<p>
The used formula are based on the method of Chung et al (1984, 1988) referred to in ref [1] chapter 9.
The formula 9-4.10 is the one being used. The Formula is given in non-SI units, the follwong onversion constants were used to
transform the formula to SI units:
<ul>
<b>Const1_SI:</b> The factor 10^(-9.5) =10^(-2.5)*1e-7 where the factor 10^(-2.5) originates from the conversion of g/mol->kg/mol + cm^3/mol->m^3/mol
 and the factor 1e-7 is due to conversionfrom microPoise->Pa.s.
<b>Const2_SI:</b> The factor 1/3.335641e-27 = 1e-3/3.335641e-30 where the factor 3.335641e-30 comes from debye->C.m and
1e-3 is due to conversion from cm^3/mol->m^3/mol
</ul>
</p>
<h4>References:</h4>
<p>
[1] Bruce E. Poling, John E. Prausnitz, John P. O'Connell, \"The Properties of Gases and Liquids\" 5th Ed. Mc Graw Hill.
</p>
<h4>Authors</h4>
<p>T. Skoglund, Lund, Sweden, 2004-08-31
</body>
</html>"));
  algorithm 
    Tstar := 1.2593*T/Tc;
    Ov := 1.16145*Tstar^(-0.14874) + 0.52487*exp(-0.7732*Tstar) + 2.16178*exp(-2.43787
      *Tstar);
    eta := Const1_SI*Fc*sqrt(M*T)/(Vc^(2/3)*Ov);
  end dynamicViscosityLowPressure;
  
  redeclare replaceable function extends dynamicViscosity "dynamic viscosity" 
  algorithm 
    eta := dynamicViscosityLowPressure(state.T,
                       fluidConstants.criticalTemperature,
                       fluidConstants.molarMass,
                       fluidConstants.criticalMolarVolume,
                       fluidConstants.acentricFactor,
                       fluidConstants.dipoleMoment);
  end dynamicViscosity;
  
  function ThermalConductivityEstimate 
    "thermal conductivity estimation function" 
    extends Modelica.Icons.Function;
    input SpecificHeatCapacity Cp "constant pressure heat capacity";
    input DynamicViscosity eta "viscosity";
    input Integer method=1 "1: Eucken Method, 2: Modified Eucken Method";
    output ThermalConductivity lambda "thermal conductivity [W/(m.k)]";
  algorithm 
    lambda := if method == 1 then eta*(Cp - data.R + (9/4)*data.R) else eta*(Cp
       - data.R)*(1.32 + 1.77/((Cp/Modelica.Constants.R) - 1.0));
    annotation (Documentation(info="<html>
           <body>
           <h4>Thermal conductivities of polyatomic gases. Eucken and Modified Eucken correlation for
           polyatomic gases.</h4>
           This function provides two similar methods for estimating the thermal conductivity of polyatomic gases.
           The Eucken method (input method == 1) gives good results for low temperatures, but it tends to
           give an underestimated value of the thermal conductivity (lambda) at higher temperatures.<br>
           The Modified Eucken method (input method == 2) gives good results for high-temperatures, but it tends to
           give an overestimated value of the thermal conductivity (lambda) at low
           temperatures.<br>
           inputs: <br>
           &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Cp \"constant pressure heat
           capacity\"<br>
           &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; M \"molecular weight\"<br>
           &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; eta \"viscosity\"<br>
           output:<br>
           &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; lambda \"thermal
           conductivity [W/(m.k)]\"<br>
           <br>
           </body>
           </html>"));
  end ThermalConductivityEstimate;
  
  redeclare function extends thermalConductivity "thermal conductivity of gas" 
    input Integer method=1 "1: Eucken Method, 2: Modified Eucken Method";
  algorithm 
    lambda := ThermalConductivityEstimate(heatCapacity_cp(state),
      dynamicViscosity(state), method=method);
  end thermalConductivity;
  
  redeclare function extends molarMass "return the molar mass of the medium" 
  algorithm 
    MM := data.MM;
  end molarMass;
end SingleGasNasa;


partial package MixtureGasNasa 
  "Medium model of a mixture of ideal gases based on NASA source" 
  
  annotation (Documentation(info="<HTML>
<p>
This model calculates the medium properties for single component ideal gases.
</p>
<p>
<b>Sources for model and literature:</b><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><b>Known limits of validity:</p></br>
The data is valid for
temperatures between 200 K and 6000 K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000 K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library.
It has been developed by Hubertus Tummescheit.
</p>
</HTML>"), Icon);
  
  import Modelica.Math;
  import Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEnthalpy;
  
  extends Modelica.Media.Interfaces.PartialMixtureMedium(
     substanceNames=data[:].name,
     final reducedX = false,
     singleState=false,
     reference_X=fill(1/nX,nX),
     SpecificEnthalpy(start=if referenceChoice==ReferenceEnthalpy.ZeroAt0K then 3e5 else 
        if referenceChoice==ReferenceEnthalpy.UserDefined then h_offset else 0, nominal=1.0e5),
     Density(start=10, nominal=10),
     AbsolutePressure(start=10e5, nominal=10e5),
     Temperature(start=500, nominal=500));
  
  constant Modelica.Media.IdealGases.Common.DataRecord[:] data 
    "Data records of ideal gas substances";
    // ={Common.SingleGasesData.N2,Common.SingleGasesData.O2}
  
  constant Boolean excludeEnthalpyOfFormation=true 
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  constant Choices.ReferenceEnthalpy.Temp referenceChoice=Choices.
      ReferenceEnthalpy.ZeroAt0K "Choice of reference enthalpy";
  constant SpecificEnthalpy h_offset=0.0 
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  
  constant FluidConstants[nX] fluidConstants 
    "additional data needed for transport properties";
  constant MolarMass[nX_i] MMX=data[:].MM "molar masses of components";
  
  redeclare replaceable model extends BaseProperties(
    T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    X_i(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)) 
    import Modelica.Media.IdealGases.Common.SingleGasNasa;
    annotation (structurallyIncomplete);
      //    SpecificEnthalpy h_component[nX];
  equation 
    assert(T >= 200 and T <= 6000, "
Temperature T (= 200 K) is not in the allowed range
200 K <= T (= " + String(T) + " <= 6000 K
required from medium model \"" + mediumName + "\".");
    
    MM = molarMass(state);
    h = h_TX(T, X_i);
    R = data.R*X_i;
    u = h - R*T;
    d = p/(R*T);
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
    state.X = X_i;
  end BaseProperties;
  
/*  
  redeclare replaceable model extends EquilibriumProperties
    extends Interfaces.PartialMixtureMedium.BaseProperties
      (MM(start = 0.04),
       X(start = reference_X),
       T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default), 
       p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)); 
    import Modelica.Media.IdealGases.Common.SingleGasNasa;
    parameter MolarMass[nX] MMX=data[:].MM "molar masses of components";
    SpecificEnthalpy h_component[nX] "component specific enthalpy";
    SpecificEntropy[nX] s_component "component specific entropy";
    SI.MolarInternalEnergy[nX] g_formation "component Gibbs energy of formation, molar base!";
    Real p_red(start=1.0) "reduced pressure";
    parameter Integer n_reaction=size(nu, 1) "number of reactions";
    SI.MolarInternalEnergy[n_reaction] g_reaction "change of Gibbs energy due to reaction";
    Real[n_reaction] kr "reaction constants, computed via Gibbs energy";
    parameter Integer[n_reaction, nX] nu "stochiometry matrix (Evaluate true for removing zeros symbolically)" 
      annotation (Evaluate);
    annotation (structurallyIncomplete);
  equation 
    assert(T >= 200 and T <= 6000, "
       Temperature T (= 200 K) is not in the allowed range
       200 K <= T (= " + String(T) + " <= 6000 K
       required from medium model \"" + mediumName + "\".");
    
    p_red = max(p/reference_p, 1e-6);
    MM = molarMass(state);
    h_component = {SingleGasNasa.h_T(data[i], T, excludeEnthalpyOfFormation, 
                         referenceChoice, h_offset) for i in 1:nX};
    s_component = {Common.SingleGasNasa.s0_T(data[i], T) -
           data[i].R*Math.log(p_red) for i in 1:size(substanceNames, 1)};    
    g_formation = {(h_component[i] - T*s_component[i])*MMX[i] for i in 1:size(substanceNames, 1)};
    h = h_component*X;
    R = data.R*X;
    u = h - R*T;
    p = d*R*T;
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
    state.X = X;
    // for a concrete example, a stochiometric matrix is missing
    g_reaction = nu*g_formation;
    kr = {-g_reaction[i]/(Modelica.Constants.R*T) for i in 1:n_reaction};
  end EquilibriumProperties;
*/
  
  function h_TX "Return specific enthalpy" 
    import Modelica.Media.Interfaces.PartialMedium.Choices;
     extends Modelica.Icons.Function;
     input SI.Temperature T "Temperature";
     input MassFraction X_i[nX_i] "Independent Mass fractions of gas mixture";
     input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
     input Choices.ReferenceEnthalpy.Temp refChoice=referenceChoice 
      "Choice of reference enthalpy";
     input SI.SpecificEnthalpy h_off=h_offset 
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
     output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
  algorithm 
      h :=X_i*{SingleGasNasa.h_T(data[i], T, exclEnthForm, refChoice, h_off) for i in 1:nX_i};
  end h_TX;
  
  redeclare function extends gasConstant 
  algorithm 
    R := sum(data[i].R*state.X[i] for i in 1:size(substanceNames, 1));
  end gasConstant;
  
  function density "return density of ideal gas" 
    extends Modelica.Icons.Function;
    input ThermodynamicState state "thermodynamic state";
    output Density d "density";
  algorithm 
    d := state.p/(gasConstant(state)*state.T);
  end density;
  
  redeclare function extends heatCapacity_cp 
    "Return specific heat capacity at constant pressure" 
  algorithm 
    cp := 0;
    for i in 1:size(data,1) loop
      cp:=cp+SingleGasNasa.cp_T(data[i], state.T)*state.X[i];
    end for;
  end heatCapacity_cp;
  
  redeclare function extends heatCapacity_cv 
    "Compute specific heat capacity at constant volume from temperature and gas data" 
  algorithm 
    cv := 0;
    for i in 1:size(data,1) loop
      cv:=cv+(SingleGasNasa.cp_T(data[i], state.T)-data[i].R)*state.X[i];
    end for;
  end heatCapacity_cv;
  
  function MixEntropy "calculate the mixing entropy of ideal gases / R" 
    extends Modelica.Icons.Function;
    input SI.MoleFraction x[:] "mole fraction of mixture";
    output Real smix "mixing entropy contribution, divided by gas constant";
  protected 
    Real eps=Modelica.Constants.eps 
      "values smaller than eps are not used correctly in entropy summation";
  algorithm 
    smix := 0.0;
    for i in 1: size(x,1) loop
      smix := smix + (if x[i] > eps then -x[i]*Modelica.Math.log(x[i]) else x[i]);
    end for;
  end MixEntropy;
  
  redeclare function extends specificEntropy "Return specific entropy" 
  algorithm 
    s := 0.0;
    for i in 1:size(data,1) loop
      s := s + SingleGasNasa.s0_T(data[i], state.T)*state.X[i];
    end for;
    s := s - (data.R*state.X)*(Modelica.Math.log(state.p/reference_p))
    + MixEntropy(massToMoleFractions(state.X,data[:].MM));
  end specificEntropy;
  
  redeclare function extends isentropicExponent "Return isentropic exponent" 
  algorithm 
    gamma := heatCapacity_cp(state)/heatCapacity_cv(state);
  end isentropicExponent;
  
  redeclare function extends velocityOfSound "Return velocity of sound" 
    extends Modelica.Icons.Function;
    input ThermodynamicState state "properties at upstream location";
  algorithm 
    a := sqrt(gasConstant(state)*state.T*heatCapacity_cp(state)/heatCapacity_cv(state));
  end velocityOfSound;
  
  function isentropicEnthalpyApproximation 
    "approximate method of calculating h_is from upstream properties and downstream pressure" 
    extends Modelica.Icons.Function;
    input AbsolutePressure p2 "downstream pressure";
    input ThermodynamicState state "thermodynamic state at upstream location";
    output SpecificEnthalpy h_is "isentropic enthalpy";
  protected 
    SpecificEnthalpy h "specific enthalpy at upstream location";
    SpecificEnthalpy h_component[nX] "specific enthalpy at upstream location";
    IsentropicExponent gamma =  isentropicExponent(state) "Isentropic exponent";
  algorithm 
    h_component :={SingleGasNasa.h_T(data[i], state.T, excludeEnthalpyOfFormation,
      referenceChoice, h_offset) for i in 1:nX};
    h :=h_component*state.X;
    h_is := h + gamma/(gamma - 1.0)*(state.T*gasConstant(state))*
      ((p2/state.p)^((gamma - 1)/gamma) - 1.0);
  end isentropicEnthalpyApproximation;
  
  redeclare function extends isentropicEnthalpy "Return isentropic enthalpy" 
  algorithm 
    h_is := isentropicEnthalpyApproximation(p_downstream,refState);
  end isentropicEnthalpy;
  
function GasMixtureViscosity "Viscosities of gas mixtures at low pressures" 
  extends Modelica.Icons.Function;
  input MoleFraction[:] yi "Mole fractions";
  input MolarMass[:] M "Mole masses";
  input DynamicViscosity[:] eta "Pure component viscosities";
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
    
 annotation (Documentation(info="<html>
<body>
<h4>Function to compute the mixture viscosity of ideal gases (Wilke
method)</h4>
<br>
Simplification of the kinetic theory (Chapman and Enskog theory)
approach neglecting the second-order effects.<br>
<br>
This equation has been extensively tested (Amdur and Mason, 1958;
Bromley and Wilke, 1951; Cheung, 1958; Dahler, 1959; Gandhi and Saxena,
1964; Ranz and Brodowsky, 1962; Saxena and Gambhir, 1963a; Strunk, et
al., 1964; Vanderslice, et al. 1962; Wright and Gray, 1962). In most
cases, only nonpolar mixtures were compared, and very good results
obtained. For some systems containing hidrogen as one component, less
satisfactory agreement was noted. Wilke's method predicted mixture
viscosities that were larger than experimental for the H2-N2 system,
but for H2-NH3, it underestimated the viscosities. <br>
Gururaja, et al. (1967) found that this method also overpredicted in
the H2-O2 case but was quite accurate for the H2-CO2 system. <br>
Wilke's approximation has proved reliable even for polar-polar gas
mixtures of aliphatic alcohols (Reid and Belenyessy, 1960). The
principal reservation appears to lie in those cases where Mi&gt;&gt;Mj
and etai&gt;&gt;etaj.<br>
<br>
<br>
</body>
</html>
"));
equation 
    
end GasMixtureViscosity;
  
    redeclare function extends dynamicViscosity "mixture dynamic viscosity" 
  protected 
      DynamicViscosity[nX] etaX "component dynamic viscosities";
    algorithm 
      for i in 1:nX loop
    etaX[i] := SingleGasNasa.dynamicViscosityLowPressure(state.T,
                       fluidConstants[i].criticalTemperature,
                       fluidConstants[i].molarMass,
                       fluidConstants[i].criticalMolarVolume,
                       fluidConstants[i].acentricFactor,
                       fluidConstants[i].dipoleMoment);
      end for;
      eta := GasMixtureViscosity(massToMoleFractions(state.X,
                             fluidConstants[:].molarMass),
                 fluidConstants[:].molarMass,
                 etaX);
    end dynamicViscosity;
  
  function MixtureViscosityChung 
    "compute the viscosity of gas mixtures without access to component viscosities" 
  //Chung, et al. rules (1984, 1988)
  extends Modelica.Icons.Function;
    import SI = Modelica.SIunits;
    input Temperature T "Temperature";
    input Temperature[:] Tc "Critical temperatures";
    input MolarVolume[:] Vcrit "Critical volumes (m3/mol)";
    input Real[:] w "Acentric factors";
    input Real[:] mu "Dipole moments (debyes)";
    input MolarMass[:] MolecularWeights "Molecular weights (kg/mol)";
    input MoleFraction[:] y "Molar Fractions";
    input Real[:] kappa =  zeros(nX) "Association Factors";
    output DynamicViscosity etaMixture "Mixture viscosity (Pa.s)";
  protected 
  constant Real[size(y,1)] Vc =  Vcrit*1000000 "Critical volumes (cm3/mol)";
  constant Real[size(y,1)] M =  MolecularWeights*1000 
      "Molecular weights (g/mol)";
  Integer n = size(y,1) "Number of mixed elements";
  Real sigmam3 "Mixture sigma^3 in Ångström";
  Real sigma[size(y,1),size(y,1)];
  Real edivkm;
  Real edivk[size(y,1),size(y,1)];
  Real Mm;
  Real Mij[size(y,1),size(y,1)];
  Real wm "accentric factor";
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
  Vcm := sigmam3/(0.809)^3;
  Tcm := 1.2593*edivkm;
  murm := 131.3*mum/(Vcm*Tcm)^(1/2);
  kappam := (sigmam3*(sum(sum(y[i]*y[j]*kappaij[i,j] for j in 1:n) for i in 1:n)));
  Fcm := 1 - 0.275*wm + 0.059035*murm^4 + kappam;
  Tmstar := T/edivkm;
  omegav := 1.16145*(Tmstar)^(-0.14874) + 0.52487*Math.exp(-0.77320*Tmstar) + 2.16178*Math.exp(-2.43787*Tmstar);
  etam := 26.69*Fcm*(Mm*T)^(1/2)/(sigmam3^(2/3)*omegav);
  etaMixture := etam*1e7;
  annotation (Documentation(info="<html>
<head>
<meta content=\"text/html; charset=ISO-8859-1\"
http-equiv=\"content-type\">
<title>Chung viscosity</title>
</head>
<body>
<h4>Function to compute the mixture viscosity of ideal gases (Chung, et
al. rules)</h4>
<br>
Equation to estimate the viscosity of gas mixtures at low pressures.<br>
It is a simplification of an extension of the rigorous kinetic theory
of Chapman and Enskog to determine the viscosity of multicomponent
mixtures, at low pressures and with a factor to correct for molecule
shape and polarity.<br>
<br>
Inputs:&nbsp; -T \"Temperature\";<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -Tc \"Critical
temperatures\";<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -Vcrit
\"Critical volumes\";<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; -w
\"Acentric factors\";<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; -mu
\"Dipole moments (debyes)\";<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; -kappa
\"Association Factors\";<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
-MolecularWeights \"Molecular weights\";<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; -y
\"Molar Fractions\";<br>
Output: -etaMixture \"Mixture viscosity (Pa.s)\";<br>
<br>
Kappa is a special correction for highly polar substances such as
alcohols and acids.<br>
Values of kappa for a few such materials:&nbsp;&nbsp;&nbsp; <span
style=\"font-weight: bold;\"><br>
</span><span style=\"font-weight: bold;\">&nbsp;&nbsp;&nbsp; </span><br>
<div style=\"text-align: center;\"><span style=\"font-weight: bold;\"></span></div>
<table style=\"text-align: left; width: 302px; height: 200px;\" border=\"1\"
cellspacing=\"2\" cellpadding=\"2\">
<tbody>
<tr>
<td style=\"vertical-align: top;\">Compound <br>
</td>
<td style=\"vertical-align: top; text-align: center;\"><span
style=\"font-family: symbol;\">kappa</span><br>
</td>
<td style=\"vertical-align: top;\">Compound<br>
</td>
<td style=\"vertical-align: top;\">kappa<br>
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
<br>
Chung, et al. (1984) suggest that for other alcohols not shown in the
table:<br>
&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; kappa = 0.0682 + 4.704*[(number of -OH
groups)]/[molecular weight]<br>
<br>
<span style=\"font-weight: normal;\">S.I. units relation for the
debyes:&nbsp;</span><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 1 debye = 3.162e-25 (J.m^3)^(1/2)<br>
<br>
<h4>References</h4>
[1] THE PROPERTIES OF GASES AND LIQUIDS, Fifth Edition,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; Bruce E. Poling, John M.
Prausnitz, John P. O'Connell.<br>
[2] Chung, T.-H., M. Ajlan, L. L. Lee, and K. E. Starling: Ind. Eng.
Chem. Res., 27: 671 (1988).<br>
[3] Chung, T.-H., L. L. Lee, and K. E. Starling; Ing. Eng. Chem.
Fundam., 23: 3 ()1984).<br>
<br>
</body>
</html>
"));
  equation 
    
  end MixtureViscosityChung;
  
function LowPressureThermalConductivity 
    "Thermal conductivites of low-pressure gas mixtures" 
  extends Modelica.Icons.Function;
  input MoleFraction[:] y "Mole fraction of the components in the gass mixture";
  input Temperature T "Temperature";
  input Temperature[:] Tc "Critic temperatures";
  input AbsolutePressure[:] Pc "Critic pressures";
  input MolarMass[:] M "Molecular weights";
  input ThermalConductivity[:] lambda 
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
  annotation (Documentation(info="<html>
<body>
<h4>Thermal conductivites of low-pressure gas mixtures. Mason and
Saxena Modification.</h4>
This function applies the Masson and Saxena modification of the
Wassiljewa Equation for the thermal conductivity for gas mixtures of
n elements at low pressure.<br>
For nonpolar gas mixtures errors will generally be less than 3 to 4%.
For mixtures of nonpolar-polar and polar-polar gases, errors greater
than 5 to 8% may be expected. For mixtures in which the sizes and
polarities of the constituent molecules are not greatly different, the
thermal conductivity can be estimated satisfactorily by a mole fraction
average of the pure component conductivities.<br>
<br>
inputs: T \"Temperature\"<br>
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Tc \"Critical temperatures\"<br>
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp; Pc \"Critical pressures\"<br>
&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M \"Molecular weights\"<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; lambda \"Thermal
conductivities of the pure gases\"<br>
<br>
output: lambdam \"Thermal conductivity of the gas mixture\"<br>
<br>
</body>
</html>
"));
equation 
    
end LowPressureThermalConductivity;
  
    redeclare function extends thermalConductivity 
    "thermal conductivity for low pressure gas mixtures" 
      input Integer method=1 
      "method to compute single component thermal conductivity";
  protected 
      ThermalConductivity[nX] lambdaX "component thermal conductivities";
      DynamicViscosity[nX] eta "component thermal dynamic viscosities";
      SpecificHeatCapacity[nX] cp "component heat capacity";
    algorithm 
      for i in 1:nX loop
    eta[i] := SingleGasNasa.dynamicViscosityLowPressure(state.T,
                       fluidConstants[i].criticalTemperature,
                       fluidConstants[i].molarMass,
                       fluidConstants[i].criticalMolarVolume,
                       fluidConstants[i].acentricFactor,
                       fluidConstants[i].dipoleMoment);
    cp[i] := SingleGasNasa.cp_T(data[i],state.T);
    lambdaX[i] :=SingleGasNasa.ThermalConductivityEstimate(Cp=cp[i], eta=
          eta[i], method=method);
      end for;
      lambda := LowPressureThermalConductivity(massToMoleFractions(state.X,
                                   fluidConstants[:].molarMass),
                           state.T,
                           fluidConstants[:].criticalTemperature,
                           fluidConstants[:].criticalPressure,
                           fluidConstants[:].molarMass,
                           lambdaX);
    end thermalConductivity;
  
  redeclare function extends isobaricExpansionCoefficient 
    "Returns overall the isobaric expansion coefficient beta" 
  algorithm 
    beta := 1/state.T;
  end isobaricExpansionCoefficient;
  
  redeclare function extends isothermalCompressibility 
    "Returns overall the isothermal compressibility factor" 
  algorithm 
    kappa := 1.0/state.p;
  end isothermalCompressibility;
  
  redeclare function extends density_derp_T 
    "density derivative by temperature at constant pressure" 
  algorithm 
    ddpT := 1/(state.T*gasConstant(state));
  end density_derp_T;
  
  redeclare function extends density_derT_p 
    "density derivative by temperature at constant pressure" 
  algorithm 
    ddTp := -state.p/(state.T*state.T*gasConstant(state));
  end density_derT_p;
  
  redeclare function extends density_derX "density derivative by mass fraction" 
  algorithm 
    dddX := {-state.p/(state.T*gasConstant(state))*molarMass(state)/data[
      i].MM for i in 1:nX};
  end density_derX;
  
  redeclare function extends molarMass "compute molar mass of mixture" 
  algorithm 
    MM := 1/sum(state.X[j]/data[j].MM for j in 1:size(state.X, 1));
  end molarMass;
  
end MixtureGasNasa;
end Common;
