within Modelica.Media.IdealGases.Common;
package Functions
  "Basic Functions for ideal gases: cp, h, s, thermal conductivity, viscosity"
  extends Modelica.Icons.FunctionsPackage;

  constant Boolean excludeEnthalpyOfFormation=true
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  constant Modelica.Media.Interfaces.Choices.ReferenceEnthalpy referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K
    "Choice of reference enthalpy";
  constant Modelica.Media.Interfaces.Types.SpecificEnthalpy h_offset=0.0
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  constant Integer methodForThermalConductivity(min=1,max=2)=1;

  function cp_T
    "Compute specific heat capacity at constant pressure from temperature and gas data"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    output SI.SpecificHeatCapacity cp "Specific heat capacity at temperature T";
  algorithm
    cp := smooth(0,if T < data.Tlimit then data.R*(1/(T*T)*(data.alow[1] + T*(
      data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T
      *(data.alow[6] + data.alow[7]*T))))))) else data.R*(1/(T*T)*(data.ahigh[1]
       + T*(data.ahigh[2] + T*(1.*data.ahigh[3] + T*(data.ahigh[4] + T*(data.
      ahigh[5] + T*(data.ahigh[6] + data.ahigh[7]*T))))))));
    annotation (Inline=true,smoothOrder=2);
  end cp_T;

  function cp_Tlow
    "Compute specific heat capacity at constant pressure, low T region"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    output SI.SpecificHeatCapacity cp "Specific heat capacity at temperature T";
  algorithm
    cp := data.R*(1/(T*T)*(data.alow[1] + T*(
      data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T
      *(data.alow[6] + data.alow[7]*T)))))));
    annotation (Inline=false, derivative(zeroDerivative=data) = cp_Tlow_der);
  end cp_Tlow;

  function cp_Tlow_der
    "Compute specific heat capacity at constant pressure, low T region"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Real dT "Temperature derivative";
    output Real cp_der "Derivative of specific heat capacity";
  algorithm
    cp_der := dT*data.R/(T*T*T)*(-2*data.alow[1] + T*(
      -data.alow[2] + T*T*(data.alow[4] + T*(2.*data.alow[5] + T
      *(3.*data.alow[6] + 4.*data.alow[7]*T)))));
    annotation(smoothOrder=2);
  end cp_Tlow_der;

  function h_T "Compute specific enthalpy from temperature and gas data; reference is decided by the
    refChoice input, or by the referenceChoice package constant by default"
    import Modelica.Media.Interfaces.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                    refChoice=referenceChoice
      "Choice of reference enthalpy";
    input SI.SpecificEnthalpy h_off=h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";

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
    annotation (Inline=false,smoothOrder=2);
  end h_T;

  function h_T_der "Derivative function for h_T"
    import Modelica.Media.Interfaces.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                    refChoice=referenceChoice
      "Choice of reference enthalpy";
    input SI.SpecificEnthalpy h_off=h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    input Real dT "Temperature derivative";
    output Real h_der "Specific enthalpy at temperature T";
  algorithm
    h_der := dT*Modelica.Media.IdealGases.Common.Functions.cp_T(
                     data,T);
    annotation(Inline=true,smoothOrder=1);
  end h_T_der;

  function h_Tlow "Compute specific enthalpy, low T region; reference is decided by the
    refChoice input, or by the referenceChoice package constant by default"
    import Modelica.Media.Interfaces.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                    refChoice=referenceChoice
      "Choice of reference enthalpy";
    input SI.SpecificEnthalpy h_off=h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";

  algorithm
    h := data.R*((-data.alow[1] + T*(data.
      blow[1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.
      alow[4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))
      /T) + (if
      exclEnthForm then -data.Hf else 0.0) + (if (refChoice
       == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0 else 0.0) + (if
      refChoice == Choices.ReferenceEnthalpy.UserDefined then h_off else
            0.0);
    annotation(Inline=false,smoothOrder=2);
  end h_Tlow;

  function h_Tlow_der "Compute specific enthalpy, low T region; reference is decided by the
    refChoice input, or by the referenceChoice package constant by default"
    import Modelica.Media.Interfaces.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                    refChoice=referenceChoice
      "Choice of reference enthalpy";
    input SI.SpecificEnthalpy h_off=h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    input Real dT(unit="K/s") "Temperature derivative";
    output Real h_der(unit="J/(kg.s)")
      "Derivative of specific enthalpy at temperature T";
  algorithm
    h_der := dT*Modelica.Media.IdealGases.Common.Functions.cp_Tlow(
                        data,T);
    annotation(Inline=true,smoothOrder=2);
  end h_Tlow_der;

  function s0_T "Compute specific entropy from temperature and gas data"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    output SI.SpecificEntropy s "Specific entropy at temperature T";
  algorithm
    s := if T < data.Tlimit then data.R*(data.blow[2] - 0.5*data.alow[
      1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(T) + T*(
      data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
      7]*T)))) else data.R*(data.bhigh[2] - 0.5*data.ahigh[1]/(T*T) - data.
      ahigh[2]/T + data.ahigh[3]*Math.log(T) + T*(data.ahigh[4]
       + T*(0.5*data.ahigh[5] + T*(1/3*data.ahigh[6] + 0.25*data.ahigh[7]*T))));
    annotation (Inline=true, smoothOrder=2);
  end s0_T;

  function s0_Tlow "Compute specific entropy, low T region"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    output SI.SpecificEntropy s "Specific entropy at temperature T";
  algorithm
    s := data.R*(data.blow[2] - 0.5*data.alow[
      1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(T) + T*(
      data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
      7]*T))));
    annotation (Inline=true);
  end s0_Tlow;

  function s0_Tlow_der "Compute derivative of specific entropy, low T region"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "Ideal gas data";
    input SI.Temperature T "Temperature";
    input Real T_der "Temperature derivative";
    output SI.SpecificEntropy s "Specific entropy at temperature T";
  algorithm
    s := data.R*(data.blow[2] - 0.5*data.alow[
      1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(T) + T*(
      data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
      7]*T))));
    annotation (Inline=true);
  end s0_Tlow_der;

  function dynamicViscosityLowPressure
    "Dynamic viscosity of low pressure gases"
    extends Modelica.Icons.Function;
    input SI.Temp_K T "Gas temperature";
    input SI.Temp_K Tc "Critical temperature of gas";
    input SI.MolarMass M "Molar mass of gas";
    input SI.MolarVolume Vc "Critical molar volume of gas";
    input Real w "Acentric factor of gas";
    input Modelica.Media.Interfaces.Types.DipoleMoment mu
      "Dipole moment of gas molecule";
    input Real k =  0.0 "Special correction for highly polar substances";
    output SI.DynamicViscosity eta "Dynamic viscosity of gas";
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
    Tstar := 1.2593*T/Tc;
    Ov := 1.16145*Tstar^(-0.14874) + 0.52487*Modelica.Math.exp(-0.7732*Tstar) + 2.16178*Modelica.Math.exp(-2.43787
      *Tstar);
    eta := Const1_SI*Fc*sqrt(M*T)/(Vc^(2/3)*Ov);
    annotation (smoothOrder=2,
                Documentation(info="<html>
<p>
The used formula are based on the method of Chung et al (1984, 1988) referred to in ref [1] chapter 9.
The formula 9-4.10 is the one being used. The Formula is given in non-SI units, the following conversion constants were used to
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

<h4>References:</h4>
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
    lambda := if method == 1 then eta*(Cp - data.R + (9/4)*data.R)
                             else eta*(Cp - data.R)*(1.32 + 1.77/((Cp/data.R) - 1.0));
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
end Functions;
