within Modelica;
package Units "Library of type and unit definitions"
  extends Modelica.Icons.Package;

package UsersGuide "User's Guide of Units Library"
  extends Modelica.Icons.Information;

  class HowToUseUnits "How to use Units"
    extends Modelica.Icons.Information;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
When implementing a Modelica model, every variable needs to
be declared. Physical variables should be declared with a unit.
The basic approach in Modelica is that the unit attribute of
a variable is the <strong>unit</strong> in which the <strong>equations</strong> are <strong>written</strong>,
for example:
</p>

<blockquote><pre>
<strong>model</strong> MassOnGround
  <strong>parameter</strong> Real m(quantity=\"Mass\", unit=\"kg\") \"Mass\";
  <strong>parameter</strong> Real f(quantity=\"Force\", unit=\"N\") \"Driving force\";
  Real s(unit=\"m\") \"Position of mass\";
  Real v(unit=\"m/s\") \"Velocity of mass\";
<strong>equation</strong>
  <strong>der</strong>(s) = v;
  m*<strong>der</strong>(v) = f;
<strong>end</strong> MassOnGround;
</pre></blockquote>

<p>
This means that the equations in the equation section are only correct
for the specified units. A different issue is the user interface, i.e.,
in which unit the variable is presented to the user in graphical
user interfaces, both for input (e.g., parameter menu), as well as
for output (e.g., in the plot window). Preferably, the Modelica tool
should provide a list of units from which the user can select, e.g.,
\"m\", \"cm\", \"km\", \"inch\" for quantity \"Length\". When storing the value in
the model as a Modelica modifier, it has to be converted to the unit defined
in the declaration. Additionally, the unit used in the graphical
user interface has to be stored. In order to have a standardized way
of doing this, Modelica provides the following three attributes
for a variable of type Real:
</p>

<ul>
<li><strong>quantity</strong> to define the physical quantity (e.g., \"Length\", or \"Energy\").</li>
<li><strong>unit</strong> to define the unit that has to be used
    in order that the equations are correct (e.g., \"N.m\").</li>
<li><strong>displayUnit</strong> to define the unit used in the graphical
    user interface as default display unit for input and/or output.</li>
</ul>

<p>
Note, a unit, such as \"N.m\", is not sufficient to define uniquely the
physical quantity, since, e.g., \"N.m\" might be either \"torque\" or
\"energy\". The \"quantity\" attribute might therefore be used by a tool
to select the corresponding menu from which the user can select
a unit for the corresponding variable.
</p>

<p>
For example, after providing a value for \"m\" and \"f\" in a parameter
menu of an instance of MassOnGround, a tool might generate the following code:
</p>

<blockquote><pre>
MassOnGround myObject(m(displayUnit=\"g\")=2, f=3);
</pre></blockquote>

<p>
The meaning is that in the equations a value of \"2\" is used
and that in the graphical user interface a value of \"2000\" should be used,
together with the unit \"g\" from the unit set \"Mass\" (= the quantity name).
Note, according to the Modelica specification
a tool might ignore the \"displayUnit\" attribute.
</p>

<p>
In order to help the Modelica model developer, the <code>Modelica.Units</code>
library provides about 450 predefined type names,
together with values for the attributes <strong>quantity</strong>, <strong>unit</strong> and sometimes
<strong>displayUnit</strong> and <strong>min</strong>. The unit is always selected as SI-unit according to the
ISO standard. The type and the quantity names are the
quantity names used in the ISO standard. \"quantity\" and \"unit\" are defined
as \"<strong>final</strong>\" in order that they cannot be modified. Attributes \"displayUnit\"
and \"min\" can, however, be changed in a model via a modification. The example above,
might therefore be alternatively also defined as:
</p>

<blockquote><pre>
<strong>model</strong> MassOnGround
  <strong>parameter</strong> Modelica.Units.SI.Mass  m \"Mass\";
  <strong>parameter</strong> Modelica.Units.SI.Force f \"Driving force\";
  ...
<strong>end</strong> MassOnGround;
</pre></blockquote>

<p>
or in a short hand notation as
</p>

<blockquote><pre>
<strong>model</strong> MassOnGround
  <strong>import</strong> Modelica.Units.SI;
  <strong>parameter</strong> SI.Mass  m \"Mass\";
  <strong>parameter</strong> SI.Force f \"Driving force\";
  ...
<strong>end</strong> MassOnGround;
</pre></blockquote>

<p>
For some often
used Non SI-units (like hour), some additional type definitions are
present as <code>Modelica.Units.NonSI</code>. If this is not sufficient,
the user has to define its own types or use the attributes directly
in the declaration as in the example at the beginning.
</p>

<p>
<strong>Complex units</strong> are also included in <code>Modelica.Units</code>.
A complex unit is declared as:
</p>
<blockquote><pre>
<strong>model</strong> QuasiStaticMachine
  <strong>parameter</strong> Modelica.Units.SI.ComplexPower SNominal = Complex(10000,4400)
     \"Nominal complex power\";
  ...
<strong>end</strong> QuasiStaticMachine;
</pre></blockquote>
</html>"));

  end HowToUseUnits;

  class Conventions "Conventions"
    extends Modelica.Icons.Information;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>The following conventions are used in package <code>Modelica.Units.SI</code>:</p>
<ul>
<li>Modelica quantity names are defined according to the recommendations
    of ISO 31. Some of these name are rather long, such as
    \"ThermodynamicTemperature\". Shorter alias names are defined, e.g.,
    \"type Temperature = ThermodynamicTemperature;\".</li>
<li>Modelica units are defined according to the SI base units without
    multiples (only exception \"kg\").</li>
<li>For some quantities, more convenient units for an engineer are
    defined as \"displayUnit\", i.e., the default unit for display
    purposes (e.g., displayUnit=\"deg\" for quantity=\"Angle\").</li>
<li>The type name is identical to the quantity name, following
    the convention of type names.</li>
<li>All quantity and unit attributes are defined as final in order
    that they cannot be redefined to another value.</li>
<li>Similar quantities, such as \"Length, Breadth, Height, Thickness,
    Radius\" are defined as the same quantity (here: \"Length\").</li>
<li>The ordering of the type declarations in this package follows ISO 31:
<blockquote><pre>
Chapter  1: <strong>Space and Time</strong>
Chapter  2: <strong>Periodic and Related Phenomena</strong>
Chapter  3: <strong>Mechanics</strong>
Chapter  4: <strong>Heat</strong>
Chapter  5: <strong>Electricity and Magnetism</strong>
Chapter  6: <strong>Light and Related Electromagnetic Radiations</strong>
Chapter  7: <strong>Acoustics</strong>
Chapter  8: <strong>Physical Chemistry</strong>
Chapter  9: <strong>Atomic and Nuclear Physics</strong>
Chapter 10: <strong>Nuclear Reactions and Ionizing Radiations</strong>
Chapter 11: (not defined in ISO 31-1992)
Chapter 12: <strong>Characteristic Numbers</strong>
Chapter 13: <strong>Solid State Physics</strong>
</pre></blockquote>
</li>
<li>Conversion functions between SI and other units are available in the subpackage
    <code>Conversions</code>.</li>
</ul>
</html>"));

  end Conventions;

  class Literature "Literature"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>
<p> This package is based on the following references
</p>

<dl>
<dt>ISO 31-1992:</dt>
<dd> <strong>General principles concerning
    quantities, units and symbols</strong>.<br>&nbsp;</dd>

<dt>ISO 1000-1992:</dt>
<dd> <strong>SI units and recommendations for the use
    of their multiples and of certain other units</strong>.<br>&nbsp;</dd>

<dt>Cardarelli F.:</dt>
<dd> <strong>Scientific Unit Conversion - A Practical
     Guide to Metrication</strong>. Springer 1997.</dd>
</dl>

</html>"));
  end Literature;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<h4>Main author</h4>

<p>
<a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a><br>
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt (DLR)<br>
Institut f&uuml;r Systemdynamik und Regelungstechnik (SR)<br>
M&uuml;nchener Straße 20<br>
D-82234 We&szlig;ling<br>
Germany<br>
email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a>
</p>

<h4>Acknowledgements</h4>

<p>
Astrid Jaschinski, Hubertus Tummescheit and Christian Schweiger
contributed to the implementation of this package.
</p>
</html>"));
  end Contact;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <strong>Units</strong> is a <strong>free</strong> Modelica package providing
predefined types, such as <em>Mass</em>,
<em>Length</em>, <em>Time</em>.</p>
</html>"));
end UsersGuide;

  package SI "Library of SI unit definitions"
    extends Modelica.Icons.Package;

    // Space and Time (chapter 1 of ISO 31-1992)

    type Angle = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");
    type SolidAngle = Real (final quantity="SolidAngle", final unit="sr");
    type Length = Real (final quantity="Length", final unit="m");
    type PathLength = Length;
    type Position = Length;
    type Distance = Length (min=0);
    type Breadth = Length(min=0);
    type Height = Length(min=0);
    type Thickness = Length(min=0);
    type Radius = Length(min=0);
    type Diameter = Length(min=0);
    type Area = Real (final quantity="Area", final unit="m2");
    type Volume = Real (final quantity="Volume", final unit="m3");
    type Time = Real (final quantity="Time", final unit="s");
    type Duration = Time;
    type AngularVelocity = Real (
        final quantity="AngularVelocity",
        final unit="rad/s");
    type AngularAcceleration = Real (final quantity="AngularAcceleration", final unit="rad/s2");
    type AngularJerk = Real (final quantity="AngularJerk", final unit="rad/s3");
    type Velocity = Real (final quantity="Velocity", final unit="m/s");
    type Acceleration = Real (final quantity="Acceleration", final unit="m/s2");
    type Jerk = Real (final quantity="Jerk", final unit="m/s3");
    // Periodic and related phenomens (chapter 2 of ISO 31-1992)
    type Period = Real (final quantity="Time", final unit="s");
    type Frequency = Real (final quantity="Frequency", final unit="Hz");
    type AngularFrequency = Real (final quantity="AngularFrequency", final unit=
            "rad/s");
    type Wavelength = Real (final quantity="Wavelength", final unit="m");
    type WaveNumber = Real (final quantity="WaveNumber", final unit="m-1");
    type CircularWaveNumber = Real (final quantity="CircularWaveNumber", final unit=
               "rad/m");
    type AmplitudeLevelDifference = Real (final quantity=
            "AmplitudeLevelDifference", final unit="dB");
    type PowerLevelDifference = Real (final quantity="PowerLevelDifference",
          final unit="dB");
    type DampingCoefficient = Real (final quantity="DampingCoefficient", final unit=
               "s-1");
    type LogarithmicDecrement = Real (final quantity="LogarithmicDecrement",
          final unit="1/S");
    type AttenuationCoefficient = Real (final quantity="AttenuationCoefficient",
          final unit="m-1");
    type PhaseCoefficient = Real (final quantity="PhaseCoefficient", final unit=
            "m-1");
    type PropagationCoefficient = Real (final quantity="PropagationCoefficient",
          final unit="m-1");
    // added to ISO-chapter
    type Damping = DampingCoefficient;
    // Mechanics (chapter 3 of ISO 31-1992)
    type Mass = Real (
        quantity="Mass",
        final unit="kg",
        min=0);
    type Density = Real (
        final quantity="Density",
        final unit="kg/m3",
        displayUnit="g/cm3",
        min=0.0);
    type RelativeDensity = Real (
        final quantity="RelativeDensity",
        final unit="1",
        min=0.0);
    type SpecificVolume = Real (
        final quantity="SpecificVolume",
        final unit="m3/kg",
        min=0.0);
    type LinearDensity = Real (
        final quantity="LinearDensity",
        final unit="kg/m",
        min=0);
    type SurfaceDensity = Real (
        final quantity="SurfaceDensity",
        final unit="kg/m2",
        min=0);
    type Momentum = Real (final quantity="Momentum", final unit="kg.m/s");
    type Impulse = Real (final quantity="Impulse", final unit="N.s");
    type AngularMomentum = Real (final quantity="AngularMomentum", final unit=
            "kg.m2/s");
    type AngularImpulse = Real (final quantity="AngularImpulse", final unit=
            "N.m.s");
    type MomentOfInertia = Real (final quantity="MomentOfInertia", final unit=
            "kg.m2");
    type Inertia = MomentOfInertia;
    type Force = Real (final quantity="Force", final unit="N");
    type TranslationalSpringConstant=Real(final quantity="TranslationalSpringConstant", final unit="N/m");
    type TranslationalDampingConstant=Real(final quantity="TranslationalDampingConstant", final unit="N.s/m");
    type Weight = Force;
    type Torque = Real (final quantity="Torque", final unit="N.m");
    type ElectricalTorqueConstant = Real(final quantity="ElectricalTorqueConstant", final unit= "N.m/A");
    type MomentOfForce = Torque;
    type ImpulseFlowRate = Real (final quantity="ImpulseFlowRate", final unit="N");
    type AngularImpulseFlowRate = Real (final quantity="AngularImpulseFlowRate", final unit= "N.m");
    type RotationalSpringConstant=Real(final quantity="RotationalSpringConstant", final unit="N.m/rad");
    type RotationalDampingConstant=Real(final quantity="RotationalDampingConstant", final unit="N.m.s/rad");
    type Pressure = Real (
        final quantity="Pressure",
        final unit="Pa",
        displayUnit="bar");
    type AbsolutePressure = Pressure (min=0.0, nominal = 1e5);
    type PressureDifference = Pressure;
    type BulkModulus = AbsolutePressure;
    type Stress = Real (final unit="Pa");
    type NormalStress = Stress;
    type ShearStress = Stress;
    type Strain = Real (final quantity="Strain", final unit="1");
    type LinearStrain = Strain;
    type ShearStrain = Strain;
    type VolumeStrain = Real (final quantity="VolumeStrain", final unit="1");
    type PoissonNumber = Real (final quantity="PoissonNumber", final unit="1");
    type ModulusOfElasticity = Stress;
    type ShearModulus = Stress;
    type SecondMomentOfArea = Real (final quantity="SecondMomentOfArea", final unit=
               "m4");
    type SecondPolarMomentOfArea = SecondMomentOfArea;
    type SectionModulus = Real (final quantity="SectionModulus", final unit="m3");
    type CoefficientOfFriction = Real (final quantity="CoefficientOfFriction",
          final unit="1");
    type DynamicViscosity = Real (
        final quantity="DynamicViscosity",
        final unit="Pa.s",
        min=0);
    type KinematicViscosity = Real (
        final quantity="KinematicViscosity",
        final unit="m2/s",
        min=0);
    type SurfaceTension = Real (final quantity="SurfaceTension", final unit="N/m");
    type Work = Real (final quantity="Work", final unit="J");
    type Energy = Real (final quantity="Energy", final unit="J");
    type EnergyDensity = Real (final quantity="EnergyDensity", final unit="J/m3");
    type PotentialEnergy = Energy;
    type KineticEnergy = Energy;
    type Power = Real (final quantity="Power", final unit="W");
    type EnergyFlowRate = Power;
    type EnthalpyFlowRate = Real (final quantity="EnthalpyFlowRate", final unit=
            "W");
    type Efficiency = Real (
        final quantity="Efficiency",
        final unit="1",
        min=0);
    type MassFlowRate = Real (quantity="MassFlowRate", final unit="kg/s");
    type VolumeFlowRate = Real (final quantity="VolumeFlowRate", final unit=
            "m3/s");
    // added to ISO-chapter 3
    type MomentumFlux = Real (final quantity="MomentumFlux", final unit="N");
    type AngularMomentumFlux = Real (final quantity="AngularMomentumFlux", final unit=
               "N.m");
    // Heat (chapter 4 of ISO 31-1992)
    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0.0,
        start = 288.15,
        nominal = 300,
        displayUnit="degC")
      "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue=true);
    type Temperature = ThermodynamicTemperature;
    type TemperatureDifference = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K") annotation(absoluteValue=false);
    type TemperatureSlope = Real (final quantity="TemperatureSlope",
        final unit="K/s");
    type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit="1/K");
    type QuadraticTemperatureCoefficient = Real(final quantity = "QuadraticTemperatureCoefficient", final unit="1/K2");
    type LinearExpansionCoefficient = Real (final quantity=
            "LinearExpansionCoefficient", final unit="1/K");
    type CubicExpansionCoefficient = Real (final quantity=
            "CubicExpansionCoefficient", final unit="1/K");
    type RelativePressureCoefficient = Real (final quantity=
            "RelativePressureCoefficient", final unit="1/K");
    type PressureCoefficient = Real (final quantity="PressureCoefficient", final unit=
               "Pa/K");
    type Compressibility = Real (final quantity="Compressibility", final unit=
            "1/Pa");
    type IsothermalCompressibility = Compressibility;
    type IsentropicCompressibility = Compressibility;
    type Heat = Real (final quantity="Energy", final unit="J");
    type HeatFlowRate = Real (final quantity="Power", final unit="W");
    type HeatFlux = Real (final quantity="HeatFlux", final unit="W/m2");
    type DensityOfHeatFlowRate = Real (final quantity="DensityOfHeatFlowRate",
          final unit="W/m2");
    type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit=
               "W/(m.K)");
    type CoefficientOfHeatTransfer = Real (final quantity=
            "CoefficientOfHeatTransfer", final unit="W/(m2.K)");
    type SurfaceCoefficientOfHeatTransfer = CoefficientOfHeatTransfer;
    type ThermalInsulance = Real (final quantity="ThermalInsulance", final unit=
            "m2.K/W");
    type ThermalResistance = Real (final quantity="ThermalResistance", final unit=
           "K/W");
    type ThermalConductance = Real (final quantity="ThermalConductance", final unit=
               "W/K");
    type ThermalDiffusivity = Real (final quantity="ThermalDiffusivity", final unit=
               "m2/s");
    type HeatCapacity = Real (final quantity="HeatCapacity", final unit="J/K");
    type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
          final unit="J/(kg.K)");
    type SpecificHeatCapacityAtConstantPressure = SpecificHeatCapacity;
    type SpecificHeatCapacityAtConstantVolume = SpecificHeatCapacity;
    type SpecificHeatCapacityAtSaturation = SpecificHeatCapacity;
    type RatioOfSpecificHeatCapacities = Real (final quantity=
            "RatioOfSpecificHeatCapacities", final unit="1");
    type IsentropicExponent = Real (final quantity="IsentropicExponent", final unit=
               "1");
    type Entropy = Real (final quantity="Entropy", final unit="J/K");
    type EntropyFlowRate = Real (final quantity="EntropyFlowRate", final unit="J/(K.s)");
    type SpecificEntropy = Real (final quantity="SpecificEntropy",
                                 final unit="J/(kg.K)");
    type InternalEnergy = Heat;
    type Enthalpy = Heat;
    type HelmholtzFreeEnergy = Heat;
    type GibbsFreeEnergy = Heat;
    type SpecificEnergy = Real (final quantity="SpecificEnergy",
                                final unit="J/kg");
    type SpecificInternalEnergy = SpecificEnergy;
    type SpecificEnthalpy = SpecificEnergy;
    type SpecificHelmholtzFreeEnergy = SpecificEnergy;
    type SpecificGibbsFreeEnergy = SpecificEnergy;
    type MassieuFunction = Real (final quantity="MassieuFunction", final unit=
            "J/K");
    type PlanckFunction = Real (final quantity="PlanckFunction", final unit="J/K");
    // added to ISO-chapter 4
    type DerDensityByEnthalpy = Real (final unit="kg.s2/m5");
    type DerDensityByPressure = Real (final unit="s2/m2");
    type DerDensityByTemperature = Real (final unit="kg/(m3.K)");
    type DerEnthalpyByPressure = Real (final unit="J.m.s2/kg2");
    type DerEnergyByDensity = Real (final unit="J.m3/kg");
    type DerEnergyByPressure = Real (final unit="J.m.s2/kg");
    type DerPressureByDensity = Real (final unit="Pa.m3/kg");
    type DerPressureByTemperature = Real (final unit="Pa/K");
    // Electricity and Magnetism (chapter 5 of ISO 31-1992)
    type ElectricCurrent = Real (final quantity="ElectricCurrent", final unit="A");
    type Current = ElectricCurrent;
    type CurrentSlope = Real(final quantity="CurrentSlope", final unit="A/s");
    type ElectricCharge = Real (final quantity="ElectricCharge", final unit="C");
    type Charge = ElectricCharge;
    type VolumeDensityOfCharge = Real (
        final quantity="VolumeDensityOfCharge",
        final unit="C/m3",
        min=0);
    type SurfaceDensityOfCharge = Real (
        final quantity="SurfaceDensityOfCharge",
        final unit="C/m2",
        min=0);
    type ElectricFieldStrength = Real (final quantity="ElectricFieldStrength",
          final unit="V/m");
    type ElectricPotential = Real (final quantity="ElectricPotential", final unit=
           "V");
    type Voltage = ElectricPotential;
    type PotentialDifference = ElectricPotential;
    type ElectromotiveForce = ElectricPotential;
    type VoltageSecond = Real (final quantity="VoltageSecond", final unit="V.s")
      "Voltage second";
    type VoltageSlope = Real(final quantity="VoltageSlope", final unit="V/s");
    type ElectricFluxDensity = Real (final quantity="ElectricFluxDensity", final unit=
               "C/m2");
    type ElectricFlux = Real (final quantity="ElectricFlux", final unit="C");
    type Capacitance = Real (
        final quantity="Capacitance",
        final unit="F",
        min=0);
    type CapacitancePerUnitLength = Real (
        final quantity="CapacitancePerUnitLength",
        final unit="F/m") "Capacitance per unit length of wire/cable/line";
    type CapacitancePerArea =
                Real (final quantity="CapacitancePerArea", final unit="F/m2")
      "Capacitance per area";
    type Permittivity = Real (
        final quantity="Permittivity",
        final unit="F/m",
        min=0);
    type PermittivityOfVacuum = Permittivity;
    type RelativePermittivity = Real (final quantity="RelativePermittivity",
          final unit="1");
    type ElectricSusceptibility = Real (final quantity="ElectricSusceptibility",
          final unit="1");
    type ElectricPolarization = Real (final quantity="ElectricPolarization",
          final unit="C/m2");
    type Electrization = Real (final quantity="Electrization", final unit="V/m");
    type ElectricDipoleMoment = Real (final quantity="ElectricDipoleMoment",
          final unit="C.m");
    type CurrentDensity = Real (final quantity="CurrentDensity", final unit=
            "A/m2");
    type LinearCurrentDensity = Real (final quantity="LinearCurrentDensity",
          final unit="A/m");
    type MagneticFieldStrength = Real (final quantity="MagneticFieldStrength",
          final unit="A/m");
    type MagneticPotential = Real (final quantity="MagneticPotential", final unit="A");
    type MagneticPotentialDifference = Real (final quantity=
            "MagneticPotential", final unit="A");
    type MagnetomotiveForce = Real (final quantity="MagnetomotiveForce", final unit=
               "A");
    type CurrentLinkage = Real (final quantity="CurrentLinkage", final unit="A");
    type MagneticFluxDensity = Real (final quantity="MagneticFluxDensity", final unit=
               "T");
    type MagneticFlux = Real (final quantity="MagneticFlux", final unit="Wb");
    type MagneticVectorPotential = Real (final quantity="MagneticVectorPotential",
            final unit="Wb/m");
    type Inductance = Real (
        final quantity="Inductance",
        final unit="H");
    type SelfInductance = Inductance(min=0);
    type MutualInductance = Inductance;
    type InductancePerUnitLength = Real (
        final quantity="InductancePerUnitLength",
        final unit="H/m") "Inductance per unit length of wire/cable/line";
    type CouplingCoefficient = Real (final quantity="CouplingCoefficient", final unit=
               "1");
    type LeakageCoefficient = Real (final quantity="LeakageCoefficient", final unit=
               "1");
    type Permeability = Real (final quantity="Permeability", final unit="V.s/(A.m)");
    type PermeabilityOfVacuum = Permeability;
    type RelativePermeability = Real (final quantity="RelativePermeability",
          final unit="1");
    type MagneticSusceptibility = Real (final quantity="MagneticSusceptibility",
          final unit="1");
    type ElectromagneticMoment = Real (final quantity="ElectromagneticMoment",
          final unit="A.m2");
    type MagneticDipoleMoment = Real (final quantity="MagneticDipoleMoment",
          final unit="Wb.m");
    type Magnetization = Real (final quantity="Magnetization", final unit="A/m");
    type MagneticPolarization = Real (final quantity="MagneticPolarization",
          final unit="T");
    type ElectromagneticEnergyDensity = Real (final quantity="EnergyDensity",
          final unit="J/m3");
    type PoyntingVector = Real (final quantity="PoyntingVector", final unit=
            "W/m2");
    type Resistance = Real (
        final quantity="Resistance",
        final unit="Ohm");
    type ResistancePerUnitLength = Real (
        final quantity="ResistancePerUnitLength",
        final unit="Ohm/m") "Resistance per unit length of wire/cable/line";
    type Resistivity = Real (final quantity="Resistivity", final unit="Ohm.m");
    type Conductivity = Real (final quantity="Conductivity", final unit="S/m");
    type Reluctance = Real (final quantity="Reluctance", final unit="H-1");
    type Permeance = Real (final quantity="Permeance", final unit="H");
    type PhaseDifference = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");
    type Impedance = Resistance;
    type ImpedancePerUnitLength = ResistancePerUnitLength "Impedance per unit length of wire/cable/line";
    type ModulusOfImpedance = Resistance;
    type Reactance = Resistance;
    type ReactancePerUnitLength = ResistancePerUnitLength "Reactance per unit length of wire/cable/line";
    type QualityFactor = Real (final quantity="QualityFactor", final unit="1");
    type LossAngle = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");
    type Conductance = Real (
        final quantity="Conductance",
        final unit="S");
    type ConductancePerUnitLength = Real (
        final quantity="ConductancePerUnitLength",
        final unit="S/m") "Conductance per unit length of wire/cable/line";
    type Admittance = Conductance;
    type AdmittancePerUnitLength = ConductancePerUnitLength "Admittance per unit length of wire/cable/line";
    type ModulusOfAdmittance = Conductance;
    type Susceptance = Conductance;
    type SusceptancePerUnitLength = ConductancePerUnitLength "Susceptance per unit length of wire/cable/line";
    type InstantaneousPower = Real (final quantity="Power", final unit="W");
    type ActivePower = Real (final quantity="Power", final unit="W");
    type ApparentPower = Real (final quantity="Power", final unit="V.A");
    type ReactivePower = Real (final quantity="Power", final unit="var");
    type PowerFactor = Real (final quantity="PowerFactor", final unit="1");
    type LinearTemperatureCoefficientResistance = Real (
      final quantity="LinearTemperatureCoefficientResistance",
      final unit="Ohm/K") "First order temperature coefficient";
    type QuadraticTemperatureCoefficientResistance = Real (
      final quantity="QuadraticTemperatureCoefficientResistance",
      final unit="Ohm/K2") "Second order temperature coefficient";
    // added to ISO-chapter 5
    type Transconductance = Real (final quantity="Transconductance", final unit=
            "A/V2");
    type InversePotential = Real (final quantity="InversePotential", final unit=
            "1/V");
    type ElectricalForceConstant = Real (
         final quantity="ElectricalForceConstant",
         final unit = "N/A");
    // Light and Related Electromagnetic Radiations (chapter 6 of ISO 31-1992)
    type RadiantEnergy = Real (final quantity="Energy", final unit="J");
    type RadiantEnergyDensity = Real (final quantity="EnergyDensity", final unit=
            "J/m3");
    type SpectralRadiantEnergyDensity = Real (final quantity=
            "SpectralRadiantEnergyDensity", final unit="J/m4");
    type RadiantPower = Real (final quantity="Power", final unit="W");
    type RadiantEnergyFluenceRate = Real (final quantity=
            "RadiantEnergyFluenceRate", final unit="W/m2");
    type RadiantIntensity = Real (final quantity="RadiantIntensity", final unit=
            "W/sr");
    type Radiance = Real (final quantity="Radiance", final unit="W/(sr.m2)");
    type RadiantExitance = Real (final quantity="RadiantExitance", final unit=
            "W/m2");
    type Irradiance = Real (final quantity="Irradiance", final unit="W/m2");
    type Emissivity = Real (final quantity="Emissivity", final unit="1");
    type SpectralEmissivity = Real (final quantity="SpectralEmissivity", final unit=
               "1");
    type DirectionalSpectralEmissivity = Real (final quantity=
            "DirectionalSpectralEmissivity", final unit="1");
    type LuminousIntensity = Real (final quantity="LuminousIntensity", final unit=
           "cd");
    type LuminousFlux = Real (final quantity="LuminousFlux", final unit="lm");
    type QuantityOfLight = Real (final quantity="QuantityOfLight", final unit=
            "lm.s");
    type Luminance = Real (final quantity="Luminance", final unit="cd/m2");
    type LuminousExitance = Real (final quantity="LuminousExitance", final unit=
            "lm/m2");
    type Illuminance = Real (final quantity="Illuminance", final unit="lx");
    type LightExposure = Real (final quantity="LightExposure", final unit="lx.s");
    type LuminousEfficacy = Real (final quantity="LuminousEfficacy", final unit=
            "lm/W");
    type SpectralLuminousEfficacy = Real (final quantity=
            "SpectralLuminousEfficacy", final unit="lm/W");
    type LuminousEfficiency = Real (final quantity="LuminousEfficiency", final unit=
               "1");
    type SpectralLuminousEfficiency = Real (final quantity=
            "SpectralLuminousEfficiency", final unit="1");
    type CIESpectralTristimulusValues = Real (final quantity=
            "CIESpectralTristimulusValues", final unit="1");
    type ChromaticityCoordinates = Real (final quantity="CromaticityCoordinates",
            final unit="1");
    type SpectralAbsorptionFactor = Real (final quantity=
            "SpectralAbsorptionFactor", final unit="1");
    type SpectralReflectionFactor = Real (final quantity=
            "SpectralReflectionFactor", final unit="1");
    type SpectralTransmissionFactor = Real (final quantity=
            "SpectralTransmissionFactor", final unit="1");
    type SpectralRadianceFactor = Real (final quantity="SpectralRadianceFactor",
          final unit="1");
    type LinearAttenuationCoefficient = Real (final quantity=
            "AttenuationCoefficient", final unit="m-1");
    type LinearAbsorptionCoefficient = Real (final quantity=
            "LinearAbsorptionCoefficient", final unit="m-1");
    type MolarAbsorptionCoefficient = Real (final quantity=
            "MolarAbsorptionCoefficient", final unit="m2/mol");
    type RefractiveIndex = Real (final quantity="RefractiveIndex", final unit="1");
    // Acoustics (chapter 7 of ISO 31-1992)
    type StaticPressure = AbsolutePressure;
    type SoundPressure = StaticPressure;
    type SoundParticleDisplacement = Real (final quantity="Length", final unit=
            "m");
    type SoundParticleVelocity = Real (final quantity="Velocity", final unit=
            "m/s");
    type SoundParticleAcceleration = Real (final quantity="Acceleration", final unit=
               "m/s2");
    type VelocityOfSound = Real (final quantity="Velocity", final unit="m/s");
    type SoundEnergyDensity = Real (final quantity="EnergyDensity", final unit=
            "J/m3");
    type SoundPower = Real (final quantity="Power", final unit="W");
    type SoundIntensity = Real (final quantity="SoundIntensity", final unit=
            "W/m2");
    type AcousticImpedance = Real (final quantity="AcousticImpedance", final unit=
           "Pa.s/m3");
    type SpecificAcousticImpedance = Real (final quantity=
            "SpecificAcousticImpedance", final unit="Pa.s/m");
    type MechanicalImpedance = Real (final quantity="MechanicalImpedance", final unit=
               "N.s/m");
    type SoundPressureLevel = Real (final quantity="SoundPressureLevel", final unit=
               "dB");
    type SoundPowerLevel = Real (final quantity="SoundPowerLevel", final unit=
            "dB");
    type DissipationCoefficient = Real (final quantity="DissipationCoefficient",
          final unit="1");
    type ReflectionCoefficient = Real (final quantity="ReflectionCoefficient",
          final unit="1");
    type TransmissionCoefficient = Real (final quantity="TransmissionCoefficient",
            final unit="1");
    type AcousticAbsorptionCoefficient = Real (final quantity=
            "AcousticAbsorptionCoefficient", final unit="1");
    type SoundReductionIndex = Real (final quantity="SoundReductionIndex", final unit="dB");
    type EquivalentAbsorptionArea = Real (final quantity="Area", final unit="m2");
    type ReverberationTime = Real (final quantity="Time", final unit="s");
    type LoudnessLevel = Real (final quantity="LoudnessLevel", final unit="phon");
    type Loudness = Real (final quantity="Loudness", final unit="sone");
    // Physical chemistry and molecular physics (chapter 8 of ISO 31-1992)
    type RelativeAtomicMass = Real (final quantity="RelativeAtomicMass", final unit="1");
    type RelativeMolecularMass = Real (final quantity="RelativeMolecularMass",
          final unit="1");
    type NumberOfMolecules = Real (final quantity="NumberOfMolecules", final unit="1");
    type AmountOfSubstance = Real (
        final quantity="AmountOfSubstance",
        final unit="mol",
        min=0);
    type Molality = Real (final quantity="Molality", final unit="mol/kg");
    type MolalConcentration = Molality;
    type MolarMass = Real (final quantity="MolarMass", final unit="kg/mol", min=0);
    type MolarVolume = Real (final quantity="MolarVolume", final unit="m3/mol", min=0);
    type MolarDensity = Real (final quantity="MolarDensity", unit="mol/m3");
    type Molarity = MolarDensity;
    type MolarConcentration = MolarDensity;
    type MolarEnergy = Real (final quantity="MolarEnergy", final unit="J/mol", nominal=2e4);
    type MolarInternalEnergy = MolarEnergy;
    type MolarHeatCapacity = Real (final quantity="MolarHeatCapacity", final unit="J/(mol.K)");
    type MolarEntropy = Real (final quantity="MolarEntropy", final unit="J/(mol.K)");
    type MolarEnthalpy = MolarEnergy;
    type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit="mol/s");
    type NumberDensityOfMolecules = Real (final quantity=
            "NumberDensityOfMolecules", final unit="m-3");
    type MolecularConcentration = Real (final quantity="MolecularConcentration",
          final unit="m-3");
    type MassConcentration = Real (final quantity="MassConcentration", final unit=
           "kg/m3");
    type MassFraction = Real (final quantity="MassFraction", final unit="1",
                              min=0, max=1);
    type Concentration = Real (final quantity="Concentration", final unit=
            "mol/m3");
    type VolumeFraction = Real (final quantity="VolumeFraction", final unit="1");
    type MoleFraction = Real (final quantity="MoleFraction", final unit="1",
                              min = 0, max = 1);
    type ChemicalPotential = Real (final quantity="ChemicalPotential", final unit=
           "J/mol");
    type AbsoluteActivity = Real (final quantity="AbsoluteActivity", final unit=
            "1");
    type PartialPressure = AbsolutePressure;
    type Fugacity = Real (final quantity="Fugacity", final unit="Pa");
    type StandardAbsoluteActivity = Real (final quantity=
            "StandardAbsoluteActivity", final unit="1");
    type ActivityCoefficient = Real (final quantity="ActivityCoefficient", final unit=
               "1");
    type ActivityOfSolute = Real (final quantity="ActivityOfSolute", final unit=
            "1");
    type ActivityCoefficientOfSolute = Real (final quantity=
            "ActivityCoefficientOfSolute", final unit="1");
    type StandardAbsoluteActivityOfSolute = Real (final quantity=
            "StandardAbsoluteActivityOfSolute", final unit="1");
    type ActivityOfSolvent = Real (final quantity="ActivityOfSolvent", final unit=
           "1");
    type OsmoticCoefficientOfSolvent = Real (final quantity=
            "OsmoticCoefficientOfSolvent", final unit="1");
    type StandardAbsoluteActivityOfSolvent = Real (final quantity=
            "StandardAbsoluteActivityOfSolvent", final unit="1");
    type OsmoticPressure = Real (
        final quantity="Pressure",
        final unit="Pa",
        displayUnit="bar",
        min=0);
    type StoichiometricNumber = Real (final quantity="StoichiometricNumber",
          final unit="1");
    type Affinity = Real (final quantity="Affinity", final unit="J/mol");
    type MassOfMolecule = Real (final quantity="Mass", final unit="kg");
    type ElectricDipoleMomentOfMolecule = Real (final quantity=
            "ElectricDipoleMomentOfMolecule", final unit="C.m");
    type ElectricPolarizabilityOfAMolecule = Real (final quantity=
            "ElectricPolarizabilityOfAMolecule", final unit="C.m2/V");
    type MicrocanonicalPartitionFunction = Real (final quantity=
            "MicrocanonicalPartitionFunction", final unit="1");
    type CanonicalPartitionFunction = Real (final quantity=
            "CanonicalPartitionFunction", final unit="1");
    type GrandCanonicalPartitionFunction = Real (final quantity=
            "GrandCanonicalPartitionFunction", final unit="1");
    type MolecularPartitionFunction = Real (final quantity=
            "MolecularPartitionFunction", final unit="1");
    type StatisticalWeight = Real (final quantity="StatisticalWeight", final unit=
           "1");
    type MeanFreePath = Length;
    type DiffusionCoefficient = Real (final quantity="DiffusionCoefficient",
          final unit="m2/s");
    type ThermalDiffusionRatio = Real (final quantity="ThermalDiffusionRatio",
          final unit="1");
    type ThermalDiffusionFactor = Real (final quantity="ThermalDiffusionFactor",
          final unit="1");
    type ThermalDiffusionCoefficient = Real (final quantity=
            "ThermalDiffusionCoefficient", final unit="m2/s");
    type ElementaryCharge = Real (final quantity="ElementaryCharge", final unit=
            "C");
    type ChargeNumberOfIon = Real (final quantity="ChargeNumberOfIon", final unit=
           "1");
    type FaradayConstant = Real (final quantity="FaradayConstant", final unit=
            "C/mol");
    type IonicStrength = Molality;
    type DegreeOfDissociation = Real (final quantity="DegreeOfDissociation",
          final unit="1");
    type ElectrolyticConductivity = Real (final quantity=
            "ElectrolyticConductivity", final unit="S/m");
    type MolarConductivity = Real (final quantity="MolarConductivity", final unit=
           "S.m2/mol");
    type TransportNumberOfIonic = Real (final quantity="TransportNumberOfIonic",
          final unit="1");
    // Atomic and Nuclear Physics (chapter 9 of ISO 31-1992)
    type ProtonNumber = Real (final quantity="ProtonNumber", final unit="1");
    type NeutronNumber = Real (final quantity="NeutronNumber", final unit="1");
    type NucleonNumber = Real (final quantity="NucleonNumber", final unit="1");
    type AtomicMassConstant = Real (final quantity="Mass", final unit="kg");
    type MassOfElectron = Real (final quantity="Mass", final unit="kg");
    type MassOfProton = Real (final quantity="Mass", final unit="kg");
    type MassOfNeutron = Real (final quantity="Mass", final unit="kg");
    type HartreeEnergy = Real (final quantity="Energy", final unit="J");
    type MagneticMomentOfParticle = Real (final quantity=
            "MagneticMomentOfParticle", final unit="A.m2");
    type BohrMagneton = MagneticMomentOfParticle;
    type NuclearMagneton = MagneticMomentOfParticle;
    type GyromagneticCoefficient = Real (final quantity="GyromagneticCoefficient",
            final unit="A.m2/(J.s)");
    type GFactorOfAtom = Real (final quantity="GFactorOfAtom", final unit="1");
    type GFactorOfNucleus = Real (final quantity="GFactorOfNucleus", final unit=
            "1");
    type LarmorAngularFrequency = Real (final quantity="AngularFrequency", final unit=
               "s-1");
    type NuclearPrecessionAngularFrequency = Real (final quantity=
            "AngularFrequency", final unit="s-1");
    type CyclotronAngularFrequency = Real (final quantity="AngularFrequency",
          final unit="s-1");
    type NuclearQuadrupoleMoment = Real (final quantity="NuclearQuadrupoleMoment",
            final unit="m2");
    type NuclearRadius = Real (final quantity="Length", final unit="m");
    type ElectronRadius = Real (final quantity="Length", final unit="m");
    type ComptonWavelength = Real (final quantity="Length", final unit="m");
    type MassExcess = Real (final quantity="Mass", final unit="kg");
    type MassDefect = Real (final quantity="Mass", final unit="kg");
    type RelativeMassExcess = Real (final quantity="RelativeMassExcess", final unit=
               "1");
    type RelativeMassDefect = Real (final quantity="RelativeMassDefect", final unit=
               "1");
    type PackingFraction = Real (final quantity="PackingFraction", final unit="1");
    type BindingFraction = Real (final quantity="BindingFraction", final unit="1");
    type MeanLife = Real (final quantity="Time", final unit="s");
    type LevelWidth = Real (final quantity="LevelWidth", final unit="J");
    type Activity = Real (final quantity="Activity", final unit="Bq");
    type SpecificActivity = Real (final quantity="SpecificActivity", final unit=
            "Bq/kg");
    type DecayConstant = Real (final quantity="DecayConstant", final unit="s-1");
    type HalfLife = Real (final quantity="Time", final unit="s");
    type AlphaDisintegrationEnergy = Real (final quantity="Energy", final unit=
            "J");
    type MaximumBetaParticleEnergy = Real (final quantity="Energy", final unit=
            "J");
    type BetaDisintegrationEnergy = Real (final quantity="Energy", final unit="J");
    // Nuclear Reactions and Ionizing Radiations (chapter 10 of ISO 31-1992)
    type ReactionEnergy = Real (final quantity="Energy", final unit="J");
    type ResonanceEnergy = Real (final quantity="Energy", final unit="J");
    type CrossSection = Real (final quantity="Area", final unit="m2");
    type TotalCrossSection = Real (final quantity="Area", final unit="m2");
    type AngularCrossSection = Real (final quantity="AngularCrossSection", final unit=
               "m2/sr");
    type SpectralCrossSection = Real (final quantity="SpectralCrossSection",
          final unit="m2/J");
    type SpectralAngularCrossSection = Real (final quantity=
            "SpectralAngularCrossSection", final unit="m2/(sr.J)");
    type MacroscopicCrossSection = Real (final quantity="MacroscopicCrossSection",
            final unit="m-1");
    type TotalMacroscopicCrossSection = Real (final quantity=
            "TotalMacroscopicCrossSection", final unit="m-1");
    type ParticleFluence = Real (final quantity="ParticleFluence", final unit=
            "m-2");
    type ParticleFluenceRate = Real (final quantity="ParticleFluenceRate", final unit=
               "s-1.m2");
    type EnergyFluence = Real (final quantity="EnergyFluence", final unit="J/m2");
    type EnergyFluenceRate = Real (final quantity="EnergyFluenceRate", final unit=
           "W/m2");
    type CurrentDensityOfParticles = Real (final quantity=
            "CurrentDensityOfParticles", final unit="m-2.s-1");
    type MassAttenuationCoefficient = Real (final quantity=
            "MassAttenuationCoefficient", final unit="m2/kg");
    type MolarAttenuationCoefficient = Real (final quantity=
            "MolarAttenuationCoefficient", final unit="m2/mol");
    type AtomicAttenuationCoefficient = Real (final quantity=
            "AtomicAttenuationCoefficient", final unit="m2");
    type HalfThickness = Real (final quantity="Length", final unit="m");
    type TotalLinearStoppingPower = Real (final quantity=
            "TotalLinearStoppingPower", final unit="J/m");
    type TotalAtomicStoppingPower = Real (final quantity=
            "TotalAtomicStoppingPower", final unit="J.m2");
    type TotalMassStoppingPower = Real (final quantity="TotalMassStoppingPower",
          final unit="J.m2/kg");
    type MeanLinearRange = Real (final quantity="Length", final unit="m");
    type MeanMassRange = Real (final quantity="MeanMassRange", final unit="kg/m2");
    type LinearIonization = Real (final quantity="LinearIonization", final unit=
            "m-1");
    type TotalIonization = Real (final quantity="TotalIonization", final unit="1");
    type Mobility = Real (final quantity="Mobility", final unit="m2/(V.s)");
    type IonNumberDensity = Real (final quantity="IonNumberDensity", final unit=
            "m-3");
    type RecombinationCoefficient = Real (final quantity=
            "RecombinationCoefficient", final unit="m3/s");
    type NeutronNumberDensity = Real (final quantity="NeutronNumberDensity",
          final unit="m-3");
    type NeutronSpeed = Real (final quantity="Velocity", final unit="m/s");
    type NeutronFluenceRate = Real (final quantity="NeutronFluenceRate", final unit=
               "s-1.m-2");
    type TotalNeutronSourceDensity = Real (final quantity=
            "TotalNeutronSourceDensity", final unit="s-1.m-3");
    type SlowingDownDensity = Real (final quantity="SlowingDownDensity", final unit=
               "s-1.m-3");
    type ResonanceEscapeProbability = Real (final quantity=
            "ResonanceEscapeProbability", final unit="1");
    type Lethargy = Real (final quantity="Lethargy", final unit="1");
    type SlowingDownArea = Real (final quantity="Area", final unit="m2");
    type DiffusionArea = Real (final quantity="Area", final unit="m2");
    type MigrationArea = Real (final quantity="Area", final unit="m2");
    type SlowingDownLength = Real (final quantity="SLength", final unit="m");
    type DiffusionLength = Length;
    type MigrationLength = Length;
    type NeutronYieldPerFission = Real (final quantity="NeutronYieldPerFission",
          final unit="1");
    type NeutronYieldPerAbsorption = Real (final quantity=
            "NeutronYieldPerAbsorption", final unit="1");
    type FastFissionFactor = Real (final quantity="FastFissionFactor", final unit=
           "1");
    type ThermalUtilizationFactor = Real (final quantity=
            "ThermalUtilizationFactor", final unit="1");
    type NonLeakageProbability = Real (final quantity="NonLeakageProbability",
          final unit="1");
    type Reactivity = Real (final quantity="Reactivity", final unit="1");
    type ReactorTimeConstant = Real (final quantity="Time", final unit="s");
    type EnergyImparted = Real (final quantity="Energy", final unit="J");
    type MeanEnergyImparted = Real (final quantity="Energy", final unit="J");
    type SpecificEnergyImparted = Real (final quantity="SpecificEnergy", final unit=
               "Gy");
    type AbsorbedDose = Real (final quantity="AbsorbedDose", final unit="Gy");
    type DoseEquivalent = Real (final quantity="DoseEquivalent", final unit="Sv");
    type AbsorbedDoseRate = Real (final quantity="AbsorbedDoseRate", final unit=
            "Gy/s");
    type LinearEnergyTransfer = Real (final quantity="LinearEnergyTransfer",
          final unit="J/m");
    type Kerma = Real (final quantity="Kerma", final unit="Gy");
    type KermaRate = Real (final quantity="KermaRate", final unit="Gy/s");
    type MassEnergyTransferCoefficient = Real (final quantity=
            "MassEnergyTransferCoefficient", final unit="m2/kg");
    type Exposure = Real (final quantity="Exposure", final unit="C/kg");
    type ExposureRate = Real (final quantity="ExposureRate", final unit=
            "C/(kg.s)");
    // chapter 11 is not defined in ISO 31-1992

    // Characteristic Numbers (chapter 12 of ISO 31-1992)
    type ReynoldsNumber = Real (final quantity="ReynoldsNumber", final unit="1");
    type EulerNumber = Real (final quantity="EulerNumber", final unit="1");
    type FroudeNumber = Real (final quantity="FroudeNumber", final unit="1");
    type GrashofNumber = Real (final quantity="GrashofNumber", final unit="1");
    type WeberNumber = Real (final quantity="WeberNumber", final unit="1");
    type MachNumber = Real (final quantity="MachNumber", final unit="1");
    type KnudsenNumber = Real (final quantity="KnudsenNumber", final unit="1");
    type StrouhalNumber = Real (final quantity="StrouhalNumber", final unit="1");
    type FourierNumber = Real (final quantity="FourierNumber", final unit="1");
    type PecletNumber = Real (final quantity="PecletNumber", final unit="1");
    type RayleighNumber = Real (final quantity="RayleighNumber", final unit="1");
    type NusseltNumber = Real (final quantity="NusseltNumber", final unit="1");
    type BiotNumber = NusseltNumber;
    // The Biot number (Bi) is used when
    // the Nusselt number is reserved
    // for convective transport of heat.
    type StantonNumber = Real (final quantity="StantonNumber", final unit="1");
    type FourierNumberOfMassTransfer = Real (final quantity=
            "FourierNumberOfMassTransfer", final unit="1");
    type PecletNumberOfMassTransfer = Real (final quantity=
            "PecletNumberOfMassTransfer", final unit="1");
    type GrashofNumberOfMassTransfer = Real (final quantity=
            "GrashofNumberOfMassTransfer", final unit="1");
    type NusseltNumberOfMassTransfer = Real (final quantity=
            "NusseltNumberOfMassTransfer", final unit="1");
    type StantonNumberOfMassTransfer = Real (final quantity=
            "StantonNumberOfMassTransfer", final unit="1");
    type PrandtlNumber = Real (final quantity="PrandtlNumber", final unit="1");
    type SchmidtNumber = Real (final quantity="SchmidtNumber", final unit="1");
    type LewisNumber = Real (final quantity="LewisNumber", final unit="1");
    type MagneticReynoldsNumber = Real (final quantity="MagneticReynoldsNumber",
          final unit="1");
    type AlfvenNumber = Real (final quantity="AlfvenNumber", final unit="1");
    type HartmannNumber = Real (final quantity="HartmannNumber", final unit="1");
    type CowlingNumber = Real (final quantity="CowlingNumber", final unit="1");
    // Solid State Physics (chapter 13 of ISO 31-1992)
    type BraggAngle = Angle;
    type OrderOfReflexion = Real (final quantity="OrderOfReflexion", final unit=
            "1");
    type ShortRangeOrderParameter = Real (final quantity="RangeOrderParameter",
          final unit="1");
    type LongRangeOrderParameter = Real (final quantity="RangeOrderParameter",
          final unit="1");
    type DebyeWallerFactor = Real (final quantity="DebyeWallerFactor", final unit=
           "1");
    type CircularWavenumber = Real (final quantity="CircularWavenumber", final unit=
               "m-1");
    type FermiCircularWavenumber = Real (final quantity="FermiCircularWavenumber",
            final unit="m-1");
    type DebyeCircularWavenumber = Real (final quantity="DebyeCircularWavenumber",
            final unit="m-1");
    type DebyeCircularFrequency = Real (final quantity="AngularFrequency", final unit=
               "s-1");
    type DebyeTemperature = ThermodynamicTemperature;
    type SpectralConcentration = Real (final quantity="SpectralConcentration",
          final unit="s/m3");
    type GrueneisenParameter = Real (final quantity="GrueneisenParameter", final unit=
               "1");
    type MadelungConstant = Real (final quantity="MadelungConstant", final unit=
            "1");
    type DensityOfStates = Real (final quantity="DensityOfStates", final unit=
            "J-1/m-3");
    type ResidualResistivity = Real (final quantity="ResidualResistivity", final unit=
               "Ohm.m");
    type LorenzCoefficient = Real (final quantity="LorenzCoefficient", final unit=
           "V2/K2");
    type HallCoefficient = Real (final quantity="HallCoefficient", final unit=
            "m3/C");
    type ThermoelectromotiveForce = Real (final quantity=
            "ThermoelectromotiveForce", final unit="V");
    type SeebeckCoefficient = Real (final quantity="SeebeckCoefficient", final unit=
               "V/K");
    type PeltierCoefficient = Real (final quantity="PeltierCoefficient", final unit=
               "V");
    type ThomsonCoefficient = Real (final quantity="ThomsonCoefficient", final unit=
               "V/K");
    type RichardsonConstant = Real (final quantity="RichardsonConstant", final unit=
               "A/(m2.K2)");
    type FermiEnergy = Real (final quantity="Energy", final unit="eV");
    type GapEnergy = Real (final quantity="Energy", final unit="eV");
    type DonorIonizationEnergy = Real (final quantity="Energy", final unit="eV");
    type AcceptorIonizationEnergy = Real (final quantity="Energy", final unit=
            "eV");
    type ActivationEnergy = Real (final quantity="Energy", final unit="eV");
    type FermiTemperature = ThermodynamicTemperature;
    type ElectronNumberDensity = Real (final quantity="ElectronNumberDensity",
          final unit="m-3");
    type HoleNumberDensity = Real (final quantity="HoleNumberDensity", final unit=
           "m-3");
    type IntrinsicNumberDensity = Real (final quantity="IntrinsicNumberDensity",
          final unit="m-3");
    type DonorNumberDensity = Real (final quantity="DonorNumberDensity", final unit=
               "m-3");
    type AcceptorNumberDensity = Real (final quantity="AcceptorNumberDensity",
          final unit="m-3");
    type EffectiveMass = Mass;
    type MobilityRatio = Real (final quantity="MobilityRatio", final unit="1");
    type RelaxationTime = Time;
    type CarrierLifeTime = Time;
    type ExchangeIntegral = Real (final quantity="Energy", final unit="eV");
    type CurieTemperature = ThermodynamicTemperature;
    type NeelTemperature = ThermodynamicTemperature;
    type LondonPenetrationDepth = Length;
    type CoherenceLength = Length;
    type LandauGinzburgParameter = Real (final quantity="LandauGinzburgParameter",
            final unit="1");
    type FluxoidQuantum = Real (final quantity="FluxoidQuantum", final unit="Wb");
    type TimeAging = Real (final quantity="1/Modelica.Units.SI.Time",final unit="1/s");
    type ChargeAging = Real (final quantity="1/Modelica.Units.SI.ElectricCharge",final unit="1/(A.s)");
   // Other types not defined in ISO 31-1992
    type PerUnit = Real(unit = "1");
    type DimensionlessRatio = Real(unit = "1");
   // Complex types for electrical systems (not defined in ISO 31-1992)
    operator record ComplexCurrent =
      Complex(redeclare Modelica.Units.SI.Current re "Real part of complex current",
              redeclare Modelica.Units.SI.Current im "Imaginary part of complex current")
      "Complex electric current";
    operator record ComplexCurrentSlope =
      Complex(redeclare Modelica.Units.SI.CurrentSlope re "Real part of complex current slope",
              redeclare Modelica.Units.SI.CurrentSlope im "Imaginary part of complex current slope")
      "Complex current slope";
    operator record ComplexCurrentDensity =
      Complex(redeclare Modelica.Units.SI.CurrentDensity re "Real part of complex current density",
              redeclare Modelica.Units.SI.CurrentDensity im "Imaginary part of complex current density")
      "Complex electric current density";
    operator record ComplexElectricPotential =
      Complex(redeclare Modelica.Units.SI.ElectricPotential re "Imaginary part of complex electric potential",
              redeclare Modelica.Units.SI.ElectricPotential im "Real part of complex electric potential")
      "Complex electric potential";
    operator record ComplexPotentialDifference =
      Complex(redeclare Modelica.Units.SI.PotentialDifference re "Real part of complex potential difference",
              redeclare Modelica.Units.SI.PotentialDifference im "Imaginary part of complex potential difference")
      "Complex electric potential difference";
    operator record ComplexVoltage =
      Complex(redeclare Modelica.Units.SI.Voltage re "Imaginary part of complex voltage",
              redeclare Modelica.Units.SI.Voltage im "Real part of complex voltage")
      "Complex electric voltage";
    operator record ComplexVoltageSlope =
      Complex(redeclare Modelica.Units.SI.VoltageSlope re "Real part of complex voltage slope",
              redeclare Modelica.Units.SI.VoltageSlope im "Imaginary part of complex voltage slope")
      "Complex voltage slope";
    operator record ComplexElectricFieldStrength =
      Complex(redeclare Modelica.Units.SI.ElectricFieldStrength re "Real part of complex electric field strength",
              redeclare Modelica.Units.SI.ElectricFieldStrength im "Imaginary part of complex electric field strength")
      "Complex electric field strength";
    operator record ComplexElectricFluxDensity =
      Complex(redeclare Modelica.Units.SI.ElectricFluxDensity re "Real part of complex electric flux density",
              redeclare Modelica.Units.SI.ElectricFluxDensity im "Imaginary part of complex electric flux density")
      "Complex electric flux density";
    operator record ComplexElectricFlux =
      Complex(redeclare Modelica.Units.SI.ElectricFlux re "Real part of complex electric flux",
              redeclare Modelica.Units.SI.ElectricFlux im "Imaginary part of complex electric flux")
      "Complex electric flux";
    operator record ComplexMagneticFieldStrength =
      Complex(redeclare Modelica.Units.SI.MagneticFieldStrength re "Real part of complex magnetic field strength",
              redeclare Modelica.Units.SI.MagneticFieldStrength im "Imaginary part of complex magnetic field strength")
      "Complex magnetic field strength";
    operator record ComplexMagneticPotential =
      Complex(redeclare Modelica.Units.SI.MagneticPotential re "Real part of complex magnetic potential",
              redeclare Modelica.Units.SI.MagneticPotential im "Imaginary part of complex magnetic potential")
      "Complex magnetic potential";
    operator record ComplexMagneticPotentialDifference =
      Complex(redeclare Modelica.Units.SI.MagneticPotentialDifference re "Real part of complex magnetic potential difference",
              redeclare Modelica.Units.SI.MagneticPotentialDifference im "Imaginary part of complex magnetic potential difference")
      "Complex magnetic potential difference";
    operator record ComplexMagnetomotiveForce =
      Complex(redeclare Modelica.Units.SI.MagnetomotiveForce re "Real part of complex magnetomotive force",
              redeclare Modelica.Units.SI.MagnetomotiveForce im "Imaginary part of complex magnetomotive force")
      "Complex magnetomotive force";
    operator record ComplexMagneticFluxDensity =
      Complex(redeclare Modelica.Units.SI.MagneticFluxDensity re "Real part of complex magnetic flux density",
              redeclare Modelica.Units.SI.MagneticFluxDensity im "Imaginary part of complex magnetic flux density")
      "Complex magnetic flux density";
    operator record ComplexMagneticFlux =
      Complex(redeclare Modelica.Units.SI.MagneticFlux re "Real part of complex magnetic flux",
              redeclare Modelica.Units.SI.MagneticFlux im "Imaginary part of complex magnetic flux")
      "Complex magnetic flux";
    operator record ComplexReluctance =
      Complex(redeclare Modelica.Units.SI.Reluctance re "Real part of complex reluctance",
              redeclare Modelica.Units.SI.Reluctance im "Imaginary part of complex reluctance")
      "Complex reluctance"
      annotation (Documentation(info="<html>
<p>
Since magnetic material properties like reluctance and permeance often are anisotropic resp. salient,
a special operator instead of multiplication (compare: tensor vs. vector) is required.
<a href=\"modelica://Modelica.Magnetic.FundamentalWave\">Modelica.Magnetic.FundamentalWave</a> uses a
special record <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>
which is only valid in the rotor-fixed coordinate system.
</p>
<p>
<strong>Note:</strong> To avoid confusion, no magnetic material properties should be defined as Complex units.
</p>
</html>"));
    operator record ComplexImpedance =
      Complex(redeclare Resistance re "Real part of complex impedance (resistance)",
              redeclare Reactance im "Imaginary part of complex impedance (reactance)")
      "Complex impedance";
    operator record ComplexImpedancePerUnitLength =
      Complex(redeclare ResistancePerUnitLength re "Real part of complex impedance (resistance) per unit length",
              redeclare ReactancePerUnitLength im "Imaginary part of complex impedance (reactance) per unit length")
      "Complex impedance per unit length of wire/cable/line";
    operator record ComplexAdmittance =
      Complex(redeclare Conductance re "Real part of complex admittance (conductance)",
              redeclare Susceptance im "Imaginary part of complex admittance (susceptance)")
      "Complex admittance";
    operator record ComplexAdmittancePerUnitLength =
      Complex(redeclare ConductancePerUnitLength re "Real part of complex admittance (conductance) per unit length",
              redeclare SusceptancePerUnitLength im "Imaginary part of complex admittance (susceptance) per unit length")
      "Complex admittance per unit length of wire/cable/line";
    operator record ComplexPower =
      Complex(redeclare ActivePower re "Real part of complex apparent power (active power)",
              redeclare ReactivePower im "Imaginary part of complex apparent power (reactive power)")
      "Complex apparent power";
    operator record ComplexPerUnit =
      Complex(redeclare PerUnit re "Real part of complex per unit quantity",
              redeclare PerUnit im "Imaginary part of complex per unit quantity")
      "Complex per unit";
    annotation (Icon(graphics={Text(
            extent={{-80,80},{80,-78}},
            textColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.None,
            fontName="serif",
            textString="SI",
            textStyle={TextStyle.Italic})}),
                                     Documentation(info="<html>
<p>This package provides predefined types based on the international standard
on units.
</p>
<p>
For an introduction to the conventions used in this package, have a look at:
<a href=\"modelica://Modelica.Units.UsersGuide.Conventions\">Conventions</a>.
</p>
</html>"));
  end SI;

  package NonSI "Type definitions of non SI and other units"

    extends Modelica.Icons.Package;

    type Temperature_degC = Real (final quantity="ThermodynamicTemperature",
          final unit="degC")
      "Absolute temperature in degree Celsius (for relative temperature use Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue=true);
    type Temperature_degF = Real (final quantity="ThermodynamicTemperature",
          final unit="degF")
      "Absolute temperature in degree Fahrenheit (for relative temperature use Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue=true);
    type Temperature_degRk = Real (final quantity="ThermodynamicTemperature",
          final unit="degRk")
      "Absolute temperature in degree Rankine (for relative temperature use Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue=true);
    type Angle_deg = Real (final quantity="Angle", final unit="deg")
      "Angle in degree";
    type AngularVelocity_rpm = Real (final quantity="AngularVelocity", final unit=
               "rev/min")
      "Angular velocity in revolutions per minute. Alias unit names that are outside of the SI system: rpm, r/min, rev/min";
    type Velocity_kmh = Real (final quantity="Velocity", final unit="km/h")
      "Velocity in kilometres per hour";
    type Time_day = Real (final quantity="Time", final unit="d")
      "Time in days";
    type Time_hour = Real (final quantity="Time", final unit="h")
      "Time in hours";
    type Time_minute = Real (final quantity="Time", final unit="min")
      "Time in minutes";
    type Volume_litre = Real (final quantity="Volume", final unit="l")
      "Volume in litres";
    type ElectricCharge_Ah =
      Real (final quantity="ElectricCharge", final unit="A.h")
      "Electric charge in Ampere hours";
    type Energy_Wh =
         Real (final quantity="Energy", final unit="W.h")
      "Energy in Watt hours";
    type Energy_kWh = Real (final quantity="Energy", final unit="kW.h")
      "Energy in kilo watt hours";
    type Pressure_bar = Real (final quantity="Pressure", final unit="bar")
      "Absolute pressure in bar";
    type MassFlowRate_gps = Real (final quantity="MassFlowRate", final unit=
            "g/s") "Mass flow rate in gram per second";

    type Area_cm =   Real (final quantity="Area", final unit="cm2")
      "Area in cm";
    type PerArea_cm =Real (final quantity="PerArea", final unit="1/cm2")
      "Per Area in cm";
    type Area_cmPerVoltageSecond =
                     Real (final quantity="AreaPerVoltageSecond", final unit="cm2/(V.s)")
      "Area in cm per voltage second";

    annotation (Documentation(info="<html>
<p>
This package provides predefined types, such as <strong>Angle_deg</strong> (angle in
degree), <strong>AngularVelocity_rpm</strong> (angular velocity in revolutions per
minute) or <strong>Temperature_degF</strong> (temperature in degree Fahrenheit),
which are in common use but are not part of the international standard on
units according to ISO 31-1992 \"General principles concerning quantities,
units and symbols\" and ISO 1000-1992 \"SI units and recommendations for
the use of their multiples and of certain other units\".</p>
<p>If possible, the types in this package should not be used. Use instead
types of package <code>Modelica.Units.SI</code>. For more information on units, see also
the book of Francois Cardarelli <strong>Scientific Unit Conversion - A
Practical Guide to Metrication</strong> (Springer 1997).</p>
</html>"),
         Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Ellipse(
            extent={{-10,10},{10,-10}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{-60,10},{-40,-10}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{40,10},{60,-10}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid)}));
  end NonSI;

  package Conversions "Conversion functions to/from non SI units and type definitions of non SI units"

    extends Modelica.Icons.Package;

  function to_unit1 "Change the unit of a Real number to unit=\"1\""
    extends Modelica.Units.Icons.Conversion;
    input Real r "Real number";
    output Real result(unit="1") "Real number r with unit=\"1\"";
  algorithm
    result := r;
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Modelica.Units.Conversions.<strong>to_unit1</strong>(r);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Conversions.<strong>to_unit1</strong>(r)</code>\" returns r with unit=\"1\".
</p>
<h4>Example</h4>
<blockquote><pre>
Modelica.Units.SI.Velocity v = {3,2,1};
Real direction[3](unit=\"1\") = to_unit1(v);   // Automatically vectorized call of to_unit1
</pre></blockquote>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,86},{32,50}},
          textString="any",
          horizontalAlignment=TextAlignment.Left), Text(
          extent={{-36,-52},{86,-88}},
          horizontalAlignment=TextAlignment.Right,
          textString="1")}));
  end to_unit1;

    function to_degC "Convert from kelvin to degree Celsius"
      extends Modelica.Units.Icons.Conversion;
      input SI.Temperature Kelvin "Value in kelvin";
      output Modelica.Units.NonSI.Temperature_degC Celsius "Value in degree Celsius";
    algorithm
      Celsius := Kelvin + Modelica.Constants.T_zero;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="K"), Text(
              extent={{100,-20},{20,-100}},
              textString="degC")}));
    end to_degC;

    function from_degC "Convert from degree Celsius to kelvin"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Temperature_degC Celsius "Value in degree Celsius";
      output SI.Temperature Kelvin "Value in kelvin";
    algorithm
      Kelvin := Celsius - Modelica.Constants.T_zero;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="degC"), Text(
              extent={{100,-20},{20,-100}},
              textString="K")}));
    end from_degC;

    function to_degF "Convert from kelvin to degree Fahrenheit"
      extends Modelica.Units.Icons.Conversion;
      input SI.Temperature Kelvin "Value in kelvin";
      output Modelica.Units.NonSI.Temperature_degF Fahrenheit "Value in degree Fahrenheit";
    algorithm
      Fahrenheit := (Kelvin + Modelica.Constants.T_zero)*(9/5) + 32;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="K"), Text(
              extent={{100,-20},{20,-100}},
              textString="degF")}));
    end to_degF;

    function from_degF "Convert from degree Fahrenheit to kelvin"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Temperature_degF Fahrenheit "Value in degree Fahrenheit";
      output SI.Temperature Kelvin "Value in kelvin";
    algorithm
      Kelvin := (Fahrenheit - 32)*(5/9) - Modelica.Constants.T_zero;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="degF"), Text(
              extent={{100,-20},{20,-100}},
              textString="K"), Text(
              extent={{-20,100},{-100,20}},
              textString="degF")}));
    end from_degF;

    function to_degRk "Convert from kelvin to degree Rankine"
      extends Modelica.Units.Icons.Conversion;
      input SI.Temperature Kelvin "Value in kelvin";
      output Modelica.Units.NonSI.Temperature_degRk Rankine "Value in degree Rankine";
    algorithm
      Rankine := (9/5)*Kelvin;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="K"), Text(
              extent={{100,-32},{-18,-100}},
              textString="degRk")}));
    end to_degRk;

    function from_degRk "Convert from degree Rankine to kelvin"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Temperature_degRk Rankine "Value in degree Rankine";
      output SI.Temperature Kelvin "Value in kelvin";
    algorithm
      Kelvin := (5/9)*Rankine;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-8,100},{-100,42}},
              textString="degRk"), Text(
              extent={{100,-20},{20,-100}},
              textString="K")}));
    end from_degRk;

    function to_deg "Convert from radian to degree"
      extends Modelica.Units.Icons.Conversion;
      input SI.Angle radian "Value in radian";
      output Modelica.Units.NonSI.Angle_deg degree "Value in degree";
    algorithm
      degree := (180.0/Modelica.Constants.pi)*radian;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{10,100},{-100,46}},
              textString="rad"), Text(
              extent={{100,-44},{-10,-100}},
              textString="deg")}));
    end to_deg;

    function from_deg "Convert from degree to radian"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Angle_deg degree "Value in degree";
      output SI.Angle radian "Value in radian";
    algorithm
      radian := (Modelica.Constants.pi/180.0)*degree;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{4,100},{-102,46}},
              textString="deg"), Text(
              extent={{100,-32},{-18,-100}},
              textString="rad")}));
    end from_deg;

    function to_rpm "Convert from radian per second to revolutions per minute"
      extends Modelica.Units.Icons.Conversion;
      input SI.AngularVelocity rs "Value in radian per second";
      output Modelica.Units.NonSI.AngularVelocity_rpm rpm "Value in revolutions per minute";
    algorithm
      rpm := (30/Modelica.Constants.pi)*rs;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{30,100},{-100,50}},
              textString="rad/s"), Text(
              extent={{100,-52},{-40,-98}},
              textString="rev/min")}));
    end to_rpm;

    function from_rpm
      "Convert from revolutions per minute to radian per second"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.AngularVelocity_rpm rpm "Value in revolutions per minute";
      output SI.AngularVelocity rs "Value in radian per second";
    algorithm
      rs := (Modelica.Constants.pi/30)*rpm;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{14,100},{-102,56}},
              textString="rev/min"), Text(
              extent={{100,-56},{-32,-102}},
              textString="rad/s")}));
    end from_rpm;

    function to_kmh "Convert from metre per second to kilometre per hour"
      extends Modelica.Units.Icons.Conversion;
      input SI.Velocity ms "Value in metre per second";
      output Modelica.Units.NonSI.Velocity_kmh kmh "Value in kilometre per hour";
    algorithm
      kmh := 3.6*ms;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{8,100},{-100,58}},
              textString="m/s"), Text(
              extent={{100,-56},{-16,-100}},
              textString="km/h")}));
    end to_kmh;

    function from_kmh "Convert from kilometre per hour to metre per second"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Velocity_kmh kmh "Value in kilometre per hour";
      output SI.Velocity ms "Value in metre per second";
    algorithm
      ms := kmh/3.6;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{10,100},{-100,56}},
              textString="km/h"), Text(
              extent={{100,-50},{-20,-100}},
              textString="m/s")}));
    end from_kmh;

    function to_day "Convert from second to day"
      extends Modelica.Units.Icons.Conversion;
      input SI.Time s "Value in second";
      output Modelica.Units.NonSI.Time_day day "Value in day";
    algorithm
      day := s/86400;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-6,100},{-100,48}},
              textString="s"), Text(
              extent={{100,-48},{-10,-98}},
              textString="day")}));
    end to_day;

    function from_day "Convert from day to second"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Time_day day "Value in day";
      output SI.Time s "Value in second";
    algorithm
      s := 86400*day;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{10,100},{-100,52}},
              textString="day"), Text(
              extent={{100,-54},{20,-100}},
              textString="s")}));
    end from_day;

    function to_hour "Convert from second to hour"
      extends Modelica.Units.Icons.Conversion;
      input SI.Time s "Value in second";
      output Modelica.Units.NonSI.Time_hour hour "Value in hour";
    algorithm
      hour := s/3600;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{12,100},{-100,50}},
              textString="s"), Text(
              extent={{100,-56},{-20,-100}},
              textString="hour")}));
    end to_hour;

    function from_hour "Convert from hour to second"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Time_hour hour "Value in hour";
      output SI.Time s "Value in second";
    algorithm
      s := 3600*hour;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{12,100},{-100,58}},
              textString="hour"), Text(
              extent={{100,-50},{16,-100}},
              textString="s")}));
    end from_hour;

    function to_minute "Convert from second to minute"
      extends Modelica.Units.Icons.Conversion;
      input SI.Time s "Value in second";
      output Modelica.Units.NonSI.Time_minute minute "Value in minute";
    algorithm
      minute := s/60;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-26,100},{-100,52}},
              textString="s"), Text(
              extent={{100,-54},{-20,-100}},
              textString="min")}));
    end to_minute;

    function from_minute "Convert from minute to second"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Time_minute minute "Value in minute";
      output SI.Time s "Value in second";
    algorithm
      s := 60*minute;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{26,100},{-100,48}},
              textString="min"), Text(
              extent={{100,-46},{0,-100}},
              textString="s")}));
    end from_minute;

    function to_litre "Convert from cubic metre to litre"
      extends Modelica.Units.Icons.Conversion;
      input SI.Volume m3 "Value in cubic metre";
      output Modelica.Units.NonSI.Volume_litre litre "Value in litre";
    algorithm
      litre := 1000*m3;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{100,-56},{0,-100}},
              textString="litre"), Text(
              extent={{6,100},{-100,56}},
              textString="m3")}));
    end to_litre;

    function from_litre "Convert from litre to cubic metre"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Volume_litre litre "Value in litre";
      output SI.Volume m3 "Value in cubic metre";
    algorithm
      m3 := litre/1000;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-4,100},{-100,62}},
              textString="litre"), Text(
              extent={{100,-56},{-6,-100}},
              textString="m3")}));
    end from_litre;

    function from_Ah "Convert from Ampere hours to Coulomb"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.ElectricCharge_Ah AmpereHour "Value in ampere hours";
      output Modelica.Units.SI.ElectricCharge Coulomb "Value in coulomb";
    algorithm
      Coulomb := AmpereHour * 3600;

      annotation (Icon(graphics={Text(
              extent={{-2,100},{-100,48}},
              textString="Ah"), Text(
              extent={{100,-46},{0,-100}},
              textString="C")}));
    end from_Ah;

    function to_Ah "Convert from Coulomb to Ampere hours"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.SI.ElectricCharge Coulomb "Value in coulomb";
      output Modelica.Units.NonSI.ElectricCharge_Ah AmpereHour "Value in ampere hours";
    algorithm
      AmpereHour := Coulomb/3600;

      annotation (Icon(graphics={Text(
              extent={{-18,100},{-100,48}},
              textString="C"), Text(
              extent={{100,-48},{2,-100}},
              textString="Ah")}));
    end to_Ah;

    function from_Wh "Convert from watt hour to joule"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Energy_Wh WattHour "Value in watt hour";
      output Modelica.Units.SI.Energy Joule "Value in joule";
    algorithm
      Joule := WattHour * 3600;

      annotation (Icon(graphics={Text(
              extent={{-20,100},{-100,54}},
              textString="Wh"), Text(
              extent={{100,-38},{4,-100}},
              textString="J")}));
    end from_Wh;

    function to_Wh "Convert from joule to watt hour"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.SI.Energy Joule "Value in joule";
      output Modelica.Units.NonSI.Energy_Wh WattHour "Value in watt hour";
    algorithm
      WattHour := Joule/3600;

      annotation (Icon(graphics={Text(
              extent={{-30,100},{-100,48}},
              textString="J"), Text(
              extent={{100,-46},{-14,-100}},
              textString="Wh")}));
    end to_Wh;

    function to_kWh "Convert from joule to kilo watt hour"
      extends Modelica.Units.Icons.Conversion;
      input SI.Energy J "Value in joule";
      output Modelica.Units.NonSI.Energy_kWh kWh "Value in kWh";
    algorithm
      kWh := J/3.6e6;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,54}},
              textString="J"), Text(
              extent={{100,-50},{-10,-100}},
              textString="kWh")}));
    end to_kWh;

    function from_kWh "Convert from kilo watt hour to joule"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Energy_kWh kWh "Value in kWh";
      output SI.Energy J "Value in joule";
    algorithm
      J := 3.6e6*kWh;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{12,100},{-100,52}},
              textString="kWh"), Text(
              extent={{100,-44},{12,-100}},
              textString="J")}));
    end from_kWh;

    function to_bar "Convert from Pascal to bar"
      extends Modelica.Units.Icons.Conversion;
      input SI.Pressure Pa "Value in Pascal";
      output Modelica.Units.NonSI.Pressure_bar bar "Value in bar";
    algorithm
      bar := Pa/1e5;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-12,100},{-100,56}},
              textString="Pa"), Text(
              extent={{98,-52},{-4,-100}},
              textString="bar")}));
    end to_bar;

    function from_bar "Convert from bar to Pascal"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Pressure_bar bar "Value in bar";
      output SI.Pressure Pa "Value in Pascal";
    algorithm
      Pa := 1e5*bar;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{100,-56},{12,-100}},
              textString="Pa"), Text(
              extent={{2,100},{-100,52}},
              textString="bar")}));
    end from_bar;

    function to_gps "Convert from kilogram per second to gram per second"
      extends Modelica.Units.Icons.Conversion;
      input SI.MassFlowRate kgps "Value in kg/s";
      output Modelica.Units.NonSI.MassFlowRate_gps gps "Value in g/s";
    algorithm
      gps := 1000*kgps;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-12,100},{-100,60}},
              textString="kg/s"), Text(
              extent={{100,-46},{-6,-100}},
              textString="g/s")}));
    end to_gps;

    function from_gps "Convert from gram per second to kilogram per second"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.MassFlowRate_gps gps "Value in g/s";
      output SI.MassFlowRate kgps "Value in kg/s";
    algorithm
      kgps := gps/1000;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-8,100},{-100,54}},
              textString="g/s"), Text(
              extent={{100,-44},{-10,-100}},
              textString="kg/s")}));
    end from_gps;

    function from_Hz "Convert from Hz to rad/s"
      extends Modelica.Units.Icons.Conversion;
      input SI.Frequency f "Value in hertz";
      output SI.AngularVelocity w "Value in radian per second";

    algorithm
      w := 2*Modelica.Constants.pi*f;
      annotation (Inline=true,Icon(graphics={
                                    Text(
              extent={{2,100},{-100,52}},
              textString="Hz"), Text(
              extent={{100,-56},{12,-100}},
              textString="1/s")}));
    end from_Hz;

    function to_Hz "Convert from rad/s to Hz"
      extends Modelica.Units.Icons.Conversion;
      input SI.AngularVelocity w "Value in radian per second";
      output SI.Frequency f "Value in hertz";
    algorithm
      f := w/(2*Modelica.Constants.pi);
      annotation (Inline=true,Icon(graphics={
                                    Text(
              extent={{100,-52},{-2,-100}},
              textString="Hz"), Text(
              extent={{-12,100},{-100,56}},
              textString="1/s")}));
    end to_Hz;

    function to_cm2 "Convert from square metre to square centimetre"
      extends Modelica.Units.Icons.Conversion;
      input SI.Area m2 "Value in square metre";
      output Modelica.Units.NonSI.Area_cm cm2 "Value in square centimetre";
    algorithm
      cm2 := 10000*m2;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,58}},
              textString="m/s"), Text(
              extent={{100,-50},{-18,-100}},
              textString="cm2")}));
    end to_cm2;

    function from_cm2 "Convert from square centimetre to square metre"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Area_cm cm2 "Value in square centimetre";
      output SI.Area m2 "Value in square metre";
    algorithm
      m2 := 0.0001*cm2;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{2,100},{-100,58}},
              textString="cm2"), Text(
              extent={{100,-50},{-16,-98}},
              textString="m/s")}));
    end from_cm2;
    annotation (Documentation(info="<html>
<p>This package provides conversion functions from the non SI Units
defined in package <code>Modelica.Units.NonSI</code> to the
corresponding SI Units defined in package <code>Modelica.Units.SI</code> and vice
versa. It is recommended to use these functions in the following
way (note, that all functions have one Real input and one Real output
argument):</p>
<blockquote><pre>
<strong>import</strong> Modelica.Units.SI;
<strong>import</strong> Modelica.Units.Conversions.{from_degC, from_deg, from_rpm};
   ...
<strong>parameter</strong> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to kelvin
<strong>parameter</strong> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
<strong>parameter</strong> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                   // to radian per seconds
</pre></blockquote>

</html>"),   Icon(graphics={
          Polygon(
            points={{80,0},{20,20},{20,-20},{80,0}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{20,0}}, color={191,0,0})}));
  end Conversions;

  package Icons "Icons for Units"
    extends Modelica.Icons.IconsPackage;

    partial function Conversion "Base icon for conversion functions"

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={191,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{30,0}}, color={191,0,0}),
            Polygon(
              points={{90,0},{30,20},{30,-20},{90,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-115,155},{115,105}},
              textString="%name",
              textColor={0,0,255})}));
    end Conversion;
  end Icons;
  annotation (Icon(graphics={
      Polygon(
        fillColor = {128,128,128},
        pattern = LinePattern.None,
        fillPattern = FillPattern.Solid,
        points = {{-80,-40},{-80,-40},{-55,50},{-52.5,62.5},{-65,60},{-65,65},{-35,77.5},{-32.5,60},{-50,0},{-50,0},{-30,15},{-20,27.5},{-32.5,27.5},{-32.5,27.5},{-32.5,32.5},{-32.5,32.5},{2.5,32.5},{2.5,32.5},{2.5,27.5},{2.5,27.5},{-7.5,27.5},{-30,7.5},{-30,7.5},{-25,-25},{-17.5,-28.75},{-10,-25},{-5,-26.25},{-5,-32.5},{-16.25,-41.25},{-31.25,-43.75},{-40,-33.75},{-45,-5},{-45,-5},{-52.5,-10},{-52.5,-10},{-60,-40},{-60,-40}},
        smooth = Smooth.Bezier),
      Polygon(
        fillColor = {128,128,128},
        pattern = LinePattern.None,
        fillPattern = FillPattern.Solid,
        points = {{87.5,30},{62.5,30},{62.5,30},{55,33.75},{36.25,35},{16.25,25},{7.5,6.25},{11.25,-7.5},{22.5,-12.5},{22.5,-12.5},{6.25,-22.5},{6.25,-35},{16.25,-38.75},{16.25,-38.75},{21.25,-41.25},{21.25,-41.25},{45,-48.75},{47.5,-61.25},{32.5,-70},{12.5,-65},{7.5,-51.25},{21.25,-41.25},{21.25,-41.25},{16.25,-38.75},{16.25,-38.75},{6.25,-41.25},{-6.25,-50},{-3.75,-68.75},{30,-76.25},{65,-62.5},{63.75,-35},{27.5,-26.25},{22.5,-20},{27.5,-15},{27.5,-15},{30,-7.5},{30,-7.5},{27.5,-2.5},{28.75,11.25},{36.25,27.5},{47.5,30},{53.75,22.5},{51.25,8.75},{45,-6.25},{35,-11.25},{30,-7.5},{30,-7.5},{27.5,-15},{27.5,-15},{43.75,-16.25},{65,-6.25},{72.5,10},{70,20},{70,20},{80,20}},
        smooth = Smooth.Bezier)}), Documentation(info="<html>
<p>This package provides predefined types, such as <em>Mass</em>,
<em>Angle</em>, <em>Time</em>, based on the international standard
on units, e.g.,
</p>

<blockquote><pre>
<strong>type</strong> Angle = Real(<strong>final</strong> quantity = \"Angle\",
                  <strong>final</strong> unit     = \"rad\",
                  displayUnit   = \"deg\");
</pre></blockquote>

<p>
Some of the types are derived SI units that are utilized in package Modelica
(such as ComplexCurrent, which is a complex number where both the real and imaginary
part have the SI unit Ampere).
</p>

<p>
Furthermore, conversion functions from non SI-units to SI-units and vice versa
are provided in subpackage
<a href=\"modelica://Modelica.Units.Conversions\">Conversions</a>.
</p>

<p>
For an introduction how units are used in the Modelica Standard Library
with package Units, have a look at:
<a href=\"modelica://Modelica.Units.UsersGuide.HowToUseUnits\">How to use Units</a>.
</p>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>", revisions="<html>
<ul>
<li><em>May 25, 2011</em> by Stefan Wischhusen:<br>Added molar units for energy and enthalpy.</li>
<li><em>Jan. 27, 2010</em> by Christian Kral:<br>Added complex units.</li>
<li><em>Dec. 14, 2005</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>Add User&#39;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
<li><em>October 21, 2002</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Christian Schweiger:<br>Added new package <strong>Conversions</strong>. Corrected typo <em>Wavelength</em>.</li>
<li><em>June 6, 2000</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>Introduced the following new types<br>type Temperature = ThermodynamicTemperature;<br>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
<li><em>Oct. 27, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
<li><em>Sept. 18, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
<li><em>Aug 12, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
<li><em>June 29, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
<li><em>April 8, 1998</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br>Complete ISO 31 chapters realized.</li>
<li><em>Nov. 15, 1997</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Hubertus Tummescheit:<br>Some chapters realized.</li>
</ul>
</html>"));
end Units;
