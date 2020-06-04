within Modelica.Media.Air;
package DryAirNasa "Air: Detailed dry air model as ideal gas (200..6000 K)"
  extends Modelica.Icons.MaterialProperty;
  extends IdealGases.Common.SingleGasNasa(
    mediumName="Air",
    data=IdealGases.Common.SingleGasesData.Air,
    fluidConstants={IdealGases.Common.FluidData.N2});

  redeclare function dynamicViscosity
    "Return dynamic viscosity of dry air (simple polynomial, moisture influence small, valid from 123.15 K to 1273.15 K, outside of this range linear extrapolation is used)"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output DynamicViscosity eta "Dynamic viscosity";
    import Modelica.Math.Polynomials;
  algorithm
    eta := 1e-6*Polynomials.evaluateWithRange(
        {9.7391102886305869E-15,-3.1353724870333906E-11,4.3004876595642225E-08,
        -3.8228016291758240E-05,5.0427874367180762E-02,1.7239260139242528E+01},
        Cv.to_degC(123.15),
        Cv.to_degC(1273.15),
        Cv.to_degC(state.T));
    annotation (smoothOrder=2, Documentation(info="<html>
<p>Dynamic viscosity is computed from temperature using a simple polynomial for dry air. Range of validity is from 123.15 K to 1273.15 K. The influence of pressure is neglected.</p>
<p>Source: VDI Waermeatlas, 8th edition.</p>
</html>"));
  end dynamicViscosity;

  redeclare function thermalConductivity
    "Return thermal conductivity of dry air (simple polynomial, moisture influence small, valid from 123.15 K to 1273.15 K, outside of this range linear extrapolation is used)"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    input Integer method=1 "Dummy for compatibility reasons";
    output ThermalConductivity lambda "Thermal conductivity";
    import Modelica.Math.Polynomials;
  algorithm
    lambda := 1e-3*Polynomials.evaluateWithRange(
        {6.5691470817717812E-15,-3.4025961923050509E-11,5.3279284846303157E-08,
        -4.5340839289219472E-05,7.6129675309037664E-02,2.4169481088097051E+01},
        Cv.to_degC(123.15),
        Cv.to_degC(1273.15),
        Cv.to_degC(state.T));

    annotation (smoothOrder=2, Documentation(info="<html>
<p>Thermal conductivity is computed from temperature using a simple polynomial for dry air. Range of validity is from 123.15 K to 1273.15 K. The influence of pressure is neglected.</p>
<p>Source: VDI Waermeatlas, 8th edition.</p>
</html>"));
  end thermalConductivity;

  annotation (Documentation(info="<html>
<div>
    <img src=\"modelica://Modelica/Resources/Images/Media/Air/Air.png\">
</div>

<p>
Ideal gas medium model for dry air based on the package <a href=\"modelica://Modelica.Media.IdealGases\">IdealGases</a> with additional functions for dynamic viscosity and thermal conductivity in a limited temperature range.
</p>
</html>"));
end DryAirNasa;
