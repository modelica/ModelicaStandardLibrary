within Modelica.Media.Air;
package DryAirNasa "Air: Detailed dry air model as ideal gas (200..6000 K)"
  extends IdealGases.Common.SingleGasNasa(
    mediumName="Air",
    data=IdealGases.Common.SingleGasesData.Air,
    fluidConstants={IdealGases.Common.FluidData.N2});

  redeclare function dynamicViscosity
    "Simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output DynamicViscosity eta "Dynamic viscosity";
  algorithm
    eta := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.96717436974791E-011),
      5.06626785714286E-008,1.72937731092437E-005}, Cv.to_degC(state.T));
    annotation (Documentation(info="<html>
Dynamic viscosity is computed from temperature using a second order polynomial with a range of validity between 73 and 373 K.
</html>"));
  end dynamicViscosity;

  redeclare function thermalConductivity
    "Simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    input Integer method=1 "Dummy for compatibility reasons";
    output ThermalConductivity lambda "Thermal conductivity";
  algorithm
    lambda := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.8737307422969E-008),
      7.67803133753502E-005,0.0241814385504202}, Cv.to_degC(state.T));

    annotation (Documentation(info="<html>
Thermal conductivity is computed from temperature using a second order polynomial with a range of validity between 73 and 373 K.
</html>"));
  end thermalConductivity;

  annotation (Documentation(info="<html>
<p>
    <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/Air.png\">
</p>

<p>
Ideal gas medium model for dry air based on the package <a href=\"modelica://Modelica.Media.IdealGases\">IdealGases</a> with additional functions for dynamic viscosity and thermal conductivity in a limited temperature range.
</p>
</html>"));
end DryAirNasa;
