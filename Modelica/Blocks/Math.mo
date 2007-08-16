package Math "Mathematical functions as input/output blocks" 
  import Modelica.SIunits;
  import Modelica.Blocks.Interfaces;
  extends Modelica.Icons.Library;
  
  annotation (
    preferedView="info",
    Coordsys(
      extent=[0, 0; 446, 493],
      grid=[1, 1],
      component=[20, 20]),
    Window(
      x=0.05,
      y=0.09,
      width=0.44,
      height=0.71,
      library=1,
      autolayout=1),
    Documentation(info="
<HTML>
<p>
This package contains basic <b>mathematical operations</b>,
such as summation and multiplication, and basic <b>mathematical
functions</b>, such as <b>sqrt</b> and <b>sin</b>, as
input/output blocks. All blocks of this library can be either
connected with continuous blocks or with sampled-data blocks.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.</li>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized (partly based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist).
</li>
</ul>
</html>"));
  encapsulated package UnitConversions 
    "Conversion blocks to convert between SI and non-SI unit signals" 
    import Modelica;
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    
    block ConvertAllUnits "Convert signal to a signal with different unit" 
      replaceable block ConversionBlock = 
          Modelica.Blocks.Interfaces.PartialConversionBlock "Conversion block" 
        annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Internal replaceable block that is used to construct the
\"pull down menu\" of the available unit conversions.
</p>
</html>"));
      extends ConversionBlock;
      
      annotation (
        defaultComponentName="convert",
        Icon(Line(points=[-90, 0; 30, 0],style(color=42)), Polygon(points=[90,
                0; 30, 20; 30, -20; 90, 0], style(color=42, fillColor=42))),
        Documentation(info="<html>
<p>This block implements the Modelica.SIunits.Conversions functions as a fixed causality block to
simplify their use. The block contains a replaceable block class <b>ConversionBlock</b> that can be
changed to be any of the blocks defined in Modelica.Blocks.Math.UnitConversions, and more generally, any
blocks that extend from Modelica.Blocks.Interfaces.PartialConversionBlock.</p>
</html>"));
    end ConvertAllUnits;
    
    block To_degC "Convert from Kelvin to °Celsius" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
            unit="degC"));
      
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="K"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="°C")), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to °Celsius and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_degC(u);
    end To_degC;
    
    block From_degC "Convert from °Celsius to Kelvin" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degC"),
          y(unit="K"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="°C"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="K")), Documentation(info="<html>
<p>
This block converts the input signal from °Celsius to Kelvin and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_degC(u);
    end From_degC;
    
    block To_degF "Convert from Kelvin to °Fahrenheit" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
            unit="degF"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="K"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="°F")), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to °Fahrenheit and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_degF(u);
    end To_degF;
    
    block From_degF "Convert from °Fahrenheit to Kelvin" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degF"),
          y(unit="K"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="°F"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="K")), Documentation(info="<html>
<p>
This block converts the input signal from °Fahrenheit to Kelvin and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_degF(u);
    end From_degF;
    
    block To_degRk "Convert from Kelvin to °Rankine" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
            unit="degRk"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="K"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="°Rk")), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to °Rankine and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_degRk(u);
    end To_degRk;
    
    block From_degRk "Convert from °Rankine to Kelvin" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degRk"),
          y(unit="K"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="°Rk"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="K")), Documentation(info="<html>
<p>
This block converts the input signal from °Rankine to Kelvin and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_degRk(u);
    end From_degRk;
    
    block To_deg "Convert from radian to degree" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="rad"),
          y(unit="deg"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="rad"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="deg")), Documentation(info="<html>
<p>
This block converts the input signal from radian to degree and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_deg(u);
    end To_deg;
    
    block From_deg "Convert from degree to radian" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="deg"),
          y(unit="rad"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="deg"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="rad")), Documentation(info="<html>
<p>
This block converts the input signal from degree to radian and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_deg(u);
    end From_deg;
    
    block To_rpm "Convert from radian per second to revolutions per minute" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="rad/s"),
          y(unit="rev/min"));
      annotation (Icon(Text(
            extent=[26,82; -98,50],
            style(color=0),
            string="rad/s"), Text(
            extent=[100,-42; -62,-74],
            style(color=0),
            string="rev/min")), Documentation(info="<html>
<p>
This block converts the input signal from radian per second to revolutions per minute and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_rpm(u);
    end To_rpm;
    
    block From_rpm "Convert from revolutions per minute to radian per second" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit=
              "rev/min"), y(unit="rad/s"));
      annotation (Icon(Text(
            extent=[50,84; -94,56],
            style(color=0),
            string="rev/min"), Text(
            extent=[94,-42; -26,-74],
            style(color=0),
            string="rad/s")), Documentation(info="<html>
<p>
This block converts the input signal from revolutions per minute to radian per second and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_rpm(u);
    end From_rpm;
    
    block To_kmh "Convert from metre per second to kilometre per hour" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="m/s"),
          y(unit="km/h"));
      annotation (Icon(Text(
            extent=[0,82; -96,42],
            style(color=0),
            string="m/s"), Text(
            extent=[92,-40; -14,-84],
            style(color=0),
            string="km/h")), Documentation(info="<html>
<p>
This block converts the input signal from metre per second to kilometre per hour and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_kmh(u);
    end To_kmh;
    
    block From_kmh "Convert from kilometre per hour to metre per second" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="km/h"),
          y(unit="m/s"));
      annotation (Icon(Text(
            extent=[26,80; -96,48],
            style(color=0),
            string="km/h"), Text(
            extent=[92,-46; -20,-82],
            style(color=0),
            string="m/s")), Documentation(info="<html>
<p>
This block converts the input signal from kilometre per hour to metre per second and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_kmh(u);
    end From_kmh;
    
    block To_day "Convert from second to day" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
            unit="d"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="day")), Documentation(info="<html>
<p>
This block converts the input signal from second to day and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_day(u);
    end To_day;
    
    block From_day "Convert from day to second" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="d"), y(
            unit="s"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="day"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="s")), Documentation(info="<html>
<p>
This block converts the input signal from day to second and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_day(u);
    end From_day;
    
    block To_hour "Convert from second to hour" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
            unit="h"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="hour")), Documentation(info="<html>
<p>
This block converts the input signal from second to hour and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_hour(u);
    end To_hour;
    
    block From_hour "Convert from hour to second" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="h"), y(
            unit="s"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="hour"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="s")), Documentation(info="<html>
<p>
This block converts the input signal from hour to second and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_hour(u);
    end From_hour;
    
    block To_minute "Convert from second to minute" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
            unit="min"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="minute")), Documentation(info="<html>
<p>
This block converts the input signal from second to minute and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_minute(u);
    end To_minute;
    
    block From_minute "Convert from minute to second" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="min"),
          y(unit="s"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="minute"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="s")), Documentation(info="<html>
<p>
This block converts the input signal from minute to second and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_minute(u);
    end From_minute;
    
    block To_litre "Convert from cubic metre to litre" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="m3"), y(
            unit="l"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="m3"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="litre")), Documentation(info="<html>
<p>
This block converts the input signal from metre to litre and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_litre(u);
    end To_litre;
    
    block From_litre "Convert from litre to cubic metre" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="l"), y(
            unit="m3"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="litre"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="m3")), Documentation(info="<html>
<p>
This block converts the input signal from litre to cubic metre and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_litre(u);
    end From_litre;
    
    block To_kWh "Convert from Joule to kilo Watt hour" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="J"), y(
            unit="kW.h"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="J"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="kW.h")), Documentation(info="<html>
<p>
This block converts the input signal from Joule to kilo Watt hour and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_kWh(u);
    end To_kWh;
    
    block From_kWh "Convert from kilo Watt hour to Joule" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="kW.h"),
          y(unit="J"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="kW.h"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="J")), Documentation(info="<html>
<p>
This block converts the input signal from kilo Watt hour to Joule and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_kWh(u);
    end From_kWh;
    
    block To_bar "Convert from Pascal to bar" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="Pa"), y(
            unit="bar"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="Pa"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="bar")), Documentation(info="<html>
<p>
This block converts the input signal from Pascal to bar and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_bar(u);
    end To_bar;
    
    block From_bar "Convert from bar to Pascal" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="bar"),
          y(unit="Pa"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="bar"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="Pa")), Documentation(info="<html>
<p>
This block converts the input signal from bar to Pascal and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_bar(u);
    end From_bar;
    
    block To_gps "Convert from kilogram per second to gram per second" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="kg/s"),
          y(unit="g/s"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="kg/s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="g/s")), Documentation(info="<html>
<p>
This block converts the input signal from kilogram per second to gram per seconds and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.to_gps(u);
    end To_gps;
    
    block From_gps "Convert from gram per second to kilogram per second" 
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="g/s"),
          y(unit="kg/s"));
      annotation (Icon(Text(
            extent=[-20, 100; -100, 20],
            style(color=0),
            string="g/s"), Text(
            extent=[100, -20; 20, -100],
            style(color=0),
            string="kg/s")), Documentation(info="<html>
<p>
This block converts the input signal from gram per second to kilogram per second and returns
the result as output signal.
</p>
</html>"));
    equation 
      y = SI.Conversions.from_gps(u);
    end From_gps;
    annotation (Documentation(info="<html>
<p>
This package consists of blocks that convert an input signal 
with a specific unit to an output signal in another unit
(e.g. conversion of an angle signal from \"deg\" to \"rad\").
Block \"ConvertAllUnits\" converts between a set of units that
can be selected in a pull-down menu of the parameter menu.
All other blocks convert exactly between two different units.
</p>
 
</html>"));
  end UnitConversions;
  
  block TwoInputs 
    "Change causality of input signals by defining that two input signals are identical (e.g. for inverse models)" 
    extends Blocks.Interfaces.BlockIcon;
        annotation(structurallyIncomplete,
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.15,
            y=0.21,
            width=0.6,
            height=0.6),
          Documentation(info="<HTML>
<p>
This block is used to enable asignment of values to variables preliminary
defined as outputs (e.g. useful for inverse model generation).
</p>

</HTML>
"),       Icon(Text(
              extent=[-95,50; 95,-50],
              string="=",
          style(color=74, rgbcolor={0,0,127}))));
        Blocks.Interfaces.RealInput u1 "Connector of first Real input signal" 
          annotation (extent=[-139.742, -19.0044; -100, 20], layer="icon");
        Blocks.Interfaces.RealInput u2 
      "Connector of second Real input signal (u1=u2)" 
                                       annotation (
          extent=[100, -20; 140, 20],
          rotation=180,
          layer="icon");
  equation 
        u1 = u2;
  end TwoInputs;
  
      block TwoOutputs 
    "Change causality of output signals by defining that two output signals are identical (e.g. for inverse models)" 
        extends Blocks.Interfaces.BlockIcon;
        annotation(structurallyIncomplete,
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.21,
            y=0.28,
            width=0.6,
            height=0.6),
          Documentation(info="
<HTML>
<p>
This block is used to enable calculation of values preliminary defined as inputs.
(e.g. useful for inverse model generation).
</p>

</HTML>
"),       Icon(Text(
              extent=[-95,50; 95,-50],
              string="=",
              style(color=74, rgbcolor={0,0,127}))));
        output Blocks.Interfaces.RealOutput y1 
      "Connector of first Real output signal" 
          annotation (extent=[100, -10; 120, 10]);
        output Blocks.Interfaces.RealOutput y2 
      "Connector of second Real output signal (y1=y2)" 
                                               annotation (extent=[-120.366, -10.9029;
               -100.365, 9.09712], rotation=180);
      equation 
        y1 = y2;
      end TwoOutputs;
  
      block Gain "Output the product of a gain value with the input signal" 
    
        parameter Real k=1 "Gain value multiplied with input signal";
  public 
        Interfaces.RealInput u "Input signal connector" 
          annotation (extent=[-140, -20; -100, 20]);
        Interfaces.RealOutput y "Output signal connector" 
          annotation (extent=[100, -10; 120, 10]);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.19,
            y=0.02,
            width=0.59,
            height=0.6),
          Documentation(info="
<HTML>
<p>
This block computes output <i>y</i> as
<i>product</i> of gain <i>k</i> with the
input <i>u</i>:
</p>
<pre>
    y = k * u;
</pre>

</HTML>
"),       Icon(
            Polygon(points=[-100, -100; -100, 100; 100, 0; -100, -100], style(
                color=74,
                rgbcolor={0,0,127},
                fillColor=7,
                rgbfillColor={255,255,255})),
            Text(
              extent=[-150, -140; 150, -100],
              string="k=%k",
              style(color=0)),
            Text(extent=[-150, 140; 150, 100], string="%name")),
          Diagram(Polygon(points=[-100, -100; -100, 100; 100, 0; -100, -100],
                    style(
                      color=74,
                      rgbcolor={0,0,127},
                      fillColor=7,
                      rgbfillColor={255,255,255})),
                  Text(extent=[-76, 38; 0, -34], string="k")));
      equation 
        y = k*u;
      end Gain;
  
      block MatrixGain 
    "Output the product of a gain matrix with the input signal vector" 
    
        parameter Real K[:, :]=[1, 0; 0, 1] 
      "Gain matrix which is multiplied with the input";
        extends Interfaces.MIMO(final nin=size(K, 2), final nout=size(K, 1));
        annotation (
          Documentation(info="
<HTML>
<p>
This blocks computes output vector <b>y</b> as <i>product</i> of the
gain matrix <b>K</b> with the input signal vector <b>u</b>:
</p>
<pre>
    <b>y</b> = <b>K</b> * <b>u</b>;
</pre>
<p>
Example:
</p>
<pre>
   parameter: <b>K</b> = [0.12 2; 3 1.5]
   results in the following equations:
     | y[1] |     | 0.12  2.00 |   | u[1] |
     |      |  =  |            | * |      |
     | y[2] |     | 3.00  1.50 |   | u[2] |
</pre>

</HTML>
"),       Icon(Text(
              extent=[-90, -60; 90, 60],
              string="*K",
              style(color=9)), Text(extent=[-150, 150; 150, 110], string=
                  "%name")),
          Diagram(Rectangle(extent=[-100, -100; 100, 100], style(color=3,
                  fillColor=7)), Text(
              extent=[-90, -60; 90, 60],
              string="*K",
              style(color=9))),
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.35,
            y=0.09,
            width=0.6,
            height=0.6));
      equation 
        y = K*u;
      end MatrixGain;
  
      block Sum "Output the sum of the elements of the input vector" 
        extends Interfaces.MISO;
        parameter Real k[nin]=ones(nin) "Optional: sum coefficients";
        annotation (defaultComponentName="sum1",
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.35,
            y=0.08,
            width=0.54,
            height=0.66),
          Documentation(info="
<HTML>
<p>
This blocks computes output <b>y</b> as
<i>sum</i> of the elements of the input signal vector
<b>u</b>:
</p>
<pre>
    <b>y</b> = <b>u</b>[1] + <b>u</b>[2] + ...;
</pre>
<p>
Example:
</p>
<pre>
     parameter:   nin = 3;
  results in the following equations:
     y = u[1] + u[2] + u[3];
</pre>

</HTML>
"),       Icon(Line(points=[26, 42; -34, 42; 6, 2; -34, -38; 26, -38], style(
                  color=0, thickness=1)), Text(extent=[-150, 150; 150, 110],
                string="%name")),
          Diagram(Rectangle(extent=[-100, -100; 100, 100], style(color=3,
                  fillColor=7)), Line(points=[26, 42; -34, 42; 6, 2; -34, -38;
                  26, -38], style(color=0, thickness=1))));
      equation 
        y = k*u;
      end Sum;
  
      block Feedback "Output difference between commanded and feedback input" 
        input Interfaces.RealInput u1 annotation (extent=[-100, -20; -60, 20]);
        input Interfaces.RealInput u2 
          annotation (extent=[-20, -100; 20, -60], rotation=90);
        output Interfaces.RealOutput y annotation (extent=[80, -10; 100, 10]);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.35,
            y=0.02,
            width=0.52,
            height=0.68),
          Documentation(info="
<HTML>
<p>
This blocks computes output <b>y</b> as <i>difference</i> of the
commanded input <b>u1</b> and the feedback
input <b>u2</b>:
</p>
<pre>
    <b>y</b> = <b>u1</b> - <b>u2</b>;
</pre>
<p>
Example:
</p>
<pre>
     parameter:   n = 2
  results in the following equations:
     y = u1 - u2
</pre>

</HTML>
"),       Icon(
            Ellipse(extent=[-20, 20; 20, -20], style(
            color=74,
            rgbcolor={0,0,127},
            fillColor=30,
            rgbfillColor={235,235,235},
            fillPattern=1)),
            Line(points=[-60, 0; -20, 0], style(color=74, rgbcolor={0,0,127})),
            Line(points=[20, 0; 80, 0], style(color=74, rgbcolor={0,0,127})),
            Line(points=[0, -20; 0, -60], style(color=74, rgbcolor={0,0,127})),
            Text(
              extent=[-14,0; 82,-94],
              string="-",
              style(color=0)),
            Text(extent=[-100, 110; 100, 60], string="%name")),
          Diagram(
            Ellipse(extent=[-20, 20; 20, -20], style(
                pattern=1,
                thickness=1,
                fillColor=30,
                fillPattern=1)),
            Line(points=[-60, 0; -20, 0]),
            Line(points=[20, 0; 80, 0]),
            Line(points=[0, -20; 0, -60]),
            Text(
              extent=[-12, 10; 84, -84],
              string="-",
              style(color=0))));
      equation 
        y = u1 - u2;
      end Feedback;
  
      block Add "Output the sum of the two inputs" 
        extends Interfaces.SI2SO;
        parameter Real k1=+1 "Gain of upper input";
        parameter Real k2=+1 "Gain of lower input";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.23,
            y=0.22,
            width=0.54,
            height=0.66),
          Documentation(info="
<HTML>
<p>
This blocks computes output <b>y</b> as <i>sum</i> of the
two input signals <b>u1</b> and <b>u2</b>:
</p>
<pre>
    <b>y</b> = k1*<b>u1</b> + k2*<b>u2</b>;
</pre>
<p>
Example:
</p>
<pre>
     parameter:   k1= +2, k2= -3
  results in the following equations:
     y = 2 * u1 - 3 * u2
</pre>
<p><b>Release Notes:</b></p>
<ul>

</HTML>
"),       Icon(
            Text(
              extent=[-98, -52; 7, -92],
              string="%k2",
              style(color=0)),
            Text(
              extent=[-100, 90; 5, 50],
              string="%k1",
              style(color=0)),
            Text(extent=[-150, 150; 150, 110], string="%name"),
            Line(points=[-100, 60; -40, 60; -30, 40]),
            Ellipse(extent=[-50, 50; 50, -50]),
            Line(points=[-100, -60; -40, -60; -30, -40]),
            Line(points=[-15, -25.99; 15, 25.99], style(color=0)),
            Rectangle(extent=[-100, -100; 100, 100], style(
            color=74,
            rgbcolor={0,0,127},
            fillColor=7,
            rgbfillColor={255,255,255})),
            Line(points=[50, 0; 100, 0]),
            Line(points=[-100, 60; -74, 24; -44, 24], style(color=74, rgbcolor=
                {0,0,127})),
            Line(points=[-100, -60; -74, -28; -42, -28], style(color=74,
              rgbcolor={0,0,127})),
            Ellipse(extent=[-50, 50; 50, -50], style(color=74, rgbcolor={0,0,
                127})),
            Line(points=[50, 0; 100, 0], style(color=74, rgbcolor={0,0,127})),
            Text(
              extent=[-38, 34; 38, -34],
              string="+",
              style(color=0)),
            Text(
              extent=[-100, 52; 5, 92],
              string="%k1",
              style(color=0)),
            Text(
              extent=[-100, -52; 5, -92],
              string="%k2",
              style(color=0))),
          Diagram(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Text(
              extent=[-98, -52; 7, -92],
              string="%k2",
              style(color=0)),
            Text(
              extent=[-100, 90; 5, 50],
              string="%k1",
              style(color=0)),
            Line(points=[-100, 60; -40, 60; -30, 40]),
            Ellipse(extent=[-50, 50; 50, -50]),
            Line(points=[-100, -60; -40, -60; -30, -40]),
            Line(points=[-15, -25.99; 15, 25.99], style(color=0)),
            Rectangle(extent=[-100, -100; 100, 100], style(
            color=74,
            rgbcolor={0,0,127},
            fillColor=7,
            rgbfillColor={255,255,255})),
            Line(points=[50, 0; 100, 0]),
            Line(points=[-100, 60; -74, 24; -44, 24], style(color=74, rgbcolor=
                {0,0,127})),
            Line(points=[-100, -60; -74, -28; -42, -28], style(color=74,
              rgbcolor={0,0,127})),
            Ellipse(extent=[-50, 50; 50, -50], style(color=74, rgbcolor={0,0,
                127})),
            Line(points=[50, 0; 100, 0], style(color=74, rgbcolor={0,0,127})),
            Text(
              extent=[-38, 34; 38, -34],
              string="+",
              style(color=0)),
            Text(
              extent=[-100, 52; 5, 92],
              string="k1",
              style(color=0)),
            Text(
              extent=[-100, -52; 5, -92],
              string="k2",
              style(color=0))));
    
      equation 
        y = k1*u1 + k2*u2;
      end Add;
  
      block Add3 "Output the sum of the three inputs" 
        extends Interfaces.BlockIcon;
    
        parameter Real k1=+1 "Gain of upper input";
        parameter Real k2=+1 "Gain of middle input";
        parameter Real k3=+1 "Gain of lower input";
        input Interfaces.RealInput u1 "Connector 1 of Real input signals" 
          annotation (extent=[-140, 60; -100, 100]);
        input Interfaces.RealInput u2 "Connector 2 of Real input signals" 
          annotation (extent=[-140, -20; -100, 20]);
        input Interfaces.RealInput u3 "Connector 3 of Real input signals" 
          annotation (extent=[-140, -100; -100, -60]);
        output Interfaces.RealOutput y "Connector of Real output signals" 
          annotation (extent=[100, -10; 120, 10]);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.37,
            y=0.09,
            width=0.54,
            height=0.66),
          Documentation(info="
<HTML>
<p>
This blocks computes output <b>y</b> as <i>sum</i> of the
three input signals <b>u1</b>, <b>u2</b> and <b>u3</b>:
</p>
<pre>
    <b>y</b> = k1*<b>u1</b> + k2*<b>u2</b> + k3*<b>u3</b>;
</pre>
<p>
Example:
</p>
<pre>
     parameter:   k1= +2, k2= -3, k3=1;
  results in the following equations:
     y = 2 * u1 - 3 * u2 + u3;
</pre>
 
</HTML>
"),       Icon(
            Text(
              extent=[-100, 50; 5, 90],
              string="%k1",
              style(color=0)),
            Text(
              extent=[-100, -20; 5, 20],
              string="%k2",
              style(color=0)),
            Text(
              extent=[-100, -50; 5, -90],
              string="%k3",
              style(color=0)),
            Text(
              extent=[2, 36; 100, -44],
              string="+",
              style(color=0))),
          Diagram(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Text(
              extent=[-100, 50; 5, 90],
              string="%k1",
              style(color=0)),
            Text(
              extent=[-100, -20; 5, 20],
              string="%k2",
              style(color=0)),
            Text(
              extent=[-100, -50; 5, -90],
              string="%k3",
              style(color=0)),
            Text(
              extent=[2, 36; 100, -44],
              string="+",
              style(color=0)),
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Text(
              extent=[-100, 50; 5, 90],
              string="k1",
              style(color=0)),
            Text(
              extent=[-100, -20; 5, 20],
              string="k2",
              style(color=0)),
            Text(
              extent=[-100, -50; 5, -90],
              string="k3",
              style(color=0)),
            Text(
              extent=[2, 36; 100, -44],
              string="+",
              style(color=0))));
    
      equation 
        y = k1*u1 + k2*u2 + k3*u3;
      end Add3;
  
      block Product "Output product of the two inputs" 
        extends Interfaces.SI2SO;
        annotation (
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <i>product</i> of the corresponding elements of
the two inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>
    y = u1 * u2;
</pre>

</HTML>
"),       Icon(
            Line(points=[-100, 60; -40, 60; -30, 40], style(color=74, rgbcolor=
                {0,0,127})),
            Line(points=[-100, -60; -40, -60; -30, -40], style(color=74,
              rgbcolor={0,0,127})),
            Line(points=[50, 0; 100, 0], style(color=74, rgbcolor={0,0,127})),
            Line(points=[-30, 0; 30, 0], style(color=0)),
            Line(points=[-15, 25.99; 15, -25.99], style(color=0)),
            Line(points=[-15, -25.99; 15, 25.99], style(color=0)),
            Ellipse(extent=[-50, 50; 50, -50], style(color=74, rgbcolor={0,0,
                127}))),
          Diagram(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Line(points=[-100, 60; -40, 60; -30, 40]),
            Line(points=[-100, -60; -40, -60; -30, -40]),
            Line(points=[50, 0; 100, 0]),
            Line(points=[-30, 0; 30, 0], style(color=0)),
            Line(points=[-15, 25.99; 15, -25.99], style(color=0)),
            Line(points=[-15, -25.99; 15, 25.99], style(color=0)),
            Ellipse(extent=[-50, 50; 50, -50])),
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.2,
            y=0.01,
            width=0.47,
            height=0.62));
    
      equation 
        y = u1*u2;
      end Product;
  
      block Division "Output first input divided by second input" 
        extends Interfaces.SI2SO;
        annotation (
          Documentation(info="
<HTML>
<p>
This block computes the output <b>y</b> (element-wise)
by <i>dividing</i> the corresponding elements of
the two inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>
    y = u1 / u2;
</pre>

</HTML>
"),       Icon(
            Line(points=[50, 0; 100, 0], style(color=74, rgbcolor={0,0,127})),
            Line(points=[-30, 0; 30, 0], style(color=0)),
            Ellipse(extent=[-5, 20; 5, 30], style(color=0, fillColor=0)),
            Ellipse(extent=[-5, -20; 5, -30], style(color=0, fillColor=0)),
            Ellipse(extent=[-50, 50; 50, -50], style(color=74, rgbcolor={0,0,
                127})),
            Text(extent=[-150, 150; 150, 110], string="%name"),
            Line(points=[-100, 60; -66, 60; -40, 30], style(color=74, rgbcolor=
                {0,0,127})),
            Line(points=[-100, -60; 0, -60; 0, -50], style(color=74, rgbcolor={
                0,0,127}))),
          Diagram(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Line(points=[50, 0; 100, 0]),
            Line(points=[-30, 0; 30, 0], style(color=0)),
            Ellipse(extent=[-5, 20; 5, 30], style(color=0, fillColor=0)),
            Ellipse(extent=[-5, -20; 5, -30], style(color=0, fillColor=0)),
            Ellipse(extent=[-50, 50; 50, -50]),
            Line(points=[-100, 60; -66, 60; -40, 30]),
            Line(points=[-100, -60; 0, -60; 0, -50])),
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.22,
            y=0.09,
            width=0.6,
            height=0.6));
    
      equation 
        y = u1/u2;
      end Division;
  
      block Abs "Output the absolute value of the input" 
        extends Interfaces.SISO;
        annotation (defaultComponentName="abs1",
          Icon(
            Polygon(points=[92, 0; 70, 8; 70, -8; 92, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, 80; 0, 0; 80, 80], style(color=0)),
            Line(points=[0, -14; 0, 68], style(color=8)),
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Text(
              extent=[-34, -28; 38, -76],
              string="abs",
              style(color=8)),
            Line(points=[-88, 0; 76, 0], style(color=8))),
          Diagram(
            Line(points=[-100, 0; 76, 0], style(color=8)),
            Polygon(points=[92, 0; 76, 6; 76, -6; 92, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, 80; 0, 0; 80, 80], style(color=0)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Text(
              extent=[7, 98; 34, 78],
              string="u",
              style(color=9)),
            Text(
              extent=[74, -8; 96, -28],
              string="y",
              style(color=9)),
            Text(extent=[52, -3; 72, -23], string="1"),
            Text(extent=[-86, -1; -66, -21], string="-1"),
            Text(extent=[-28, 79; -8, 59], string="1")),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <i>absolute value</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>abs</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.37,
            y=0.06,
            width=0.6,
            height=0.6));
      equation 
        y = abs(u);
      end Abs;
  
      block Sign "Output the sign of the input" 
        extends Interfaces.SISO;
        annotation (defaultComponentName="sign1",
          Icon(
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -80; 0, -80], style(color=0)),
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Text(
              extent=[-90, 72; -18, 24],
              string="sign",
              style(color=8)),
            Line(points=[0, 80; 80, 80], style(color=0)),
            Rectangle(extent=[-2, 2; 2, -4], style(
                color=0,
                fillColor=0,
                fillPattern=1))),
          Diagram(
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -80; 0, -80], style(color=0)),
            Line(points=[-0.01, 0; 0.01, 0], style(color=0)),
            Line(points=[0, 80; 80, 80], style(color=0)),
            Rectangle(extent=[-2, 2; 2, -4], style(
                color=0,
                fillColor=0,
                fillPattern=1)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[7, 102; 32, 82],
              string="y",
              style(color=9)),
            Text(
              extent=[70, -6; 94, -26],
              string="u",
              style(color=9)),
            Text(extent=[-25, 86; -5, 70], string="1"),
            Text(extent=[5, -72; 25, -88], string="-1")),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <b>sign</b> of the input <b>u</b>:
</p>
<pre>
         1  <b>if</b> u > 0
    y =  0  <b>if</b> u == 0
        -1  <b>if</b> u < 0
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.11,
            width=0.6,
            height=0.6));
      equation 
        y = sign(u);
      end Sign;
  
      block Sqrt "Output the square root of the input (input >= 0 required)" 
        extends Interfaces.SISO;
        annotation (defaultComponentName="sqrt1",
          Icon(
            Line(points=[-90, -80; 68, -80], style(color=8)),
            Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -80; -79.2, -68.7; -78.4, -64; -76.8, -57.3; -73.6,
                   -47.9; -67.9, -36.1; -59.1, -22.2; -46.2, -6.49; -28.5, 10.7;
                   -4.42, 30; 27.7, 51.3; 69.5, 74.7; 80, 80], style(color=0)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -88; -80, 68], style(color=8)),
            Text(
              extent=[-8, -4; 64, -52],
              string="sqrt",
              style(color=8))),
          Diagram(
            Line(points=[-92, -80; 84, -80], style(color=8)),
            Polygon(points=[100, -80; 84, -74; 84, -86; 100, -80], style(color=
                    8, fillColor=8)),
            Line(points=[-80, -80; -79.2, -68.7; -78.4, -64; -76.8, -57.3; -73.6,
                   -47.9; -67.9, -36.1; -59.1, -22.2; -46.2, -6.49; -28.5, 10.7;
                   -4.42, 30; 27.7, 51.3; 69.5, 74.7; 80, 80], style(color=0)),
            Polygon(points=[-80, 98; -86, 82; -74, 82; -80, 98], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -90; -80, 84], style(color=8)),
            Text(
              extent=[-71, 98; -44, 78],
              string="y",
              style(color=9)),
            Text(
              extent=[60, -52; 84, -72],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <i>square root</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>sqrt</b>( u );
</pre>
<p>
All elements of the input vector shall be zero or positive.
Otherwise an error occurs.
</p>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.15,
            width=0.6,
            height=0.6));
    
      equation 
        y = sqrt(u);
      end Sqrt;
  
      block Sin "Output the sine of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -80; -80, 68], style(color=8)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4,
                  74.6; -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3,
                   59.4; -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2;
                  23.7, -64.2; 29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6;
                  51.9, -71.5; 57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0],
                style(color=0)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Text(
              extent=[12, 84; 84, 36],
              string="sin",
              style(color=8))),
          Diagram(
            Line(points=[-80, 80; -88, 80], style(color=8)),
            Line(points=[-80, -80; -88, -80], style(color=8)),
            Line(points=[-80, -90; -80, 84], style(color=8)),
            Text(
              extent=[-75, 98; -46, 78],
              string="y",
              style(color=9)),
            Polygon(points=[-80, 96; -86, 80; -74, 80; -80, 96], style(color=8,
                   fillColor=8)),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4,
                  74.6; -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3,
                   59.4; -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2;
                  23.7, -64.2; 29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6;
                  51.9, -71.5; 57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0],
                style(color=0)),
            Text(extent=[-105, 72; -85, 88], string="1"),
            Text(extent=[70, 25; 90, 5], string="2*pi"),
            Text(extent=[-105, -72; -85, -88], string="-1"),
            Text(
              extent=[76, -10; 98, -30],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <b>sine</b> of the input <b>u</b>:
</p>
<pre>
    y = <b>sin</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.23,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.sin(u);
      end Sin;
  
      block Cos "Output the cosine of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -80; -80, 68], style(color=8)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, 80; -74.4, 78.1; -68.7, 72.3; -63.1, 63; -56.7,
                  48.7; -48.6, 26.6; -29.3, -32.5; -22.1, -51.7; -15.7, -65.3;
                  -10.1, -73.8; -4.42, -78.8; 1.21, -79.9; 6.83, -77.1; 12.5, -70.6;
                   18.1, -60.6; 24.5, -45.7; 32.6, -23; 50.3, 31.3; 57.5, 50.7;
                   63.9, 64.6; 69.5, 73.4; 75.2, 78.6; 80, 80], style(color=0)),
            Text(
              extent=[-36, 82; 36, 34],
              string="cos",
              style(color=8))),
          Diagram(
            Line(points=[-80, 80; -88, 80], style(color=8)),
            Line(points=[-80, -80; -88, -80], style(color=8)),
            Line(points=[-80, -90; -80, 84], style(color=8)),
            Text(
              extent=[-75, 102; -48, 82],
              string="y",
              style(color=9)),
            Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=
                    8, fillColor=8)),
            Text(extent=[-103, 72; -83, 88], string="1"),
            Text(extent=[-79, -72; -59, -88], string="-1"),
            Text(extent=[70, 25; 90, 5], string="2*pi"),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, 80; -74.4, 78.1; -68.7, 72.3; -63.1, 63; -56.7,
                  48.7; -48.6, 26.6; -29.3, -32.5; -22.1, -51.7; -15.7, -65.3;
                  -10.1, -73.8; -4.42, -78.8; 1.21, -79.9; 6.83, -77.1; 12.5, -70.6;
                   18.1, -60.6; 24.5, -45.7; 32.6, -23; 50.3, 31.3; 57.5, 50.7;
                   63.9, 64.6; 69.5, 73.4; 75.2, 78.6; 80, 80], style(color=0)),
            Text(
              extent=[74, -4; 98, -24],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <b>cos</b> of the input <b>u</b>:
</p>
<pre>
    y = <b>cos</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.18,
            width=0.6,
            height=0.6));
    
      equation 
        y = Modelica.Math.cos(u);
      end Cos;
  
      block Tan "Output the tangent of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Line(points=[-80, -80; -78.4, -68.4; -76.8, -59.7; -74.4, -50; -71.2,
                   -40.9; -67.1, -33; -60.7, -24.8; -51.1, -17.2; -35.8, -9.98;
                   -4.42, -1.07; 33.4, 9.12; 49.4, 16.2; 59.1, 23.2; 65.5, 30.6;
                   70.4, 39.1; 73.6, 47.4; 76, 56.1; 77.6, 63.8; 80, 80], style(
                  color=0)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Text(
              extent=[-90, 72; -18, 24],
              string="tan",
              style(color=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -88; 0, 86], style(color=8)),
            Text(
              extent=[11, 100; 38, 80],
              string="y",
              style(color=9)),
            Polygon(points=[0, 102; -6, 86; 6, 86; 0, 102], style(color=8,
                  fillColor=8)),
            Text(extent=[-37, -72; -17, -88], string="-5.8"),
            Text(extent=[-33, 86; -13, 70], string=" 5.8"),
            Text(extent=[70, 25; 90, 5], string="1.4"),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -80; -78.4, -68.4; -76.8, -59.7; -74.4, -50; -71.2,
                   -40.9; -67.1, -33; -60.7, -24.8; -51.1, -17.2; -35.8, -9.98;
                   -4.42, -1.07; 33.4, 9.12; 49.4, 16.2; 59.1, 23.2; 65.5, 30.6;
                   70.4, 39.1; 73.6, 47.4; 76, 56.1; 77.6, 63.8; 80, 80], style(
                  color=0)),
            Text(
              extent=[70, -6; 94, -26],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <b>tan</b> of the input <b>u</b>:
</p>
<pre>
    y = <b>tan</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.39,
            y=0.18,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.tan(u);
      end Tan;
  
      block Asin "Output the arc sine of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Line(points=[-80, -80; -79.2, -72.8; -77.6, -67.5; -73.6, -59.4; -66.3,
                   -49.8; -53.5, -37.3; -30.2, -19.7; 37.4, 24.8; 57.5, 40.8;
                  68.7, 52.7; 75.2, 62.2; 77.6, 67.5; 80, 80], style(color=0)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Text(
              extent=[-88, 78; -16, 30],
              string="asin",
              style(color=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[9, 102; 36, 82],
              string="y",
              style(color=9)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Text(extent=[-40, -72; -15, -88], string="-pi/2"),
            Text(extent=[-38, 88; -13, 72], string=" pi/2"),
            Text(extent=[70, 25; 90, 5], string="+1"),
            Text(extent=[-90, 21; -70, 1], string="-1"),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -80; -79.2, -72.8; -77.6, -67.5; -73.6, -59.4; -66.3,
                   -49.8; -53.5, -37.3; -30.2, -19.7; 37.4, 24.8; 57.5, 40.8;
                  68.7, 52.7; 75.2, 62.2; 77.6, 67.5; 80, 80], style(color=0)),
            Text(
              extent=[74, -4; 100, -26],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>sine-inverse</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>asin</b>( u );
</pre>
<p>
The absolute values of the elements of the input <b>u</b> need to
be less or equal to one (<b>abs</b>( u ) <= 1).
Otherwise an error occurs.
</p>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.41,
            y=0.13,
            width=0.6,
            height=0.6));
    
      equation 
        y = Modelica.Math.asin(u);
      end Asin;
  
      block Acos "Output the arc cosine of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Line(points=[-80, 80; -79.2, 72.8; -77.6, 67.5; -73.6, 59.4; -66.3,
                   49.8; -53.5, 37.3; -30.2, 19.7; 37.4, -24.8; 57.5, -40.8;
                  68.7, -52.7; 75.2, -62.2; 77.6, -67.5; 80, -80], style(color=
                    0)),
            Line(points=[0, -88; 0, 68], style(color=8)),
            Line(points=[-90, -80; 68, -80], style(color=8)),
            Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
                   fillColor=8)),
            Text(
              extent=[-86, -14; -14, -62],
              string="acos",
              style(color=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[13, 100; 42, 82],
              string="y",
              style(color=9)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Line(points=[-100, -80; 84, -80], style(color=8)),
            Polygon(points=[100, -80; 84, -74; 84, -86; 100, -80], style(color=
                    8, fillColor=8)),
            Line(points=[-80, 80; -79.2, 72.8; -77.6, 67.5; -73.6, 59.4; -66.3,
                   49.8; -53.5, 37.3; -30.2, 19.7; 37.4, -24.8; 57.5, -40.8;
                  68.7, -52.7; 75.2, -62.2; 77.6, -67.5; 80, -80], style(color=
                    0)),
            Text(extent=[-30, 88; -5, 72], string=" pi"),
            Text(extent=[-94, -57; -74, -77], string="-1"),
            Text(extent=[80, -45; 100, -65], string="+1"),
            Text(
              extent=[76, -84; 102, -102],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>cosine-inverse</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>acos</b>( u );
</pre>
<p>
The absolute values of the elements of the input <b>u</b> need to
be less or equal to one (<b>abs</b>( u ) <= 1).
Otherwise an error occurs.
</p>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.39,
            y=0.18,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.acos(u);
      end Acos;
  
      block Atan "Output the arc tangent of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Line(points=[-80, -80; -52.7, -75.2; -37.4, -69.7; -26.9, -63; -19.7,
                   -55.2; -14.1, -45.8; -10.1, -36.4; -6.03, -23.9; -1.21, -5.06;
                   5.23, 21; 9.25, 34.1; 13.3, 44.2; 18.1, 52.9; 24.5, 60.8;
                  33.4, 67.6; 47, 73.6; 69.5, 78.6; 80, 80], style(color=0)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Text(
              extent=[-86, 68; -14, 20],
              string="atan",
              style(color=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[13, 102; 42, 82],
              string="y",
              style(color=9)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -80; -52.7, -75.2; -37.4, -69.7; -26.9, -63; -19.7,
                   -55.2; -14.1, -45.8; -10.1, -36.4; -6.03, -23.9; -1.21, -5.06;
                   5.23, 21; 9.25, 34.1; 13.3, 44.2; 18.1, 52.9; 24.5, 60.8;
                  33.4, 67.6; 47, 73.6; 69.5, 78.6; 80, 80], style(color=0)),
            Text(extent=[-32, 91; -12, 71], string="1.4"),
            Text(extent=[-32, -71; -12, -91], string="-1.4"),
            Text(extent=[73, 26; 93, 10], string=" 5.8"),
            Text(extent=[-103, 20; -83, 4], string="-5.8"),
            Text(
              extent=[66, -8; 94, -28],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>tangent-inverse</i> of the input <b>u</b>:
</p>
<pre>
    y= <b>atan</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.12,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.atan(u);
      end Atan;
  
      block Atan2 "Output atan(u1/u2) of the inputs u1 and u2" 
        extends Interfaces.SI2SO;
        annotation (
          Icon(
            Text(extent=[-150, 150; 150, 110], string="%name"),
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -34.9; -46.1, -31.4; -29.4, -27.1; -18.3, -21.5;
                  -10.3, -14.5; -2.03, -3.17; 7.97, 11.6; 15.5, 19.4; 24.3, 25;
                   39, 30; 62.1, 33.5; 80, 34.9], style(color=0)),
            Line(points=[-80, 45.1; -45.9, 48.7; -29.1, 52.9; -18.1, 58.6; -10.2,
                   65.8; -1.82, 77.2; 0, 80], style(color=0)),
            Line(points=[0, -80; 8.93, -67.2; 17.1, -59.3; 27.3, -53.6; 42.1, -49.4;
                   69.9, -45.8; 80, -45.1], style(color=0)),
            Text(
              extent=[-90, -46; -18, -94],
              string="atan2",
              style(color=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[11, 98; 42, 78],
              string="y",
              style(color=9)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[0, -80; 8.93, -67.2; 17.1, -59.3; 27.3, -53.6; 42.1, -49.4;
                   69.9, -45.8; 80, -45.1], style(color=0)),
            Line(points=[-80, -34.9; -46.1, -31.4; -29.4, -27.1; -18.3, -21.5;
                  -10.3, -14.5; -2.03, -3.17; 7.97, 11.6; 15.5, 19.4; 24.3, 25;
                   39, 30; 62.1, 33.5; 80, 34.9], style(color=0)),
            Line(points=[-80, 45.1; -45.9, 48.7; -29.1, 52.9; -18.1, 58.6; -10.2,
                   65.8; -1.82, 77.2; 0, 80], style(color=0)),
            Text(extent=[-30, 89; -10, 70], string="pi"),
            Text(extent=[-30, -69; -10, -88], string="-pi"),
            Text(extent=[-30, 49; -10, 30], string="pi/2"),
            Line(points=[0, 40; -8, 40], style(color=8)),
            Line(points=[0, -40; -8, -40], style(color=8)),
            Text(extent=[-30, -31; -10, -50], string="-pi/2"),
            Text(
              extent=[48, 0; 100, -34],
              string="u1 / u2",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>tangent-inverse</i> of the input <b>u1</b> divided by
input <b>u2</b>:
</p>
<pre>
    y = <b>atan2</b>( u1, u2 );
</pre>
<p>
u1 and u2 shall not be zero at the same time instant.
<b>Atan2</b> uses the sign of u1 and u2 in order to construct
the solution in the range -180 deg &le; y &le; 180 deg, whereas
block <b>Atan</b> gives a solution in the range
-90 deg &le; y &le; 90 deg.
</p>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.21,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.atan2(u1, u2);
      end Atan2;
  
      block Sinh "Output the hyperbolic sine of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Text(
              extent=[-86, 80; -14, 32],
              string="sinh",
              style(color=8)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Line(points=[-80, -80; -76, -65.4; -71.2, -51.4; -65.5, -38.8; -59.1,
                   -28.1; -51.1, -18.7; -41.4, -11.4; -27.7, -5.5; -4.42, -0.653;
                   24.5, 4.57; 39, 10.1; 49.4, 17.2; 57.5, 25.9; 63.9, 35.8;
                  69.5, 47.4; 74.4, 60.4; 78.4, 73.8; 80, 80], style(color=0)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[9, 98; 34, 78],
              string="y",
              style(color=9)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -80; -76, -65.4; -71.2, -51.4; -65.5, -38.8; -59.1,
                   -28.1; -51.1, -18.7; -41.4, -11.4; -27.7, -5.5; -4.42, -0.653;
                   24.5, 4.57; 39, 10.1; 49.4, 17.2; 57.5, 25.9; 63.9, 35.8;
                  69.5, 47.4; 74.4, 60.4; 78.4, 73.8; 80, 80], style(color=0)),
            Text(extent=[-31, 72; -11, 88], string="27"),
            Text(extent=[-35, -88; -15, -72], string="-27"),
            Text(extent=[70, 25; 90, 5], string="4"),
            Text(extent=[-98, 21; -78, 1], string="-4"),
            Text(
              extent=[72, -6; 96, -26],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>hyperbolic sine</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>sinh</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.41,
            y=0.13,
            width=0.6,
            height=0.6));
    
      equation 
        y = Modelica.Math.sinh(u);
      end Sinh;
  
      block Cosh "Output the hyperbolic cosine of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Line(points=[0, -80; 0, 68], style(color=8)),
            Text(
              extent=[4, 66; 66, 20],
              string="cosh",
              style(color=8)),
            Line(points=[-80, 80; -77.6, 61.1; -74.4, 39.3; -71.2, 20.7; -67.1,
                   1.29; -63.1, -14.6; -58.3, -29.8; -52.7, -43.5; -46.2, -55.1;
                   -39, -64.3; -30.2, -71.7; -18.9, -77.1; -4.42, -79.9; 10.9,
                  -79.1; 23.7, -75.2; 34.2, -68.7; 42.2, -60.6; 48.6, -51.2;
                  54.3, -40; 59.1, -27.5; 63.1, -14.6; 67.1, 1.29; 71.2, 20.7;
                  74.4, 39.3; 77.6, 61.1; 80, 80], style(color=0)),
            Line(points=[-90, -86.083; 68, -86.083], style(color=8)),
            Polygon(points=[90, -86.083; 68, -78.083; 68, -94.083; 90, -86.083],
                 style(color=8, fillColor=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[11, 98; 38, 78],
              string="y",
              style(color=9)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Line(points=[-100, -86.083; 84, -86.083], style(color=8)),
            Polygon(points=[100, -86.083; 84, -80.083; 84, -92.083; 100, -86.083],
                 style(color=8, fillColor=8)),
            Line(points=[-80, 80; -77.6, 61.1; -74.4, 39.3; -71.2, 20.7; -67.1,
                   1.29; -63.1, -14.6; -58.3, -29.8; -52.7, -43.5; -46.2, -55.1;
                   -39, -64.3; -30.2, -71.7; -18.9, -77.1; -4.42, -79.9; 10.9,
                  -79.1; 23.7, -75.2; 34.2, -68.7; 42.2, -60.6; 48.6, -51.2;
                  54.3, -40; 59.1, -27.5; 63.1, -14.6; 67.1, 1.29; 71.2, 20.7;
                  74.4, 39.3; 77.6, 61.1; 80, 80], style(color=0)),
            Text(extent=[-31, 72; -11, 88], string="27"),
            Text(extent=[62, -67; 82, -87], string="4"),
            Text(extent=[-104, -63; -84, -83], string="-4"),
            Text(
              extent=[78, -54; 100, -74],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>hyperbolic cosine</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>cosh</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.28,
            y=0.07,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.cosh(u);
      end Cosh;
  
      block Tanh "Output the hyperbolic tangent of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Line(points=[0, -90; 0, 84], style(color=8)),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Line(points=[-80, -80; -47.8, -78.7; -35.8, -75.7; -27.7, -70.6; -22.1,
                   -64.2; -17.3, -55.9; -12.5, -44.3; -7.64, -29.2; -1.21, -4.82;
                   6.83, 26.3; 11.7, 42; 16.5, 54.2; 21.3, 63.1; 26.9, 69.9;
                  34.2, 75; 45.4, 78.4; 72, 79.9; 80, 80], style(color=0)),
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Text(
              extent=[-88, 72; -16, 24],
              string="tanh",
              style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[9, 98; 42, 80],
              string="y",
              style(color=9)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -80; -47.8, -78.7; -35.8, -75.7; -27.7, -70.6; -22.1,
                   -64.2; -17.3, -55.9; -12.5, -44.3; -7.64, -29.2; -1.21, -4.82;
                   6.83, 26.3; 11.7, 42; 16.5, 54.2; 21.3, 63.1; 26.9, 69.9;
                  34.2, 75; 45.4, 78.4; 72, 79.9; 80, 80], style(color=0)),
            Text(extent=[70, 25; 90, 5], string="4"),
            Text(extent=[-106, 21; -86, 1], string="-4"),
            Text(extent=[-29, 72; -9, 88], string="1"),
            Text(extent=[3, -72; 23, -88], string="-1"),
            Text(
              extent=[72, -8; 98, -26],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>hyperbolic tangent</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>tanh</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.14,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.tanh(u);
      end Tanh;
  
      block Exp "Output the exponential (base e) of the input" 
        extends Interfaces.SISO;
        annotation (
          Icon(
            Line(points=[0, -80; 0, 68], style(color=8)),
            Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8,
                  fillColor=8)),
            Text(
              extent=[-86, 50; -14, 2],
              string="exp",
              style(color=8)),
            Line(points=[-80, -80; -31, -77.9; -6.03, -74; 10.9, -68.4; 23.7, -61;
                   34.2, -51.6; 43, -40.3; 50.3, -27.8; 56.7, -13.5; 62.3, 2.23;
                   67.1, 18.6; 72, 38.2; 76, 57.6; 80, 80], style(color=0)),
            Line(points=[-90, -80.3976; 68, -80.3976], style(color=8)),
            Polygon(points=[90, -80.3976; 68, -72.3976; 68, -88.3976; 90, -80.3976],
                 style(color=8, fillColor=8))),
          Diagram(
            Line(points=[0, 80; -8, 80], style(color=8)),
            Line(points=[0, -80; -8, -80], style(color=8)),
            Line(points=[0, -90; 0, 84], style(color=8)),
            Text(
              extent=[9, 100; 40, 80],
              string="y",
              style(color=9)),
            Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
                  fillColor=8)),
            Line(points=[-100, -80.3976; 84, -80.3976], style(color=8)),
            Polygon(points=[100, -80.3976; 84, -74.3976; 84, -86.3976; 100, -80.3976],
                 style(color=8, fillColor=8)),
            Line(points=[-80, -80; -31, -77.9; -6.03, -74; 10.9, -68.4; 23.7, -61;
                   34.2, -51.6; 43, -40.3; 50.3, -27.8; 56.7, -13.5; 62.3, 2.23;
                   67.1, 18.6; 72, 38.2; 76, 57.6; 80, 80], style(color=0)),
            Text(extent=[-31, 72; -11, 88], string="20"),
            Text(extent=[-92, -83; -72, -103], string="-3"),
            Text(extent=[70, -83; 90, -103], string="3"),
            Text(extent=[-18, -53; 2, -73], string="1"),
            Text(
              extent=[66, -52; 96, -72],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>exponential</i> (of base e) of the input <b>u</b>:
</p>
<pre>
    y = <b>exp</b>( u );
</pre>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.27,
            y=0.09,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.exp(u);
      end Exp;
  
      block Log 
    "Output the natural (base e) logarithm of the input (input > 0 required)" 
    
        extends Interfaces.SISO;
        annotation (
          Icon(
            Line(points=[-80, -80; -80, 68], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8,
                   -21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9;
                   -57.5, 28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7,
                   78.1; 80, 80], style(color=0)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Text(
              extent=[-6, -24; 66, -72],
              string="log",
              style(color=8))),
          Diagram(
            Line(points=[-80, 80; -88, 80], style(color=8)),
            Line(points=[-80, -80; -88, -80], style(color=8)),
            Line(points=[-80, -90; -80, 84], style(color=8)),
            Text(
              extent=[-67, 98; -40, 80],
              string="y",
              style(color=9)),
            Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=
                    8, fillColor=8)),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8,
                   -21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9;
                   -57.5, 28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7,
                   78.1; 80, 80], style(color=0)),
            Text(extent=[-105, 72; -85, 88], string="3"),
            Text(extent=[-109, -88; -89, -72], string="-3"),
            Text(extent=[70, -3; 90, -23], string="20"),
            Text(extent=[-78, -1; -58, -21], string="1"),
            Text(
              extent=[68, 28; 94, 8],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>natural (base e) logarithm</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>log</b>( u );
</pre>
<p>
An error occurs if the elements of the input <b>u</b> are
zero or negative.
</p>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.23,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.log(u);
      end Log;
  
      block Log10 
    "Output the base 10 logarithm of the input (input > 0 required)" 
    
        extends Interfaces.SISO;
        annotation (
          Icon(
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Line(points=[-79.8, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8,
                   -21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9;
                   -57.5, 28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7,
                   78.1; 80, 80], style(color=0)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -80; -80, 68], style(color=8)),
            Text(
              extent=[-30, -22; 60, -70],
              string="log10",
              style(color=8))),
          Diagram(
            Line(points=[-80, 80; -88, 80], style(color=8)),
            Line(points=[-80, -80; -88, -80], style(color=8)),
            Line(points=[-80, -90; -80, 84], style(color=8)),
            Text(
              extent=[-65, 96; -38, 78],
              string="y",
              style(color=9)),
            Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=
                    8, fillColor=8)),
            Line(points=[-100, 0; 84, 0], style(color=8)),
            Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-79.8, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8,
                   -21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9;
                   -57.5, 28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7,
                   78.1; 80, 80], style(color=0)),
            Text(extent=[70, -3; 90, -23], string="20"),
            Text(extent=[-78, -1; -58, -21], string="1"),
            Text(extent=[-109, 72; -89, 88], string=" 1.3"),
            Text(extent=[-109, -88; -89, -72], string="-1.3"),
            Text(
              extent=[62, 30; 90, 10],
              string="u",
              style(color=9))),
          Documentation(info="
<HTML>
<p>
This blocks computes the output <b>y</b> (element-wise) as the
<i>base 10 logarithm</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>log10</b>( u );
</pre>
<p>
An error occurs if the elements of the input <b>u</b> are
zero or negative.
</p>

</HTML>
"),       Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.27,
            y=0.11,
            width=0.6,
            height=0.6));
      equation 
        y = Modelica.Math.log10(u);
      end Log10;
  
  block RealToInteger "Convert Real to Integer signal" 
    extends Interfaces.IntegerBlockIcon;
    annotation (Icon(
        Text(extent=[-100, 60; 0, -60], string="R"),
        Text(
          extent=[20, 60; 120, -60],
          string="I",
          style(color=45)),
        Polygon(points=[50, 0; 30, 20; 30, 10; 00, 10; 0, -10; 30, -10; 30, -20;
                50, 0], style(color=45, fillColor=45))), Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>nearest integer value</i> of the input <b>u</b>:
</p>
<pre>    y = <b>integer</b>( <b>floor</b>( u + 0.5 ) )  for  u &gt; 0;
    y = <b>integer</b>( <b>ceil </b>( u - 0.5 ) )  for  u &lt; 0;
</pre>
</html>
"));
  public 
    Interfaces.RealInput u "Connector of Real input signal" 
                           annotation (extent=[-140, -20; -100, 20]);
    Interfaces.IntegerOutput y "Connector of Integer output signal" 
                               annotation (extent=[100, -10;
          120, 10]);
  equation 
     y = if (u > 0) then integer(floor(u + 0.5)) else 
                         integer(ceil( u - 0.5));
  end RealToInteger;
  
  block IntegerToReal "Convert integer to real signals" 
    extends Interfaces.BlockIcon;
    annotation (Icon(
        Text(
          extent=[-120, 60; -20, -60],
          string="I",
          style(color=45)),
        Text(extent=[0, 60; 100, -60], string="R"),
        Polygon(points=[10, 0; -10, 20; -10, 10; -40, 10; -40, -10; -10, -10; -
              10, -20; 10, 0], style(fillColor=73))), Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>Real equivalent</i> of the Integer input <b>u</b>:
</p>
<pre>    y = u;
</pre>
<p>where <b>u</b> is of Integer and <b>y</b> of Real type.</p>
</html>
"));
    Interfaces.IntegerInput u "Connector of Integer input signal" 
                                                               annotation (extent=[-140, -20; -
          100, 20]);
    Interfaces.RealOutput y "Connector of Real output signal"  annotation (extent=[100, -10; 120, 10]);
  equation 
    y = u;
  end IntegerToReal;
  
  block BooleanToReal "Convert Boolean to Real signal" 
    extends Interfaces.partialBooleanSI;
    parameter Real realTrue=1.0 "Output signal for true Boolean input";
    parameter Real realFalse=0.0 "Output signal for false Boolean input";
    
    Blocks.Interfaces.RealOutput y "Connector of Real output signal" 
      annotation (extent=[100, -10; 120, 10]);
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.26,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>Real equivalent</i> of the Boolean input <b>u</b>:
</p>
<pre>    y = <b>if</b> u <b>then</b> realTrue <b>else</b> realFalse;
</pre>
<p>where <b>u</b> is of Boolean and <b>y</b> of Real type,
and <b>realTrue</b> and <b>realFalse</b> are parameters.
</p>
</html>
"),   Icon(
        Text(
          extent=[-86,92; -6,10],
          string="B",
          style(color=5, rgbcolor={255,0,255})),
        Polygon(points=[-12,-46; -32,-26; -32,-36; -64,-36; -64,-56; -32,-56; -32,
              -66; -12,-46],   style(fillColor=73)),
        Text(extent=[8,-4; 92,-94],    string="R")),
      Diagram);
    
  equation 
    y = if u then realTrue else realFalse;
  end BooleanToReal;
  
  block BooleanToInteger "Convert Boolean to Integer signal" 
    extends Interfaces.partialBooleanSI;
    parameter Integer integerTrue=1 "Output signal for true Boolean input";
    parameter Integer integerFalse=0 "Output signal for false Boolean input";
    
    Blocks.Interfaces.IntegerOutput y "Connector of Integer output signal" 
      annotation (extent=[100, -10; 120, 10]);
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.26,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>Integer equivalent</i> of the Boolean input <b>u</b>:
</p>
<pre>    y = <b>if</b> u <b>then</b> integerTrue <b>else</b> integerFalse;
</pre>
<p>where <b>u</b> is of Boolean and <b>y</b> of Integer type,
and <b>integerTrue</b> and <b>integerFalse</b> are parameters.
</p>
</html>
"),   Icon(
        Text(
          extent=[-86,92; -6,10],
          string="B",
          style(color=5, rgbcolor={255,0,255})),
        Polygon(points=[-12,-46; -32,-26; -32,-36; -64,-36; -64,-56; -32,-56; -32,
              -66; -12,-46], style(
              color=47,
              rgbcolor={255,170,85},
              fillColor=47,
              rgbfillColor={255,170,85})),
        Text(extent=[8,-4; 92,-94],
            string="I",
            style(color=47, rgbcolor={255,170,85}))),
      Diagram);
    
  equation 
    y = if u then integerTrue else integerFalse;
  end BooleanToInteger;
  
  block RealToBoolean "Convert Real to Boolean signal" 
    Blocks.Interfaces.RealInput u "Connector of Real input signal"  annotation(extent=[-140,-20; -100,20]);
    extends Interfaces.partialBooleanSO;
    parameter Real threshold=0.5 
      "Output signal y is true, if input u >= threshold";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.26,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>
This block computes the Boolean output <b>y</b>
from the Real input <b> u</b> by the equation:
</p>

<pre>    y = u &ge; threshold;
</pre>

<p>
where <b>threshold</b> is a parameter.
</p>
</html>"),
      Icon(
        Text(
          extent=[-86,92; -6,10],
          string="R",
          style(color=3, rgbcolor={0,0,255})),
        Polygon(points=[-12,-46; -32,-26; -32,-36; -64,-36; -64,-56; -32,-56; -32,
              -66; -12,-46], style(
            color=81,
            fillColor=81)),
        Text(extent=[8,-4; 92,-94],
          string="B",
          style(color=81))),
      Diagram);
    
  equation 
    y = u >= threshold;
  end RealToBoolean;
  
  block IntegerToBoolean "Convert Integer to Boolean signal" 
    Blocks.Interfaces.IntegerInput u "Connector of Integer input signal" annotation(extent=[-140,-20; -100,20]);
    extends Interfaces.partialBooleanSO;
    parameter Integer threshold=1 
      "Output signal y is true, if input u >= threshold";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.26,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>
This block computes the Boolean output <b>y</b>
from the Integer input <b> u</b> by the equation:
</p>

<pre>    y = u &ge; threshold;
</pre>

<p>
where <b>threshold</b> is a parameter.
</p>
</html>"),
      Icon(
        Text(
          extent=[-86,92; -6,10],
          style(color=45, rgbcolor={255,128,0}),
          string="I"),
        Polygon(points=[-12,-46; -32,-26; -32,-36; -64,-36; -64,-56; -32,-56; -32,
              -66; -12,-46], style(
            color=81,
            fillColor=81)),
        Text(extent=[8,-4; 92,-94],
          string="B",
          style(color=81))),
      Diagram);
    
  equation 
    y = u >= threshold;
  end IntegerToBoolean;
  
  block Max "Pass through the largest signal" 
    extends Interfaces.SI2SO;
    annotation (Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="max()")), Documentation(info="<html>
<p>
This block computes the output <b>y</b> as <i>maximum</i>
of the two Real inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>    y = <b>max</b> ( u1 , u2 );
</pre>
</html>
"));
  equation 
    y = max(u1, u2);
  end Max;
  
  block Min "Pass through the smallest signal" 
    extends Interfaces.SI2SO;
    annotation (Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="min()")), Documentation(info="<html>
<p>
This block computes the output <b>y</b> as <i>minimum</i> of
the two Real inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>    y = <b>min</b> ( u1 , u2 );
</pre>
</html>
"));
  equation 
     y = min(u1, u2);
  end Min;
  
  block Edge "Indicates rising edge of boolean signal" 
    extends Interfaces.BooleanSISO;
    annotation (Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="edge()")), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b> to true,
when the Boolean input <b>u</b> shows a <i>rising edge</i>:
</p>
<pre>    y = <b>edge</b>( u );
</pre>
</html>
"));
  equation 
    y = edge(u);
  end Edge;
  
  block BooleanChange "Indicates boolean signal changing" 
    extends Interfaces.BooleanSISO;
    annotation (Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="change()")), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b> to true, when the
Boolean input <b>u</b> shows a <i>rising or falling edge</i>,
i.e., when the signal changes:
</p>
<pre>    y = <b>change</b>( u );
</pre>
</html>
"));
  equation 
    y = change(u);
  end BooleanChange;
  
  block IntegerChange "Indicates integer signal changing" 
    extends Interfaces.IntegerSIBooleanSO;
    annotation (Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="change()")), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b> to true, when the
Integer input <b>u</b> changes:
</p>
<pre>    y = <b>change</b>( u );
</pre>
</html>
"));
  equation 
    y = change(u);
  end IntegerChange;
  
end Math;
