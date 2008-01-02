package SIunits "Type definitions based on SI units according to ISO 31-1992" 
  extends Modelica.Icons.Library2;
  
  package Conversions 
    "Conversion functions to/from non SI units and type definitions of non SI units"
    
    
    extends Modelica.Icons.Library2;
    
    package NonSIunits "Type definitions of non SI units" 
      
      extends Modelica.Icons.Library2;
      
      type Temperature_degC = Real (final quantity="ThermodynamicTemperature",
            final unit="degC");
      type Temperature_degF = Real (final quantity="ThermodynamicTemperature",
            final unit="degF");
      type Temperature_degRk = Real (final quantity="ThermodynamicTemperature",
            final unit="degRk");
      type Angle_deg = Real (final quantity="Angle", final unit="deg");
      type AngularVelocity_rpm = Real (final quantity="AngularVelocity", final unit
            =    "rev/min");
      type Velocity_kmh = Real (final quantity="Velocity", final unit="km/h");
      type Time_day = Real (final quantity="Time", final unit="d");
      type Time_hour = Real (final quantity="Time", final unit="h");
      type Time_minute = Real (final quantity="Time", final unit="min");
      type Volume_litre = Real (final quantity="Volume", final unit="l");
      type Energy_kWh = Real (final quantity="Energy", final unit="kWh");
      type Pressure_bar = Real (final quantity="Pressure", final unit="bar");
      type MassFlowRate_gps = Real (final quantity="MassFlowRate", final unit=
              "g/s");
      
      annotation( Documentation(info="<HTML>
<p>
This package provides predefined types, such as <b>Angle_deg</b> (angle in
degree), <b>AngularVelocity_rpm</b> (angular velocity in revolutions per
minute) or <b>Temperature_degF</b> (temperature in degree Fahrenheit),
which are in common use but are not part of the international standard on
units according to ISO 31-1992 \"General principles concerning quantities,
units and symbols\" and ISO 1000-1992 \"SI units and recommendations for
the use of their multiples and of certain other units\".</p>

<p>If possible, the types in this package should not be used. Use instead
types of package Modelica.SIunits. For more information on units, see also
the book of Francois Cardarelli <b>Scientific Unit Conversion - A
Practical Guide to Metrication</b> (Springer 1997).</p>

<p>Some units, such as <b>Temperature_degC/Temp_C</b> are both defined in
Modelica.SIunits and in Modelica.Conversions.NonSIunits. The reason is that these
definitions have been placed erroneously in Modelica.SIunits although they
are not SIunits. For backward compatibility, these type definitions are
still kept in Modelica.SIunits.</p>

</HTML>
"), Icon(Text(
            extent=[-66, -13; 52, -67],
            string="[rev/min]",
            style(color=0))));
    end NonSIunits;
    
    function to_degC "Convert from Kelvin to °Celsius" 
      extends ConversionIcon;
      input Temperature Kelvin "Kelvin value";
      output NonSIunits.Temperature_degC Celsius "Celsius value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="K"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="°C")));
    algorithm 
      Celsius := Kelvin + Modelica.Constants.T_zero;
    end to_degC;
    
    function from_degC "Convert from °Celsius to Kelvin" 
      extends ConversionIcon;
      input NonSIunits.Temperature_degC Celsius "Celsius value";
      output Temperature Kelvin "Kelvin value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="°C"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="K")));
    algorithm 
      Kelvin := Celsius - Modelica.Constants.T_zero;
    end from_degC;
    
    function to_degF "Convert from Kelvin to °Fahrenheit" 
      extends ConversionIcon;
      input Temperature Kelvin "Kelvin value";
      output NonSIunits.Temperature_degF Fahrenheit "Fahrenheit value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="K"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="°F")));
    algorithm 
      Fahrenheit := (Kelvin + Modelica.Constants.T_zero)*(9/5) + 32;
    end to_degF;
    
    function from_degF "Convert from °Fahrenheit to Kelvin" 
      extends ConversionIcon;
      input NonSIunits.Temperature_degF Fahrenheit "Fahrenheit value";
      output Temperature Kelvin "Kelvin value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="°F"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="K")));
    algorithm 
      Kelvin := (Fahrenheit - 32)*(5/9) - Modelica.Constants.T_zero;
    end from_degF;
    
    function to_degRk "Convert from Kelvin to °Rankine" 
      extends ConversionIcon;
      input Temperature Kelvin "Kelvin value";
      output NonSIunits.Temperature_degRk Rankine "Rankine value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="K"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="°Rk")));
    algorithm 
      Rankine := (9/5)*Kelvin;
    end to_degRk;
    
    function from_degRk "Convert from °Rankine to Kelvin" 
      extends ConversionIcon;
      input NonSIunits.Temperature_degRk Rankine "Rankine value";
      output Temperature Kelvin "Kelvin value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="°Rk"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="K")));
    algorithm 
      Kelvin := (5/9)*Rankine;
    end from_degRk;
    
    function to_deg "Convert from radian to degree" 
      extends ConversionIcon;
      input Angle radian "radian value";
      output NonSIunits.Angle_deg degree "degree value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="rad"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="deg")));
    algorithm 
      degree := (180.0/Modelica.Constants.pi)*radian;
    end to_deg;
    
    function from_deg "Convert from degree to radian" 
      extends ConversionIcon;
      input NonSIunits.Angle_deg degree "degree value";
      output Angle radian "radian value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="deg"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="rad")));
    algorithm 
      radian := (Modelica.Constants.pi/180.0)*degree;
    end from_deg;
    
    function to_rpm "Convert from radian per second to revolutions per minute" 
      extends ConversionIcon;
      input AngularVelocity rs "radian per second value";
      output NonSIunits.AngularVelocity_rpm rpm "revolutions per minute value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="rad/s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="rev/min")));
    algorithm 
      rpm := (30/Modelica.Constants.pi)*rs;
    end to_rpm;
    
    function from_rpm 
      "Convert from revolutions per minute to radian per second" 
      extends ConversionIcon;
      input NonSIunits.AngularVelocity_rpm rpm "revolutions per minute value";
      output AngularVelocity rs "radian per second value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="rev/min"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="rad/s")));
    algorithm 
      rs := (Modelica.Constants.pi/30)*rpm;
    end from_rpm;
    
    function to_kmh "Convert from metre per second to kilometre per hour" 
      extends ConversionIcon;
      input Velocity ms "metre per second value";
      output NonSIunits.Velocity_kmh kmh "kilometre per hour value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="m/s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="km/h")));
    algorithm 
      kmh := 3.6*ms;
    end to_kmh;
    
    function from_kmh "Convert from kilometre per hour to metre per second" 
      extends ConversionIcon;
      input NonSIunits.Velocity_kmh kmh "kilometre per hour value";
      output Velocity ms "metre per second value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="km/h"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="m/s")));
    algorithm 
      ms := kmh/3.6;
    end from_kmh;
    
    function to_day "Convert from second to day" 
      extends ConversionIcon;
      input Time s "second value";
      output NonSIunits.Time_day day "day value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="day")));
    algorithm 
      day := s/86400;
    end to_day;
    
    function from_day "Convert from day to second" 
      extends ConversionIcon;
      input NonSIunits.Time_day day "day value";
      output Time s "second value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="day"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="s")));
    algorithm 
      s := 86400*day;
    end from_day;
    
    function to_hour "Convert from second to hour" 
      extends ConversionIcon;
      input Time s "second value";
      output NonSIunits.Time_hour hour "hour value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="hour")));
    algorithm 
      hour := s/3600;
    end to_hour;
    
    function from_hour "Convert from hour to second" 
      extends ConversionIcon;
      input NonSIunits.Time_hour hour "hour value";
      output Time s "second value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="hour"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="s")));
    algorithm 
      s := 3600*hour;
    end from_hour;
    
    function to_minute "Convert from second to minute" 
      extends ConversionIcon;
      input Time s "second value";
      output NonSIunits.Time_minute minute "minute value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="minute")));
    algorithm 
      minute := s/60;
    end to_minute;
    
    function from_minute "Convert from minute to second" 
      extends ConversionIcon;
      input NonSIunits.Time_minute minute "minute value";
      output Time s "second value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="minute"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="s")));
    algorithm 
      s := 60*minute;
    end from_minute;
    
    function to_litre "Convert from cubic metre to litre" 
      extends ConversionIcon;
      input Volume m3 "cubic metre value";
      output NonSIunits.Volume_litre litre "litre value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="m3"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="litre")));
    algorithm 
      litre := 1000*m3;
    end to_litre;
    
    function from_litre "Convert from litre to cubic metre" 
      extends ConversionIcon;
      input NonSIunits.Volume_litre litre "litre value";
      output Volume m3 "cubic metre value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="litre"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="m3")));
    algorithm 
      m3 := litre/1000;
    end from_litre;
    
    function to_kWh "Convert from Joule to kilo Watt hour" 
      extends ConversionIcon;
      input Energy J "Joule value";
      output NonSIunits.Energy_kWh kWh "kWh value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="J"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="kWh")));
    algorithm 
      kWh := J/3.6e6;
    end to_kWh;
    
    function from_kWh "Convert from kilo Watt hour to Joule" 
      extends ConversionIcon;
      input NonSIunits.Energy_kWh kWh "kWh value";
      output Energy J "Joule value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="kWh"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="J")));
    algorithm 
      J := 3.6e6*kWh;
    end from_kWh;
    
    function to_bar "Convert from Pascal to bar" 
      extends ConversionIcon;
      input Pressure Pa "Pascal value";
      output NonSIunits.Pressure_bar bar "bar value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="Pa"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="bar")));
    algorithm 
      bar := Pa/1e5;
    end to_bar;
    
    function from_bar "Convert from bar to Pascal" 
      extends ConversionIcon;
      input NonSIunits.Pressure_bar bar "bar value";
      output Pressure Pa "Pascal value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="bar"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="Pa")));
    algorithm 
      Pa := 1e5*bar;
    end from_bar;
    
    function to_gps "Convert from kilogram per second to gram per second" 
      extends ConversionIcon;
      input MassFlowRate kgps "kg/s value";
      output NonSIunits.MassFlowRate_gps gps "g/s value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="kg/s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="g/s")));
    algorithm 
      gps := 1000*kgps;
    end to_gps;
    
    function from_gps "Convert from gram per second to kilogram per second" 
      extends ConversionIcon;
      input NonSIunits.MassFlowRate_gps gps "g/s value";
      output MassFlowRate kgps "kg/s value";
      annotation( Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="g/s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="kg/s")));
    algorithm 
      kgps := gps/1000;
    end from_gps;
    
    partial function ConversionIcon "Base icon for conversion functions" 
      annotation( Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(color=42, fillColor=7)),
          Line(points=[-90, 0; 30, 0], style(color=42)),
          Polygon(points=[90, 0; 30, 20; 30, -20; 90, 0], style(color=42,
                fillColor=42)),
          Text(extent=[-115, 155; 115, 105], string="%name")));
    end ConversionIcon;
    
    annotation( Icon(
        Text(
          extent=[-33, -7; -92, -67],
          string="°C",
          style(color=0, thickness=4)),
        Text(
          extent=[82, -7; 22, -67],
          string="K",
          style(color=0)),
        Line(points=[-26, -36; 6, -36], style(color=0)),
        Polygon(points=[6, -28; 6, -45; 26, -37; 6, -28], style(pattern=0,
              fillColor=0))), Documentation(info="<HTML>
<p>This package provides conversion functions from the non SI Units
defined in package Modelica.SIunits.Conversions.NonSIunits to the
corresponding SI Units defined in package Modelica.SIunits and vice
versa. It is recommended to use these functions in the following
way:</p>

<pre>
  <b>import</b> SI = Modelica.SIunits;
  <b>import</b> Modelica.SIunits.Conversions.*;
     ...
  <b>parameter</b> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to Kelvin
  <b>parameter</b> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
  <b>parameter</b> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                      // to radian per seconds
</pre>

<p>The following conversion functions are provided. Note, that all
of them have one Real input and one Real output argument:</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr>
<th>Function</th>
<th>Description</th>
</tr>

<tr>
<td><b>to_degC</b><br>
<b>from_degC</b></td>
<td>Convert from Kelvin to degree Celsius<br>
Convert from degree Celsius to Kelvin</td>
</tr>

<tr>
<td><b>to_degF</b><br>
<b>from_degF</b></td>
<td>Convert from Kelvin to degree Fahrenheit<br>
Convert from degree Fahrenheit to Kelvin</td>
</tr>

<tr>
<td><b>to_degRk</b><br>
<b>from_degRk</b></td>
<td>Convert from Kelvin to degree Rankine<br>
Convert from degree Rankine to Kelvin</td>
</tr>

<tr>
<td><b>to_deg</b><br>
<b>from_deg</b></td>
<td>Convert from radian to degree<br>
Convert from degree to radian</td>
</tr>

<tr>
<td><b>to_rpm</b><br>
<b>from_rpm</b></td>
<td>Convert from radian per second to revolutions per minute<br>
Convert from revolutions per minute to radian per second</td>
</tr>

<tr>
<td><b>to_kmh</b><br>
<b>from_kmh</b></td>
<td>Convert from metre per second to kilometre per hour<br>
Convert from kilometre per hour to metre per second</td>
</tr>

<tr>
<td><b>to_day</b><br>
<b>from_day</b></td>
<td>Convert from second to day<br>
Convert from day to second</td>
</tr>

<tr>
<td><b>to_hour</b><br>
<b>from_hour</b></td>
<td>Convert from second to hour<br>
Convert from hour to second</td>
</tr>

<tr>
<td><b>to_minute</b><br>
<b>from_minute</b></td>
<td>Convert from second to minute<br>
Convert from minute to second</td>
</tr>

<tr>
<td><b>to_litre</b><br>
<b>from_litre</b></td>
<td>Convert from cubic metre to litre<br>
Convert from litre to cubic metre</td>
</tr>

<tr>
<td><b>to_kWh</b><br>
<b>from_kWh</b></td>
<td>Convert from Joule to kilo Watt hour<br>
Convert from kilo Watt hour to Joule</td>
</tr>

<tr>
<td><b>to_bar</b><br>
<b>from_bar</b></td>
<td>Convert from Pascal to bar<br>
Convert from bar to Pascal</td>
</tr>

<tr>
<td><b>to_gps</b><br>
<b>from_gps</b></td>
<td>Convert from kilogram per second to gram per second<br>
Convert from gram per second to kilogram per second</td>
</tr>
</table>

<p>There is the additional <b>partial</b> function <b>ConversionIcon</b>
in this package. It contains just the base icon for all the conversion
functions.</p>

</HTML>
"));
  end Conversions;
  
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
  type Breadth = Distance;
  type Height = Distance;
  type Thickness = Distance;
  type Radius = Distance;
  type Diameter = Distance;
  type Area = Real (final quantity="Area", final unit="m2");
  type Volume = Real (final quantity="Volume", final unit="m3");
  type Time = Real (final quantity="Time", final unit="s");
  type Duration = Time;
  type AngularVelocity = Real (
      final quantity="AngularVelocity",
      final unit="rad/s",
      displayUnit="rev/min");
  type AngularAcceleration = Real (final quantity="AngularAcceleration", final unit
        =    "rad/s2");
  type Velocity = Real (final quantity="Velocity", final unit="m/s");
  type Acceleration = Real (final quantity="Acceleration", final unit="m/s2");
  
  // Periodic and related phenomens (chapter 2 of ISO 31-1992)
  type Period = Real (final quantity="Time", final unit="s");
  type Frequency = Real (final quantity="Frequency", final unit="Hz");
  type AngularFrequency = Real (final quantity="AngularFrequency", final unit=
          "s-1");
  type Wavelength = Real (final quantity="Wavelength", final unit="m");
  type Wavelenght = Wavelength;
  // For compatibility reasons only
  type WaveNumber = Real (final quantity="WaveNumber", final unit="m-1");
  type CircularWaveNumber = Real (final quantity="CircularWaveNumber", final unit
        =    "rad/m");
  type AmplitudeLevelDifference = Real (final quantity=
          "AmplitudeLevelDifference", final unit="dB");
  type PowerLevelDifference = Real (final quantity="PowerLevelDifference",
        final unit="dB");
  type DampingCoefficient = Real (final quantity="DampingCoefficient", final unit
        =    "s-1");
  type LogarithmicDecrement = Real (final quantity="LogarithmicDecrement",
        final unit="Np/S");
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
      min=0);
  type RelativeDensity = Real (
      final quantity="RelativeDensity",
      final unit="1",
      min=0);
  type SpecificVolume = Real (
      final quantity="SpecificVolume",
      final unit="m3/kg",
      min=0);
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
  type Weight = Force;
  type Torque = Real (final quantity="Torque", final unit="N.m");
  type MomentOfForce = Torque;
  type Pressure = Real (
      final quantity="Pressure",
      final unit="Pa",
      displayUnit="bar");
  type AbsolutePressure = Pressure (min=0);
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
  type SecondMomentOfArea = Real (final quantity="SecondMomentOfArea", final unit
        =    "m4");
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
  type AngularMomentumFlux = Real (final quantity="AngularMomentumFlux", final unit
        =    "N.m");
  
  // Heat (chapter 4 of ISO 31-1992)
  type ThermodynamicTemperature = Real (
      final quantity="ThermodynamicTemperature",
      final unit="K",
      min=  0,
      displayUnit="degC");
  type Temp_K = ThermodynamicTemperature;
  type Temperature = ThermodynamicTemperature;
  type CelsiusTemperature = Real (final quantity="CelsiusTemperature", final unit
        =    "degC");
  type Temp_C = CelsiusTemperature;
  type LinearExpansionCoefficient = Real (final quantity=
          "LinearExpansionCoefficient", final unit="1/K");
  type CubicExpansionCoefficient = Real (final quantity=
          "CubicExpansionCoefficient", final unit="1/K");
  type RelativePressureCoefficient = Real (final quantity=
          "RelativePressureCoefficient", final unit="1/K");
  type PressureCoefficient = Real (final quantity="PressureCoefficient", final unit
        =    "Pa/K");
  type Compressibility = Real (final quantity="Compressibility", final unit=
          "1/Pa");
  type IsothermalCompressibility = Compressibility;
  type IsentropicCompressibility = Compressibility;
  type Heat = Real (final quantity="Energy", final unit="J");
  type HeatFlowRate = Real (final quantity="Power", final unit="W");
  type HeatFlux = Real (final quantity="HeatFlux", final unit="W/m^2");
  type DensityOfHeatFlowRate = Real (final quantity="DensityOfHeatFlowRate",
        final unit="W/m2");
  type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit
        =    "W/(m.K)");
  type CoefficientOfHeatTransfer = Real (final quantity=
          "CoefficientOfHeatTransfer", final unit="W/(m2.K)");
  type SurfaceCoefficientOfHeatTransfer = CoefficientOfHeatTransfer;
  type ThermalInsulance = Real (final quantity="ThermalInsulance", final unit=
          "m2.K/W");
  type ThermalResistance = Real (final quantity="ThermalResistance", final unit
        ="K/W");
  type ThermalConductance = Real (final quantity="ThermalConductance", final unit
        =    "W/K");
  type ThermalDiffusivity = Real (final quantity="ThermalDiffusivity", final unit
        =    "m2/s");
  type HeatCapacity = Real (final quantity="HeatCapacity", final unit="J/K");
  type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
        final unit="J/(kg.K)");
  type SpecificHeatCapacityAtConstantPressure = SpecificHeatCapacity;
  type SpecificHeatCapacityAtConstantVolume = SpecificHeatCapacity;
  type SpecificHeatCapacityAtSaturation = SpecificHeatCapacity;
  type RatioOfSpecificHeatCapacities = Real (final quantity=
          "RatioOfSpecificHeatCapacities", final unit="1");
  type IsentropicExponent = Real (final quantity="IsentropicExponent", final unit
        =    "1");
  type Entropy = Real (final quantity="Entropy", final unit="J/K");
  type SpecificEntropy = Real (final quantity="SpecificEntropy", final unit=
          "J/(kg.K)");
  type InternalEnergy = Heat;
  type Enthalpy = Heat;
  type HelmholtzFreeEnergy = Heat;
  type GibbsFreeEnergy = Heat;
  type SpecificEnergy = Real (final quantity="SpecificEnergy", final unit=
          "J/kg");
  type SpecificInternalEnergy = SpecificEnergy;
  type SpecificEnthalpy = SpecificEnergy;
  type SpecificHelmholtzFreeEnergy = SpecificEnergy;
  type SpecificGibbsFreeEnergy = SpecificEnergy;
  type MassieuFunction = Real (final quantity="MassieuFunction", final unit=
          "J/K");
  type PlanckFunction = Real (final quantity="PlanckFunction", final unit="J/K");
  // added to ISO-chapter 4
  type DerDensityByEnthalpy = Real (final unit="kg.s^2/m^5");
  type DerDensityByPressure = Real (final unit="s^2/m^2");
  type DerDensityByTemperature = Real (final unit="kg/(m^3.K)");
  type DerEnthalpyByPressure = Real (final unit="J.m.s^2/kg^2");
  type DerEnergyByDensity = Real (final unit="J.m^3/kg");
  type DerEnergyByPressure = Real (final unit="J.m.s^2/kg");
  
  // Electricity and Magnetism (chapter 5 of ISO 31-1992)
  type ElectricCurrent = Real (final quantity="ElectricCurrent", final unit="A");
  type Current = ElectricCurrent;
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
  type ElectricPotential = Real (final quantity="ElectricPotential", final unit
        ="V");
  type Voltage = ElectricPotential;
  type PotentialDifference = ElectricPotential;
  type ElectromotiveForce = ElectricPotential;
  type ElectricFluxDensity = Real (final quantity="ElectricFluxDensity", final unit
        =    "C/m2");
  type ElectricFlux = Real (final quantity="ElectricFlux", final unit="C");
  type Capacitance = Real (
      final quantity="Capacitance",
      final unit="F",
      min=0);
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
  type MagneticPotentialDifference = Real (final quantity=
          "MagneticPotentialDifference", final unit="A");
  type MagnetomotiveForce = Real (final quantity="MagnetomotiveForce", final unit
        =    "A");
  type CurrentLinkage = Real (final quantity="CurrentLinkage", final unit="A");
  type MagneticFluxDensity = Real (final quantity="MagneticFluxDensity", final unit
        =    "T");
  type MagneticFlux = Real (final quantity="MagneticFlux", final unit="Wb");
  type MagneticVectorPotential = Real (final quantity="MagneticVectorPotential",
          final unit="Wb/m");
  type Inductance = Real (
      final quantity="Inductance",
      final unit="H");
  type SelfInductance = Inductance (
                                   min=0);
  type MutualInductance = Inductance;
  type CouplingCoefficient = Real (final quantity="CouplingCoefficient", final unit
        =    "1");
  type LeakageCoefficient = Real (final quantity="LeakageCoefficient", final unit
        =    "1");
  type Permeability = Real (final quantity="Permeability", final unit="H/m");
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
      final unit="Ohm",
      min=0);
  type Resistivity = Real (final quantity="Resistivity", final unit="Ohm.m");
  type Conductivity = Real (final quantity="Conductivity", final unit="S/m");
  type Reluctance = Real (final quantity="Reluctance", final unit="H-1");
  type Permeance = Real (final quantity="Permeance", final unit="H");
  type PhaseDifference = Real (
      final quantity="Angle",
      final unit="rad",
      displayUnit="deg");
  type Impedance = Resistance;
  type ModulusOfImpedance = Resistance;
  type Reactance = Resistance;
  type QualityFactor = Real (final quantity="QualityFactor", final unit="1");
  type LossAngle = Real (
      final quantity="Angle",
      final unit="rad",
      displayUnit="deg");
  type Conductance = Real (
      final quantity="Conductance",
      final unit="S",
      min=0);
  type Admittance = Conductance;
  type ModulusOfAdmittance = Conductance;
  type Susceptance = Conductance;
  type InstantaneousPower = Real (final quantity="Power", final unit="W");
  type ActivePower = Real (final quantity="Power", final unit="W");
  type ApparentPower = Real (final quantity="Power", final unit="VA");
  type ReactivePower = Real (final quantity="Power", final unit="var");
  type PowerFactor = Real (final quantity="PowerFactor", final unit="1");
  // added to ISO-chapter 5
  type Transconductance = Real (final quantity="Transconductance", final unit=
          "A/(V*V)");
  type InversePotential = Real (final quantity="InversePotential", final unit=
          "1/V");
  
  // Light and Related Electromagnetic Radiations (chapter 6 of ISO 31-1992)"
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
  type Radiance = Real (final quantity="Radiance", final unit="W/sr.m2");
  type RadiantExtiance = Real (final quantity="RadiantExtiance", final unit=
          "W/m2");
  type Irradiance = Real (final quantity="Irradiance", final unit="W/m2");
  type Emissivity = Real (final quantity="Emissivity", final unit="1");
  type SpectralEmissivity = Real (final quantity="SpectralEmissivity", final unit
        =    "1");
  type DirectionalSpectralEmissivity = Real (final quantity=
          "DirectionalSpectralEmissivity", final unit="1");
  type LuminousIntensity = Real (final quantity="LuminousIntensity", final unit
        ="cd");
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
  type LuminousEfficiency = Real (final quantity="LuminousEfficiency", final unit
        =    "1");
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
  type StaticPressure = Real (
      final quantity="Pressure",
      final unit="Pa",
      displayUnit="bar",
      min=0);
  type SoundPressure = StaticPressure;
  type SoundParticleDisplacement = Real (final quantity="Length", final unit=
          "m");
  type SoundParticleVelocity = Real (final quantity="Velocity", final unit=
          "m/s");
  type SoundParticleAcceleration = Real (final quantity="Acceleration", final unit
        =    "m/s2");
  type VelocityOfSound = Real (final quantity="Velocity", final unit="m/s");
  type SoundEnergyDensity = Real (final quantity="EnergyDensity", final unit=
          "J/m3");
  type SoundPower = Real (final quantity="Power", final unit="W");
  type SoundIntensity = Real (final quantity="SoundIntensity", final unit=
          "W/m2");
  type AcousticImpedance = Real (final quantity="AcousticImpedance", final unit
        ="Pa.s/m3");
  type SpecificAcousticImpedance = Real (final quantity=
          "SpecificAcousticImpedance", final unit="Pa.s/m");
  type MechanicalImpedance = Real (final quantity="MechanicalImpedance", final unit
        =    "N.s/m");
  type SoundPressureLevel = Real (final quantity="SoundPressureLevel", final unit
        =    "dB");
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
  type SoundReductionIndex = Real (final quantity="SoundReductionIndex", final unit
        =    "dB");
  type EquivalentAbsorptionArea = Real (final quantity="Area", final unit="m2");
  type ReverberationTime = Real (final quantity="Time", final unit="s");
  type LoundnessLevel = Real (final quantity="LoundnessLevel", final unit=
          "phon");
  type Loundness = Real (final quantity="Loundness", final unit="sone");
  
  // Physical chemistry and molecular physics (chapter 8 of ISO 31-1992)
  type RelativeAtomicMass = Real (final quantity="RelativeAtomicMass", final unit
        =    "1");
  type RelativeMolecularMass = Real (final quantity="RelativeMolecularMass",
        final unit="1");
  type NumberOfMolecules = Real (final quantity="NumberOfMolecules", final unit
        ="1");
  type AmountOfSubstance = Real (
      final quantity="AmountOfSubstance",
      final unit="mol",
      min=0);
  type MolarMass = Real (final quantity="MolarMass", final unit="kg/mol");
  type MolarVolume = Real (final quantity="MolarVolume", final unit="m3/mol");
  type MolarInternalEnergy = Real (final quantity="MolarInternalEnergy", final unit
        =    "J/mol");
  type MolarHeatCapacity = Real (final quantity="MolarHeatCapacity", final unit
        ="J/(mol.K)");
  type MolarEntropy = Real (final quantity="MolarEntropy", final unit=
          "J/(mol.K)");
  type NumberDensityOfMolecules = Real (final quantity=
          "NumberDensityOfMolecules", final unit="m-3");
  type MolecularConcentration = Real (final quantity="MolecularConcentration",
        final unit="m-3");
  type MassConcentration = Real (final quantity="MassConcentration", final unit
        ="kg/m3");
  type MassFraction = Real (final quantity="MassFraction", final unit="1");
  type Concentration = Real (final quantity="Concentration", final unit=
          "mol/m3");
  type VolumeFraction = Real (final quantity="VolumeFraction", final unit="1");
  type MoleFraction = Real (final quantity="MoleFraction", final unit="1");
  type ChemicalPotential = Real (final quantity="ChemicalPotential", final unit
        ="J/mol");
  type AbsoluteActivity = Real (final quantity="AbsoluteActivity", final unit=
          "1");
  type PartialPressure = Real (
      final quantity="Pressure",
      final unit="Pa",
      displayUnit="bar",
      min=0);
  type Fugacity = Real (final quantity="Fugacity", final unit="Pa");
  type StandardAbsoluteActivity = Real (final quantity=
          "StandardAbsoluteActivity", final unit="1");
  type ActivityCoefficient = Real (final quantity="ActivityCoefficient", final unit
        =    "1");
  type ActivityOfSolute = Real (final quantity="ActivityOfSolute", final unit=
          "1");
  type ActivityCoefficientOfSolute = Real (final quantity=
          "ActivityCoefficientOfSolute", final unit="1");
  type StandardAbsoluteActivityOfSolute = Real (final quantity=
          "StandardAbsoluteActivityOfSolute", final unit="1");
  type ActivityOfSolvent = Real (final quantity="ActivityOfSolvent", final unit
        ="1");
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
  type StatisticalWeight = Real (final quantity="StatisticalWeight", final unit
        ="1");
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
  type ChargeNumberOfIon = Real (final quantity="ChargeNumberOfIon", final unit
        ="1");
  type FaradayConstant = Real (final quantity="FaradayConstant", final unit=
          "C/mol");
  type IonicStrength = Real (final quantity="IonicStrength", final unit=
          "mol/kg");
  type DegreeOfDissociation = Real (final quantity="DegreeOfDissociation",
        final unit="1");
  type ElectrolyticConductivity = Real (final quantity=
          "ElectrolyticConductivity", final unit="S/m");
  type MolarConductivity = Real (final quantity="MolarConductivity", final unit
        ="S.m2/mol");
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
  type LarmorAngularFrequency = Real (final quantity="AngularFrequency", final unit
        =    "s-1");
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
  type RelativeMassExcess = Real (final quantity="RelativeMassExcess", final unit
        =    "1");
  type RelativeMassDefect = Real (final quantity="RelativeMassDefect", final unit
        =    "1");
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
  type AngularCrossSection = Real (final quantity="AngularCrossSection", final unit
        =    "m2/sr");
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
  type ParticleFluenceRate = Real (final quantity="ParticleFluenceRate", final unit
        =    "s-1.m2");
  type EnergyFluence = Real (final quantity="EnergyFluence", final unit="J/m2");
  type EnergyFluenceRate = Real (final quantity="EnergyFluenceRate", final unit
        ="W/m2");
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
  type Mobility = Real (final quantity="Mobility", final unit="m2/V.s");
  type IonNumberDensity = Real (final quantity="IonNumberDensity", final unit=
          "m-3");
  type RecombinationCoefficient = Real (final quantity=
          "RecombinationCoefficient", final unit="m3/s");
  type NeutronNumberDensity = Real (final quantity="NeutronNumberDensity",
        final unit="m-3");
  type NeutronSpeed = Real (final quantity="Velocity", final unit="m/s");
  type NeutronFluenceRate = Real (final quantity="NeutronFluenceRate", final unit
        =    "s-1.m-2");
  type TotalNeutronSourceDensity = Real (final quantity=
          "TotalNeutronSourceDesity", final unit="s-1.m-3");
  type SlowingDownDensity = Real (final quantity="SlowingDownDensity", final unit
        =    "s-1.m-3");
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
  type FastFissionFactor = Real (final quantity="FastFissionFactor", final unit
        ="1");
  type ThermalUtilizationFactor = Real (final quantity=
          "ThermalUtilizationFactor", final unit="1");
  type NonLeakageProbability = Real (final quantity="NonLeakageProbability",
        final unit="1");
  type Reactivity = Real (final quantity="Reactivity", final unit="1");
  type ReactorTimeConstant = Real (final quantity="Time", final unit="s");
  type EnergyImparted = Real (final quantity="Energy", final unit="J");
  type MeanEnergyImparted = Real (final quantity="Energy", final unit="J");
  type SpecificEnergyImparted = Real (final quantity="SpecificEnergy", final unit
        =    "Gy");
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
  type DebyeWallerFactor = Real (final quantity="DebyeWallerFactor", final unit
        ="1");
  type CircularWavenumber = Real (final quantity="CircularWavenumber", final unit
        =    "m-1");
  type FermiCircularWavenumber = Real (final quantity="FermiCircularWavenumber",
          final unit="m-1");
  type DebyeCircularWavenumber = Real (final quantity="DebyeCircularWavenumber",
          final unit="m-1");
  type DebyeCircularFrequency = Real (final quantity="AngularFrequency", final unit
        =    "s-1");
  type DebyeTemperature = ThermodynamicTemperature;
  type SpectralConcentration = Real (final quantity="SpectralConcentration",
        final unit="s/m3");
  type GrueneisenParameter = Real (final quantity="GrueneisenParameter", final unit
        =    "1");
  type MadelungConstant = Real (final quantity="MadelungConstant", final unit=
          "1");
  type DensityOfStates = Real (final quantity="DensityOfStates", final unit=
          "J-1/m-3");
  type ResidualResistivity = Real (final quantity="ResidualResistivity", final unit
        =    "Ohm.m");
  type LorenzCoefficient = Real (final quantity="LorenzCoefficient", final unit
        ="V2/K2");
  type HallCoefficient = Real (final quantity="HallCoefficient", final unit=
          "m3/C");
  type ThermoelectromotiveForce = Real (final quantity=
          "ThermoelectromotiveForce", final unit="V");
  type SeebeckCoefficient = Real (final quantity="SeebeckCoefficient", final unit
        =    "V/K");
  type PeltierCoefficient = Real (final quantity="PeltierCoefficient", final unit
        =    "V");
  type ThomsonCoefficient = Real (final quantity="ThomsonCoefficient", final unit
        =    "V/K");
  type RichardsonConstant = Real (final quantity="RichardsonConstant", final unit
        =    "A/(m2.K2)");
  type FermiEnergy = Real (final quantity="Energy", final unit="eV");
  type GapEnergy = Real (final quantity="Energy", final unit="eV");
  type DonorIonizationEnergy = Real (final quantity="Energy", final unit="eV");
  type AcceptorIonizationEnergy = Real (final quantity="Energy", final unit=
          "eV");
  type FermiTemperature = ThermodynamicTemperature;
  type ElectronNumberDensity = Real (final quantity="ElectronNumberDensity",
        final unit="m-3");
  type HoleNumberDensity = Real (final quantity="HoleNumberDensity", final unit
        ="m-3");
  type IntrinsicNumberDensity = Real (final quantity="IntrinsicNumberDensity",
        final unit="m-3");
  type DonorNumberDensity = Real (final quantity="DonorNumberDensity", final unit
        =    "m-3");
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
  type FluxiodQuantum = Real (final quantity="FluxiodQuantum", final unit="Wb");
  
  annotation(
    Window(
      x=0.08,
      y=0.04,
      width=0.58,
      height=0.84,
      library=1,
      autolayout=1),
    Invisible=true,
    Icon(Text(
        extent=[-63, -13; 45, -67],
        string="[kg.m2]",
        style(color=0))),
    Documentation(info="<html>

<p>This package provides predefined types, such as <i>Mass</i>,
<i>Length</i>, <i>Time</i>, based on the international standard
on units:</p>

<ul>
<li>ISO 31-1992 \"General principles concerning
    quantities, units and symbols\"</li>
<li>ISO 1000-1992 \"SI units and recommendations for the use
    of their multiples and of certain other units\".</li>
</ul>

<p>For more information on units, see also the book of
Francois Cardarelli \"Scientific Unit Conversion - A Practical
Guide to Metrication\"
(Springer 1997).</p>

<p>The following conventions are used in this package:</p>

<ul>
<li>Modelica quantity names are defined according to the recommendations
    of ISO 31. Some of these name are rather long, such as
    \"ThermodynamicTemperature\". Shorter alias names are defined, e.g.,
    \"type Temp_K = ThermodynamicTemperature;\".</li>

<li>Modelica units are defined according to the SI base units without
    multiples (only exception \"kg\").</li>

<li>For some quantities, more convenient units for an engineer are
    defined as \"displayUnit\", i.e., the default unit for display
    purposes (e.g., displayUnit=\"deg\" for quantity=\"Angle\").</li>

<li>The type name is identical to the quantity name, following
    the convention of type names.</li>

<li>All quantity and unit attributes are defined as final in order
    that they cannot be redefined to another value.</li>

<li>Similiar quantities, such as \"Length, Breadth, Height, Thickness,
    Radius\" are defined as the same quantity (here: \"Length\").</li>

<li>The ordering of the type declarations in this package follows ISO 31:
<pre>
  Chapter  1: <b>Space and Time</b>
  Chapter  2: <b>Periodic and Related Phenomena</b>
  Chapter  3: <b>Mechanics</b>
  Chapter  4: <b>Heat</b>
  Chapter  5: <b>Electricity and Magnetism</b>
  Chapter  6: <b>Light and Related Electro-Magnetic Radiations</b>
  Chapter  7: <b>Acoustics</b>
  Chapter  8: <b>Physical Chemistry</b>
  Chapter  9: <b>Atomic and Nuclear Physics</b>
  Chapter 10: <b>Nuclear Reactions and Ionizing Radiations</b>
  Chapter 11: (not defined in ISO 31-1992)
  Chapter 12: <b>Characteristic Numbers</b>
  Chapter 13: <b>Solid State Physics</b>
</pre>
</li>

<li>Conversion functions between SI and non-SI units are available in subpackage
    <b>Conversions</b>.</li>
</ul>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>


<p><b>Release Notes:</b></p>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>

<li><i>June 6, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced the following new types<br>
       type Temperature = ThermodynamicTemperature;<br>
       types DerDensityByEnthalpy, DerDensityByPressure,
       DerDensityByTemperature, DerEnthalpyByPressure,
       DerEnergyByDensity, DerEnergyByPressure<br>
       Attribute \"final\" removed from min and max values
       in order that these values can still be changed to narrow
       the allowed range of values.<br>
       Quantity=\"Stress\" removed from type \"Stress\", in order
       that a type \"Stress\" can be connected to a type \"Pressure\".</li>

<li><i>Oct. 27, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New types due to electrical library: Transconductance, InversePotential,
       Damping.</li>

<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renamed from SIunit to SIunits. Subpackages expanded, i.e., the
       SIunits package, does no longer contain subpackages.</li>

<li><i>Aug 12, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Type \"Pressure\" renamed to \"AbsolutePressure\" and introduced a new
       type \"Pressure\" which does not contain a minimum of zero in order
       to allow convenient handling of relative pressure. Redefined
       BulkModulus as an alias to AbsolutePressure instead of Stress, since
       needed in hydraulics.</li>

<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Bug-fix: Double definition of \"Compressibility\" removed
       and appropriate \"extends Heat\" clause introduced in
       package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>

<li><i>April 8, 1998</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Astrid Jaschinski:<br>
       Complete ISO 31 chapters realized.</li>

<li><i>Nov. 15, 1997</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>:<br>
       Some chapters realized.</li>
</ul>
<br>

<p><b>Copyright &copy; 1999-2002, Modelica Association and DLR.</b></p>

<p><i>The Modelica package is free software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i></p>

</HTML>"),
    Diagram(
      Rectangle(extent=[169, 86; 349, 236], style(fillColor=30, fillPattern=1)),
      Polygon(points=[169, 236; 189, 256; 369, 256; 349, 236; 169, 236], style(
            fillColor=30, fillPattern=1)),
      Polygon(points=[369, 256; 369, 106; 349, 86; 349, 236; 369, 256], style(
            fillColor=30, fillPattern=1)),
      Text(
        extent=[179, 226; 339, 196],
        string="Library",
        style(
          color=9,
          fillColor=0,
          fillPattern=1)),
      Text(
        extent=[206, 173; 314, 119],
        string="[kg.m2]",
        style(color=0)),
      Text(
        extent=[163, 320; 406, 264],
        string="Modelica.SIunits",
        style(color=1))));
end SIunits;
