within Modelica.Blocks;
package Math "Library of Real mathematical functions as input/output blocks"
  import Modelica.SIunits;
  import Modelica.Blocks.Interfaces;
  extends Modelica.Icons.Package;

  encapsulated package UnitConversions
    "Conversion blocks to convert between SI and non-SI unit signals"
    import Modelica;
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Package;

    block To_degC "Convert from Kelvin to degCelsius"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
            unit="degC"));

    equation
      y = SI.Conversions.to_degC(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="K"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="degC")}), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to degCelsius and returns
the result as output signal.
</p>
</html>"));
    end To_degC;

    block From_degC "Convert from degCelsius to Kelvin"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degC"),
          y(unit="K"));
    equation
      y = SI.Conversions.from_degC(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="degC"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="K")}), Documentation(info="<html>
<p>
This block converts the input signal from degCelsius to Kelvin and returns
the result as output signal.
</p>
</html>"));
    end From_degC;

    block To_degF "Convert from Kelvin to degFahrenheit"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
            unit="degF"));
    equation
      y = SI.Conversions.to_degF(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="K"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="degF")}), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to degFahrenheit and returns
the result as output signal.
</p>
</html>"));
    end To_degF;

    block From_degF "Convert from degFahrenheit to Kelvin"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degF"),
          y(unit="K"));
    equation
      y = SI.Conversions.from_degF(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="degF"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="K")}), Documentation(info="<html>
<p>
This block converts the input signal from degFahrenheit to Kelvin and returns
the result as output signal.
</p>
</html>"));
    end From_degF;

    block To_degRk "Convert from Kelvin to degRankine"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
            unit="degRk"));
    equation
      y = SI.Conversions.to_degRk(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="K"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="degRk")}), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to degRankine and returns
the result as output signal.
</p>
</html>"));
    end To_degRk;

    block From_degRk "Convert from degRankine to Kelvin"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degRk"),
          y(unit="K"));
    equation
      y = SI.Conversions.from_degRk(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="degRk"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="K")}), Documentation(info="<html>
<p>
This block converts the input signal from degRankine to Kelvin and returns
the result as output signal.
</p>
</html>"));
    end From_degRk;

    block To_deg "Convert from radian to degree"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="rad"),
          y(unit="deg"));
    equation
      y = SI.Conversions.to_deg(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="rad"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="deg")}), Documentation(info="<html>
<p>
This block converts the input signal from radian to degree and returns
the result as output signal.
</p>
</html>"));
    end To_deg;

    block From_deg "Convert from degree to radian"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="deg"),
          y(unit="rad"));
    equation
      y = SI.Conversions.from_deg(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="deg"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="rad")}), Documentation(info="<html>
<p>
This block converts the input signal from degree to radian and returns
the result as output signal.
</p>
</html>"));
    end From_deg;

    block To_rpm "Convert from radian per second to revolutions per minute"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="rad/s"),
          y(unit="rev/min"));
    equation
      y = SI.Conversions.to_rpm(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{26,82},{-98,50}},
                  lineColor={0,0,0},
                  textString="rad/s"),Text(
                  extent={{100,-42},{-62,-74}},
                  lineColor={0,0,0},
                  textString="rev/min")}), Documentation(info="<html>
<p>
This block converts the input signal from radian per second to revolutions per minute and returns
the result as output signal.
</p>
</html>"));
    end To_rpm;

    block From_rpm "Convert from revolutions per minute to radian per second"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="rev/min"),
          y(unit="rad/s"));
    equation
      y = SI.Conversions.from_rpm(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{50,84},{-94,56}},
                  lineColor={0,0,0},
                  textString="rev/min"),Text(
                  extent={{94,-42},{-26,-74}},
                  lineColor={0,0,0},
                  textString="rad/s")}), Documentation(info="<html>
<p>
This block converts the input signal from revolutions per minute to radian per second and returns
the result as output signal.
</p>
</html>"));
    end From_rpm;

    block To_kmh "Convert from metre per second to kilometre per hour"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="m/s"),
          y(unit="km/h"));
    equation
      y = SI.Conversions.to_kmh(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{0,82},{-96,42}},
                  lineColor={0,0,0},
                  textString="m/s"),Text(
                  extent={{92,-40},{-14,-84}},
                  lineColor={0,0,0},
                  textString="km/h")}), Documentation(info="<html>
<p>
This block converts the input signal from metre per second to kilometre per hour and returns
the result as output signal.
</p>
</html>"));
    end To_kmh;

    block From_kmh "Convert from kilometre per hour to metre per second"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="km/h"),
          y(unit="m/s"));
    equation
      y = SI.Conversions.from_kmh(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{26,80},{-96,48}},
                  lineColor={0,0,0},
                  textString="km/h"),Text(
                  extent={{92,-46},{-20,-82}},
                  lineColor={0,0,0},
                  textString="m/s")}), Documentation(info="<html>
<p>
This block converts the input signal from kilometre per hour to metre per second and returns
the result as output signal.
</p>
</html>"));
    end From_kmh;

    block To_day "Convert from second to day"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
            unit="d"));
    equation
      y = SI.Conversions.to_day(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="s"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="day")}), Documentation(info="<html>
<p>
This block converts the input signal from second to day and returns
the result as output signal.
</p>
</html>"));
    end To_day;

    block From_day "Convert from day to second"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="d"), y(
            unit="s"));
    equation
      y = SI.Conversions.from_day(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="day"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="s")}), Documentation(info="<html>
<p>
This block converts the input signal from day to second and returns
the result as output signal.
</p>
</html>"));
    end From_day;

    block To_hour "Convert from second to hour"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
            unit="h"));
    equation
      y = SI.Conversions.to_hour(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="s"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="hour")}), Documentation(info="<html>
<p>
This block converts the input signal from second to hour and returns
the result as output signal.
</p>
</html>"));
    end To_hour;

    block From_hour "Convert from hour to second"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="h"), y(
            unit="s"));
    equation
      y = SI.Conversions.from_hour(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="hour"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="s")}), Documentation(info="<html>
<p>
This block converts the input signal from hour to second and returns
the result as output signal.
</p>
</html>"));
    end From_hour;

    block To_minute "Convert from second to minute"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
            unit="min"));
    equation
      y = SI.Conversions.to_minute(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="s"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="minute")}), Documentation(info="<html>
<p>
This block converts the input signal from second to minute and returns
the result as output signal.
</p>
</html>"));
    end To_minute;

    block From_minute "Convert from minute to second"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="min"),
          y(unit="s"));
    equation
      y = SI.Conversions.from_minute(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="minute"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="s")}), Documentation(info="<html>
<p>
This block converts the input signal from minute to second and returns
the result as output signal.
</p>
</html>"));
    end From_minute;

    block To_litre "Convert from cubic metre to litre"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="m3"), y(
            unit="l"));
    equation
      y = SI.Conversions.to_litre(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="m3"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="litre")}), Documentation(info="<html>
<p>
This block converts the input signal from metre to litre and returns
the result as output signal.
</p>
</html>"));
    end To_litre;

    block From_litre "Convert from litre to cubic metre"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="l"), y(
            unit="m3"));
    equation
      y = SI.Conversions.from_litre(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="litre"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="m3")}), Documentation(info="<html>
<p>
This block converts the input signal from litre to cubic metre and returns
the result as output signal.
</p>
</html>"));
    end From_litre;

    block To_kWh "Convert from Joule to kilo Watt hour"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="J"), y(
            unit="kW.h"));
    equation
      y = SI.Conversions.to_kWh(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="J"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="kW.h")}), Documentation(info="<html>
<p>
This block converts the input signal from Joule to kilo Watt hour and returns
the result as output signal.
</p>
</html>"));
    end To_kWh;

    block From_kWh "Convert from kilo Watt hour to Joule"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="kW.h"),
          y(unit="J"));
    equation
      y = SI.Conversions.from_kWh(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="kW.h"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="J")}), Documentation(info="<html>
<p>
This block converts the input signal from kilo Watt hour to Joule and returns
the result as output signal.
</p>
</html>"));
    end From_kWh;

    block To_bar "Convert from Pascal to bar"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="Pa"), y(
            unit="bar"));
    equation
      y = SI.Conversions.to_bar(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="Pa"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="bar")}), Documentation(info="<html>
<p>
This block converts the input signal from Pascal to bar and returns
the result as output signal.
</p>
</html>"));
    end To_bar;

    block From_bar "Convert from bar to Pascal"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="bar"),
          y(unit="Pa"));
    equation
      y = SI.Conversions.from_bar(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="bar"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="Pa")}), Documentation(info="<html>
<p>
This block converts the input signal from bar to Pascal and returns
the result as output signal.
</p>
</html>"));
    end From_bar;

    block To_gps "Convert from kilogram per second to gram per second"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="kg/s"),
          y(unit="g/s"));
    equation
      y = SI.Conversions.to_gps(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="kg/s"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="g/s")}), Documentation(info="<html>
<p>
This block converts the input signal from kilogram per second to gram per seconds and returns
the result as output signal.
</p>
</html>"));
    end To_gps;

    block From_gps "Convert from gram per second to kilogram per second"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="g/s"),
          y(unit="kg/s"));
    equation
      y = SI.Conversions.from_gps(u);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-20,100},{-100,20}},
                  lineColor={0,0,0},
                  textString="g/s"),Text(
                  extent={{100,-20},{20,-100}},
                  lineColor={0,0,0},
                  textString="kg/s")}), Documentation(info="<html>
<p>
This block converts the input signal from gram per second to kilogram per second and returns
the result as output signal.
</p>
</html>"));
    end From_gps;
    annotation (Documentation(info="<html>
<p>
This package consists of blocks that convert an input signal
with a specific unit to an output signal in another unit
(e.g., conversion of an angle signal from \"deg\" to \"rad\").
</p>

</html>"));
  end UnitConversions;

  block InverseBlockConstraints
    "Construct inverse model by requiring that two inputs and two outputs are identical"

    Modelica.Blocks.Interfaces.RealInput u1 "Input signal 1 (u1 = u2)"
      annotation (Placement(transformation(extent={{-240,-20},{-200,20}}), iconTransformation(extent={{-240,-20},{-200,20}})));
    Modelica.Blocks.Interfaces.RealInput u2 "Input signal 2 (u1 = u2)"
      annotation (Placement(transformation(extent={{-140,-20},{-180,20}}), iconTransformation(extent={{-140,-20},{-180,20}})));
    Modelica.Blocks.Interfaces.RealOutput y1 "Output signal 1 (y1 = y2)"
      annotation (Placement(transformation(extent={{200,-10},{220,10}}), iconTransformation(extent={{200,-10},{220,10}})));
    Modelica.Blocks.Interfaces.RealOutput y2 "Output signal 2 (y1 = y2)"
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          origin={170,0}), iconTransformation(extent={{180,-10},{160,10}})));

  equation
    u1 = u2;
    y1 = y2;
    annotation (
      defaultConnectionStructurallyInconsistent=true,
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-120},{200,
              120}}), graphics={
          Line(
            points={{180,0},{200,0}},
            color={0,0,127}),
          Line(
            points={{-200,0},{-180,0}},
            color={0,0,127}),
          Rectangle(extent={{-190,120},{190,-120}}, lineColor={135,135,135})}),
      Documentation(info="<html>
<p>
Exchange input and output signals of a block, i.e., the previous
block inputs become block outputs and the previous block outputs become
block inputs. This block is used to construct inverse models.
Its usage is demonstrated in example:
<a href=\"modelica://Modelica.Blocks.Examples.InverseModel\">Modelica.Blocks.Examples.InverseModel</a>.
</p>

<p>
Note, if a block shall be inverted that has several input and output blocks,
then this can be easily achieved by using a vector of InverseBlockConstraints
instances:
</p>

<pre>
   InverseBlockConstraint invert[3];  // Block to be inverted has 3 input signals
</pre>
</html>"));
  end InverseBlockConstraints;

  block Gain "Output the product of a gain value with the input signal"

    parameter Real k(start=1, unit="1")
      "Gain value multiplied with input signal";
  public
    Interfaces.RealInput u "Input signal connector" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    Interfaces.RealOutput y "Output signal connector" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));

  equation
    y = k*u;
    annotation (
      Documentation(info="<html>
<p>
This block computes output <i>y</i> as
<i>product</i> of gain <i>k</i> with the
input <i>u</i>:
</p>
<pre>
    y = k * u;
</pre>

</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-100,-100},{-100,100},{100,0},{-100,-100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,-140},{150,-100}},
            lineColor={0,0,0},
            textString="k=%k"),
          Text(
            extent={{-150,140},{150,100}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-100,-100},{-100,100},{100,0},{-100,-100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-76,38},{0,-34}},
              textString="k",
              lineColor={0,0,255})}));
  end Gain;

  block MatrixGain
    "Output the product of a gain matrix with the input signal vector"

    parameter Real K[:, :]=[1, 0; 0, 1]
      "Gain matrix which is multiplied with the input";
    extends Interfaces.MIMO(final nin=size(K, 2), final nout=size(K, 1));
  equation
    y = K*u;
    annotation (
      Documentation(info="<html>
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

</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,-60},{90,60}},
            lineColor={160,160,164},
            textString="*K"), Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-90,-60},{90,60}},
              lineColor={160,160,164},
              textString="*K")}));
  end MatrixGain;

  block MultiSum "Sum of Reals: y = k[1]*u[1] + k[2]*u[2] + ... + k[n]*u[n]"
    extends Modelica.Blocks.Interfaces.PartialRealMISO;
    parameter Real k[nu]=fill(1, nu) "Input gains";
  equation
    if size(u, 1) > 0 then
      y = k*u;
    else
      y = 0;
    end if;

    annotation (Icon(graphics={Text(
            extent={{-200,-110},{200,-140}},
            lineColor={0,0,0},
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid,
            textString="%k"), Text(
            extent={{-72,68},{92,-68}},
            lineColor={0,0,0},
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid,
            textString="+")}), Documentation(info="<html>
<p>
This blocks computes the scalar Real output \"y\" as sum of the elements of the
Real input signal vector u:
</p>
<blockquote><pre>
y = k[1]*u[1] + k[2]*u[2] + ... k[N]*u[N];
</pre></blockquote>

<p>
The input connector is a vector of Real input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to zero: y=0.
</p>

</html>"));
  end MultiSum;

  block MultiProduct "Product of Reals: y = u[1]*u[2]* ... *u[n]"
    extends Modelica.Blocks.Interfaces.PartialRealMISO;
  equation
    if size(u, 1) > 0 then
      y = product(u);
    else
      y = 0;
    end if;

    annotation (Icon(graphics={Text(
            extent={{-74,50},{94,-94}},
            lineColor={0,0,0},
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid,
            textString="*")}), Documentation(info="<html>
<p>
This blocks computes the scalar Real output \"y\" as product of the elements of the
Real input signal vector u:
</p>
<blockquote><pre>
y = u[1]*u[2]* ... *u[N];
</pre></blockquote>

<p>
The input connector is a vector of Real input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to zero: y=0.
</p>
</html>"));
  end MultiProduct;

  block MultiSwitch
    "Set Real expression that is associated with the first active input signal"

    input Real expr[nu]=fill(0.0, nu)
      "y = if u[i] then expr[i] else y_default (time varying)"
      annotation (Dialog);
    parameter Real y_default=0.0
      "Default value of output y if all u[i] = false";

    parameter Integer nu(min=0) = 0 "Number of input connections"
      annotation (Dialog(connectorSizing=true), HideResult=true);
    parameter Integer precision(min=0) = 3
      "Number of significant digits to be shown in dynamic diagram layer for y"
      annotation (Dialog(tab="Advanced"));

    Modelica.Blocks.Interfaces.BooleanVectorInput u[nu]
      "Set y = expr[i], if u[i] = true"
      annotation (Placement(transformation(extent={{-110,30},{-90,-30}})));
    Modelica.Blocks.Interfaces.RealOutput y "Output depending on expression"
      annotation (Placement(transformation(extent={{300,-10},{320,10}})));

  protected
    Integer firstActiveIndex;
  initial equation
    pre(u) = fill(false, nu);
  equation
    firstActiveIndex = Modelica.Math.BooleanVectors.firstTrueIndex(u);
    y = if firstActiveIndex == 0 then y_default else expr[firstActiveIndex];
    annotation (
      defaultComponentName="multiSwitch1",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{300,
              100}}), graphics={
          Rectangle(
            extent={{-100,-51},{300,50}},
            lineThickness=5.0,
            lineColor={0,0,0},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-86,16},{295,-17}},
            lineColor={0,0,0},
            fillColor={255,246,238},
            fillPattern=FillPattern.Solid,
            textString="%expr"),
          Text(
            extent={{310,-25},{410,-45}},
            lineColor={0,0,0},
            textString=DynamicSelect(" ", String(
                  y,
                  minimumLength=1,
                  significantDigits=precision))),
          Text(
            extent={{-100,-60},{300,-90}},
            lineColor={0,0,0},
            textString="else: %y_default"),
          Text(
            extent={{-100,100},{300,60}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<html>
<p>
This block has a vector of Boolean input signals u[nu] and a vector of
(time varying) Real expressions expr[nu]. The output signal y is
set to expr[i], if i is the first element in the input vector u that is true. If all input signals are
false, y is set to parameter \"y_default\".
</p>

<blockquote><pre>
  // Conceptual equation (not valid Modelica)
  i = 'first element of u[:] that is true';
  y = <b>if</b> i==0 <b>then</b> y_default <b>else</b> expr[i];
</pre></blockquote>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>

</html>"));
  end MultiSwitch;

  block Sum "Output the sum of the elements of the input vector"
    extends Interfaces.MISO;
    parameter Real k[nin]=ones(nin) "Optional: sum coefficients";
  equation
    y = k*u;
    annotation (
      defaultComponentName="sum1",
      Documentation(info="<html>
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

</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(
            points={{26,42},{-34,42},{6,2},{-34,-38},{26,-38}}), Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(
              points={{26,42},{-34,42},{6,2},{-34,-38},{26,-38}})}));
  end Sum;

  block Feedback "Output difference between commanded and feedback input"

    Interfaces.RealInput u1 annotation (Placement(transformation(extent={{-100,
              -20},{-60,20}})));
    Interfaces.RealInput u2 annotation (Placement(transformation(
          origin={0,-80},
          extent={{-20,-20},{20,20}},
          rotation=90)));
    Interfaces.RealOutput y annotation (Placement(transformation(extent={{80,-10},
              {100,10}})));

  equation
    y = u1 - u2;
    annotation (
      Documentation(info="<html>
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

</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            lineColor={0,0,127},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            extent={{-20,-20},{20,20}}),
          Line(points={{-60,0},{-20,0}}, color={0,0,127}),
          Line(points={{20,0},{80,0}}, color={0,0,127}),
          Line(points={{0,-20},{0,-60}}, color={0,0,127}),
          Text(extent={{-14,-94},{82,0}}, textString="-"),
          Text(
            lineColor={0,0,255},
            extent={{-150,44},{150,94}},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
              extent={{-20,20},{20,-20}},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),Line(points={{-60,0},{-20,0}}, color={0,0,
            255}),Line(points={{20,0},{80,0}}, color={0,0,255}),Line(points={{0,
            -20},{0,-60}}, color={0,0,255}),Text(
              extent={{-12,10},{84,-84}},
              lineColor={0,0,0},
              textString="-")}));
  end Feedback;

  block Add "Output the sum of the two inputs"
    extends Interfaces.SI2SO;

    parameter Real k1=+1 "Gain of upper input";
    parameter Real k2=+1 "Gain of lower input";

  equation
    y = k1*u1 + k2*u2;
    annotation (
      Documentation(info="<html>
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

</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString="%name"),
          Line(points={{-100,60},{-74,24},{-44,24}}, color={0,0,127}),
          Line(points={{-100,-60},{-74,-28},{-42,-28}}, color={0,0,127}),
          Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}}),
          Line(points={{50,0},{100,0}}, color={0,0,127}),
          Text(extent={{-38,-34},{38,34}}, textString="+"),
          Text(extent={{-100,52},{5,92}}, textString="%k1"),
          Text(extent={{-100,-92},{5,-52}}, textString="%k2")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{50,0},{100,0}},
            color={0,0,255}),Line(points={{-100,60},{-74,24},{-44,24}}, color={
            0,0,127}),Line(points={{-100,-60},{-74,-28},{-42,-28}}, color={0,0,
            127}),Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,0,127}),Line(
            points={{50,0},{100,0}}, color={0,0,127}),Text(
              extent={{-36,38},{40,-30}},
              lineColor={0,0,0},
              textString="+"),Text(
              extent={{-100,52},{5,92}},
              lineColor={0,0,0},
              textString="k1"),Text(
              extent={{-100,-52},{5,-92}},
              lineColor={0,0,0},
              textString="k2")}));
  end Add;

  block Add3 "Output the sum of the three inputs"
    extends Modelica.Blocks.Icons.Block;

    parameter Real k1=+1 "Gain of upper input";
    parameter Real k2=+1 "Gain of middle input";
    parameter Real k3=+1 "Gain of lower input";
    Interfaces.RealInput u1 "Connector 1 of Real input signals" annotation (
        Placement(transformation(extent={{-140,60},{-100,100}})));
    Interfaces.RealInput u2 "Connector 2 of Real input signals" annotation (
        Placement(transformation(extent={{-140,-20},{-100,20}})));
    Interfaces.RealInput u3 "Connector 3 of Real input signals" annotation (
        Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Interfaces.RealOutput y "Connector of Real output signals" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));

  equation
    y = k1*u1 + k2*u2 + k3*u3;
    annotation (
      Documentation(info="<html>
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

</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-100,50},{5,90}},
            lineColor={0,0,0},
            textString="%k1"),
          Text(
            extent={{-100,-20},{5,20}},
            lineColor={0,0,0},
            textString="%k2"),
          Text(
            extent={{-100,-50},{5,-90}},
            lineColor={0,0,0},
            textString="%k3"),
          Text(
            extent={{2,36},{100,-44}},
            lineColor={0,0,0},
            textString="+")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-100,50},{5,90}},
              lineColor={0,0,0},
              textString="k1"),Text(
              extent={{-100,-20},{5,20}},
              lineColor={0,0,0},
              textString="k2"),Text(
              extent={{-100,-50},{5,-90}},
              lineColor={0,0,0},
              textString="k3"),Text(
              extent={{2,46},{100,-34}},
              lineColor={0,0,0},
              textString="+")}));
  end Add3;

  block Product "Output product of the two inputs"
    extends Interfaces.SI2SO;

  equation
    y = u1*u2;
    annotation (
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <i>product</i> of the corresponding elements of
the two inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>
    y = u1 * u2;
</pre>

</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,60},{-40,60},{-30,40}}, color={0,0,127}),
          Line(points={{-100,-60},{-40,-60},{-30,-40}}, color={0,0,127}),
          Line(points={{50,0},{100,0}}, color={0,0,127}),
          Line(points={{-30,0},{30,0}}),
          Line(points={{-15,25.99},{15,-25.99}}),
          Line(points={{-15,-25.99},{15,25.99}}),
          Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{-100,60},{-40,60},{-30,
            40}}, color={0,0,255}),Line(points={{-100,-60},{-40,-60},{-30,-40}},
            color={0,0,255}),Line(points={{50,0},{100,0}}, color={0,0,255}),
            Line(points={{-30,0},{30,0}}),Line(points={{-15,
            25.99},{15,-25.99}}),Line(points={{-15,-25.99},{15,
            25.99}}),Ellipse(extent={{-50,50},{50,-50}},
            lineColor={0,0,255})}));
  end Product;

  block Division "Output first input divided by second input"
    extends Interfaces.SI2SO;

  equation
    y = u1/u2;
    annotation (
      Documentation(info="<html>
<p>
This block computes the output <b>y</b> (element-wise)
by <i>dividing</i> the corresponding elements of
the two inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>
    y = u1 / u2;
</pre>

</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{50,0},{100,0}}, color={0,0,127}),
          Line(points={{-30,0},{30,0}}),
          Ellipse(fillPattern=FillPattern.Solid, extent={{-5,20},{5,30}}),
          Ellipse(fillPattern=FillPattern.Solid, extent={{-5,-30},{5,-20}}),
          Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}}),
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString="%name"),
          Line(points={{-100,60},{-66,60},{-40,30}}, color={0,0,127}),
          Line(points={{-100,-60},{0,-60},{0,-50}}, color={0,0,127})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{50,0},{100,0}},
            color={0,0,255}),Line(points={{-30,0},{30,0}}),
            Ellipse(
              extent={{-5,20},{5,30}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-5,-20},{5,-30}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},
            lineColor={0,0,255}),Line(points={{-100,60},{-66,60},{-40,30}},
            color={0,0,255}),Line(points={{-100,-60},{0,-60},{0,-50}}, color={0,
            0,255})}));
  end Division;

  block Abs "Output the absolute value of the input"
    extends Interfaces.SISO;
    parameter Boolean generateEvent=false
      "Choose whether events shall be generated" annotation (Evaluate=true);
  equation
    //y = abs(u);
    y = if generateEvent then (if u >= 0 then u else -u) else (if noEvent(u >=
      0) then u else -u);
    annotation (
      defaultComponentName="abs1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{92,0},{70,8},{70,-8},{92,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,80},{0,0},{80,80}}),
          Line(points={{0,-14},{0,68}}, color={192,192,192}),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-34,-28},{38,-76}},
            lineColor={192,192,192},
            textString="abs"),
          Line(points={{-88,0},{76,0}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-100,0},{76,0}}, color={192,
            192,192}),Polygon(
              points={{92,0},{76,6},{76,-6},{92,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,80},{0,0},{80,80}}),Line(points={{0,-80},{0,68}}, color={192,192,192}),
            Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{0,-80},{0,68}},
            color={192,192,192}),Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{7,98},{34,78}},
              lineColor={160,160,164},
              textString="u"),Text(
              extent={{74,-8},{96,-28}},
              lineColor={160,160,164},
              textString="y"),Text(
              extent={{52,-3},{72,-23}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{-86,-1},{-66,-21}},
              textString="-1",
              lineColor={0,0,255}),Text(
              extent={{-28,79},{-8,59}},
              textString="1",
              lineColor={0,0,255})}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b>
as <i>absolute value</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>abs</b>( u );
</pre>
<p>
The Boolean parameter generateEvent decides whether Events are generated at zero crossing (Modelica specification before 3) or not.
</p>
</html>"));
  end Abs;

  block Sign "Output the sign of the input"
    extends Interfaces.SISO;
    parameter Boolean generateEvent=false
      "Choose whether events shall be generated" annotation (Evaluate=true);
  equation
    //y = sign(u);
    y = if generateEvent then (if u > 0 then 1 elseif u < 0 then -1 else 0)
       else (if noEvent(u > 0) then 1 elseif noEvent(u < 0) then -1 else 0);
    annotation (
      defaultComponentName="sign1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{0,-80}}),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Text(
            extent={{-90,72},{-18,24}},
            lineColor={192,192,192},
            textString="sign"),
          Line(points={{0,80},{80,80}}),
          Rectangle(
            extent={{-2,2},{2,-4}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-90,0},{68,0}}, color={192,
            192,192}),Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{0,-80}}),Line(points={{-0.01,0},{0.01,0}}),
            Line(points={{0,80},{80,80}}),Rectangle(
              extent={{-2,2},{2,-4}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{0,-90},{0,84}},
            color={192,192,192}),Text(
              extent={{7,102},{32,82}},
              lineColor={160,160,164},
              textString="y"),Text(
              extent={{70,-6},{94,-26}},
              lineColor={160,160,164},
              textString="u"),Text(
              extent={{-25,86},{-5,70}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{5,-72},{25,-88}},
              textString="-1",
              lineColor={0,0,255})}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b>
as <b>sign</b> of the input <b>u</b>:
</p>
<pre>
         1  <b>if</b> u &gt; 0
    y =  0  <b>if</b> u == 0
        -1  <b>if</b> u &lt; 0
</pre>
<p>
The Boolean parameter generateEvent decides whether Events are generated at zero crossing (Modelica specification before 3) or not.
</p>
</html>"));
  end Sign;

  block Sqrt "Output the square root of the input (input >= 0 required)"
    extends Interfaces.SISO;

  equation
    y = sqrt(u);
    annotation (
      defaultComponentName="sqrt1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-80},{-79.2,-68.7},{-78.4,-64},{-76.8,-57.3},{-73.6,-47.9},
                {-67.9,-36.1},{-59.1,-22.2},{-46.2,-6.49},{-28.5,10.7},{-4.42,
                30},{27.7,51.3},{69.5,74.7},{80,80}},
            smooth=Smooth.Bezier),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-88},{-80,68}}, color={192,192,192}),
          Text(
            extent={{-8,-4},{64,-52}},
            lineColor={192,192,192},
            textString="sqrt")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-92,-80},{84,-80}}, color={
            192,192,192}),Polygon(
              points={{100,-80},{84,-74},{84,-86},{100,-80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,-68.7},
            {-78.4,-64},{-76.8,-57.3},{-73.6,-47.9},{-67.9,-36.1},{-59.1,-22.2},
            {-46.2,-6.49},{-28.5,10.7},{-4.42,30},{27.7,51.3},{69.5,74.7},{80,
            80}}),Polygon(
              points={{-80,98},{-86,82},{-74,82},{-80,98}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-90},{-80,84}},
            color={192,192,192}),Text(
              extent={{-71,98},{-44,78}},
              lineColor={160,160,164},
              textString="y"),Text(
              extent={{60,-52},{84,-72}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b>
as <i>square root</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>sqrt</b>( u );
</pre>
<p>
All elements of the input vector shall be zero or positive.
Otherwise an error occurs.
</p>

</html>"));
  end Sqrt;

  block Sin "Output the sine of the input"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.sin(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Line(
            points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},
                {-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},
                {-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},
                {29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{
                57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}},
            smooth=Smooth.Bezier),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{12,84},{84,36}},
            lineColor={192,192,192},
            textString="sin")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={192,
            192,192}),Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
            Line(points={{-80,-90},{-80,84}}, color={192,192,192}),Text(
              extent={{-75,98},{-46,78}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{-80,96},{-86,80},{-74,80},{-80,96}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
            color={192,192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,0},{-68.7,34.2},
            {-61.5,53.1},{-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,
            76.6},{-26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},
            {17.3,-50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,
            -77.6},{51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}),Text(
              extent={{-105,72},{-85,88}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{70,25},{90,5}},
              textString="2*pi",
              lineColor={0,0,255}),Text(
              extent={{-105,-72},{-85,-88}},
              textString="-1",
              lineColor={0,0,255}),Text(
              extent={{76,-10},{98,-30}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b>
as <b>sine</b> of the input <b>u</b>:
</p>
<pre>
    y = <b>sin</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\"
     alt=\"sin.png\">
</p>

</html>"));
  end Sin;

  block Cos "Output the cosine of the input"
    extends Interfaces.SISO;

  equation
    y = Modelica.Math.cos(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},
                {-48.6,26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},
                {-4.42,-78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,-60.6},
                {24.5,-45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},{
                69.5,73.4},{75.2,78.6},{80,80}},
            smooth=Smooth.Bezier),
          Text(
            extent={{-36,82},{36,34}},
            lineColor={192,192,192},
            textString="cos")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={192,
            192,192}),Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
            Line(points={{-80,-90},{-80,84}}, color={192,192,192}),Text(
              extent={{-75,102},{-48,82}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-103,72},{-83,88}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{-79,-72},{-59,-88}},
              textString="-1",
              lineColor={0,0,255}),Text(
              extent={{70,25},{90,5}},
              textString="2*pi",
              lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={192,
            192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,80},{-74.4,78.1},
            {-68.7,72.3},{-63.1,63},{-56.7,48.7},{-48.6,26.6},{-29.3,-32.5},{-22.1,
            -51.7},{-15.7,-65.3},{-10.1,-73.8},{-4.42,-78.8},{1.21,-79.9},{6.83,
            -77.1},{12.5,-70.6},{18.1,-60.6},{24.5,-45.7},{32.6,-23},{50.3,31.3},
            {57.5,50.7},{63.9,64.6},{69.5,73.4},{75.2,78.6},{80,80}}, color={0,
            0,0}),Text(
              extent={{74,-4},{98,-24}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b>
as <b>cos</b> of the input <b>u</b>:
</p>
<pre>
    y = <b>cos</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\"
     alt=\"cos.png\">
</p>

</html>"));
  end Cos;

  block Tan "Output the tangent of the input"
    extends Interfaces.SISO;

  equation
    y = Modelica.Math.tan(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Line(
            points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},
                {-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},
                {33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{70.4,39.1},{
                73.6,47.4},{76,56.1},{77.6,63.8},{80,80}},
            smooth=Smooth.Bezier),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-90,72},{-18,24}},
            lineColor={192,192,192},
            textString="tan")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-88},{0,86}}, color={192,192,192}),Text(
              extent={{11,100},{38,80}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,102},{-6,86},{6,86},{0,102}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-37,-72},{-17,-88}},
              textString="-5.8",
              lineColor={0,0,255}),Text(
              extent={{-33,86},{-13,70}},
              textString=" 5.8",
              lineColor={0,0,255}),Text(
              extent={{70,25},{90,5}},
              textString="1.4",
              lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={192,
            192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-78.4,-68.4},
            {-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},{-67.1,-33},{-60.7,-24.8},{
            -51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},{33.4,9.12},{49.4,16.2},{
            59.1,23.2},{65.5,30.6},{70.4,39.1},{73.6,47.4},{76,56.1},{77.6,63.8},
            {80,80}}),Text(
              extent={{70,-6},{94,-26}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b>
as <b>tan</b> of the input <b>u</b>:
</p>
<pre>
    y = <b>tan</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\"
     alt=\"tan.png\">
</p>

</html>"));
  end Tan;

  block Asin "Output the arc sine of the input"
    extends Interfaces.SISO;

  equation
    y = Modelica.Math.asin(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Line(
            points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,
                -49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{
                68.7,52.7},{75.2,62.2},{77.6,67.5},{80,80}},
            smooth=Smooth.Bezier),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-88,78},{-16,30}},
            lineColor={192,192,192},
            textString="asin")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-90},{0,84}}, color={192,192,192}),Text(
              extent={{9,102},{36,82}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-40,-72},{-15,-88}},
              textString="-pi/2",
              lineColor={0,0,255}),Text(
              extent={{-38,88},{-13,72}},
              textString=" pi/2",
              lineColor={0,0,255}),Text(
              extent={{70,25},{90,5}},
              textString="+1",
              lineColor={0,0,255}),Text(
              extent={{-90,21},{-70,1}},
              textString="-1",
              lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={192,
            192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,-72.8},
            {-77.6,-67.5},{-73.6,-59.4},{-66.3,-49.8},{-53.5,-37.3},{-30.2,-19.7},
            {37.4,24.8},{57.5,40.8},{68.7,52.7},{75.2,62.2},{77.6,67.5},{80,80}}),Text(
              extent={{74,-4},{100,-26}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
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

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\"
     alt=\"atan.png\">
</p>

</html>"));
  end Asin;

  block Acos "Output the arc cosine of the input"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.acos(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,80},{-79.2,72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,49.8},
                {-53.5,37.3},{-30.2,19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},
                {75.2,-62.2},{77.6,-67.5},{80,-80}},
            smooth=Smooth.Bezier),
          Line(points={{0,-88},{0,68}}, color={192,192,192}),
          Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-86,-14},{-14,-62}},
            lineColor={192,192,192},
            textString="acos")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-90},{0,84}}, color={192,192,192}),Text(
              extent={{13,100},{42,82}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,-80},{84,-80}},
            color={192,192,192}),Polygon(
              points={{100,-80},{84,-74},{84,-86},{100,-80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,80},{-79.2,72.8},
            {-77.6,67.5},{-73.6,59.4},{-66.3,49.8},{-53.5,37.3},{-30.2,19.7},{
            37.4,-24.8},{57.5,-40.8},{68.7,-52.7},{75.2,-62.2},{77.6,-67.5},{80,
            -80}}),Text(
              extent={{-30,88},{-5,72}},
              textString=" pi",
              lineColor={0,0,255}),Text(
              extent={{-94,-57},{-74,-77}},
              textString="-1",
              lineColor={0,0,255}),Text(
              extent={{80,-45},{100,-65}},
              textString="+1",
              lineColor={0,0,255}),Text(
              extent={{76,-84},{102,-102}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
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

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\"
     alt=\"acos.png\">
</p>

</html>"));
  end Acos;

  block Atan "Output the arc tangent of the input"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.atan(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Line(
            points={{-80,-80},{-52.7,-75.2},{-37.4,-69.7},{-26.9,-63},{-19.7,-55.2},
                {-14.1,-45.8},{-10.1,-36.4},{-6.03,-23.9},{-1.21,-5.06},{5.23,
                21},{9.25,34.1},{13.3,44.2},{18.1,52.9},{24.5,60.8},{33.4,67.6},
                {47,73.6},{69.5,78.6},{80,80}},
            smooth=Smooth.Bezier),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-86,68},{-14,20}},
            lineColor={192,192,192},
            textString="atan")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-90},{0,84}}, color={192,192,192}),Text(
              extent={{13,102},{42,82}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
            color={192,192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-52.7,-75.2},
            {-37.4,-69.7},{-26.9,-63},{-19.7,-55.2},{-14.1,-45.8},{-10.1,-36.4},
            {-6.03,-23.9},{-1.21,-5.06},{5.23,21},{9.25,34.1},{13.3,44.2},{18.1,
            52.9},{24.5,60.8},{33.4,67.6},{47,73.6},{69.5,78.6},{80,80}}),Text(
              extent={{-32,91},{-12,71}},
              textString="1.4",
              lineColor={0,0,255}),Text(
              extent={{-32,-71},{-12,-91}},
              textString="-1.4",
              lineColor={0,0,255}),Text(
              extent={{73,26},{93,10}},
              textString=" 5.8",
              lineColor={0,0,255}),Text(
              extent={{-103,20},{-83,4}},
              textString="-5.8",
              lineColor={0,0,255}),Text(
              extent={{66,-8},{94,-28}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
<i>tangent-inverse</i> of the input <b>u</b>:
</p>
<pre>
    y= <b>atan</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan.png\"
     alt=\"atan.png\">
</p>

</html>"));
  end Atan;

  block Atan2 "Output atan(u1/u2) of the inputs u1 and u2"
    extends Interfaces.SI2SO;
  equation
    y = Modelica.Math.atan2(u1, u2);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
                -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},
                {62.1,33.5},{80,34.9}},
            smooth=Smooth.Bezier),
          Line(
            points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
                65.8},{-1.82,77.2},{0,80}},
            smooth=Smooth.Bezier),
          Line(
            points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
                {69.9,-45.8},{80,-45.1}},
            smooth=Smooth.Bezier),
          Text(
            extent={{-90,-46},{-18,-94}},
            lineColor={192,192,192},
            textString="atan2")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-90},{0,84}}, color={192,192,192}),Text(
              extent={{11,98},{42,78}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
            color={192,192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{0,-80},{8.93,-67.2},
            {17.1,-59.3},{27.3,-53.6},{42.1,-49.4},{69.9,-45.8},{80,-45.1}}),Line(points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},
            {-18.3,-21.5},{-10.3,-14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{
            24.3,25},{39,30},{62.1,33.5},{80,34.9}}),Line(points=
             {{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,65.8},{-1.82,
            77.2},{0,80}}),Text(
              extent={{-30,89},{-10,70}},
              textString="pi",
              lineColor={0,0,255}),Text(
              extent={{-30,-69},{-10,-88}},
              textString="-pi",
              lineColor={0,0,255}),Text(
              extent={{-30,49},{-10,30}},
              textString="pi/2",
              lineColor={0,0,255}),Line(points={{0,40},{-8,40}}, color={192,192,
            192}),Line(points={{0,-40},{-8,-40}}, color={192,192,192}),Text(
              extent={{-30,-31},{-10,-50}},
              textString="-pi/2",
              lineColor={0,0,255}),Text(
              extent={{48,0},{100,-34}},
              lineColor={160,160,164},
              textString="u1 / u2")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
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

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan2.png\"
     alt=\"atan2.png\">
</p>

</html>"));
  end Atan2;

  block Sinh "Output the hyperbolic sine of the input"
    extends Interfaces.SISO;

  equation
    y = Modelica.Math.sinh(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-86,80},{-14,32}},
            lineColor={192,192,192},
            textString="sinh"),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Line(
            points={{-80,-80},{-76,-65.4},{-71.2,-51.4},{-65.5,-38.8},{-59.1,-28.1},
                {-51.1,-18.7},{-41.4,-11.4},{-27.7,-5.5},{-4.42,-0.653},{24.5,
                4.57},{39,10.1},{49.4,17.2},{57.5,25.9},{63.9,35.8},{69.5,47.4},
                {74.4,60.4},{78.4,73.8},{80,80}},
            smooth=Smooth.Bezier),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-90},{0,84}}, color={192,192,192}),Text(
              extent={{9,98},{34,78}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
            color={192,192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-76,-65.4},
            {-71.2,-51.4},{-65.5,-38.8},{-59.1,-28.1},{-51.1,-18.7},{-41.4,-11.4},
            {-27.7,-5.5},{-4.42,-0.653},{24.5,4.57},{39,10.1},{49.4,17.2},{57.5,
            25.9},{63.9,35.8},{69.5,47.4},{74.4,60.4},{78.4,73.8},{80,80}}),Text(
              extent={{-31,72},{-11,88}},
              textString="27",
              lineColor={0,0,255}),Text(
              extent={{-35,-88},{-15,-72}},
              textString="-27",
              lineColor={0,0,255}),Text(
              extent={{70,25},{90,5}},
              textString="4",
              lineColor={0,0,255}),Text(
              extent={{-98,21},{-78,1}},
              textString="-4",
              lineColor={0,0,255}),Text(
              extent={{72,-6},{96,-26}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
<i>hyperbolic sine</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>sinh</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sinh.png\"
     alt=\"sinh.png\">
</p>

</html>"));
  end Sinh;

  block Cosh "Output the hyperbolic cosine of the input"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.cosh(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Text(
            extent={{4,66},{66,20}},
            lineColor={192,192,192},
            textString="cosh"),
          Line(
            points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,1.29},
                {-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{-39,-64.3},
                {-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},{23.7,-75.2},
                {34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{59.1,-27.5},
                {63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{77.6,61.1},{
                80,80}},
            smooth=Smooth.Bezier),
          Line(points={{-90,-86.083},{68,-86.083}}, color={192,192,192}),
          Polygon(
            points={{90,-86.083},{68,-78.083},{68,-94.083},{90,-86.083}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-90},{0,84}}, color={192,192,192}),Text(
              extent={{11,98},{38,78}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,-86.083},{84,-86.083}},
            color={192,192,192}),Polygon(
              points={{100,-86.083},{84,-80.083},{84,-92.083},{100,-86.083}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,80},{-77.6,61.1},
            {-74.4,39.3},{-71.2,20.7},{-67.1,1.29},{-63.1,-14.6},{-58.3,-29.8},
            {-52.7,-43.5},{-46.2,-55.1},{-39,-64.3},{-30.2,-71.7},{-18.9,-77.1},
            {-4.42,-79.9},{10.9,-79.1},{23.7,-75.2},{34.2,-68.7},{42.2,-60.6},{
            48.6,-51.2},{54.3,-40},{59.1,-27.5},{63.1,-14.6},{67.1,1.29},{71.2,
            20.7},{74.4,39.3},{77.6,61.1},{80,80}}),Text(
              extent={{-31,72},{-11,88}},
              textString="27",
              lineColor={0,0,255}),Text(
              extent={{62,-67},{82,-87}},
              textString="4",
              lineColor={0,0,255}),Text(
              extent={{-104,-63},{-84,-83}},
              textString="-4",
              lineColor={0,0,255}),Text(
              extent={{78,-54},{100,-74}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
<i>hyperbolic cosine</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>cosh</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cosh.png\"
     alt=\"cosh.png\">
</p>

</html>"));
  end Cosh;

  block Tanh "Output the hyperbolic tangent of the input"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.tanh(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{0,-90},{0,84}}, color={192,192,192}),
          Line(points={{-100,0},{84,0}}, color={192,192,192}),
          Line(
            points={{-80,-80},{-47.8,-78.7},{-35.8,-75.7},{-27.7,-70.6},{-22.1,
                -64.2},{-17.3,-55.9},{-12.5,-44.3},{-7.64,-29.2},{-1.21,-4.82},
                {6.83,26.3},{11.7,42},{16.5,54.2},{21.3,63.1},{26.9,69.9},{34.2,
                75},{45.4,78.4},{72,79.9},{80,80}},
            smooth=Smooth.Bezier),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-88,72},{-16,24}},
            lineColor={192,192,192},
            textString="tanh"),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-90},{0,84}}, color={192,192,192}),Text(
              extent={{9,98},{42,80}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
            color={192,192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-47.8,-78.7},
            {-35.8,-75.7},{-27.7,-70.6},{-22.1,-64.2},{-17.3,-55.9},{-12.5,-44.3},
            {-7.64,-29.2},{-1.21,-4.82},{6.83,26.3},{11.7,42},{16.5,54.2},{21.3,
            63.1},{26.9,69.9},{34.2,75},{45.4,78.4},{72,79.9},{80,80}}, color={
            0,0,0}),Text(
              extent={{70,25},{90,5}},
              textString="4",
              lineColor={0,0,255}),Text(
              extent={{-106,21},{-86,1}},
              textString="-4",
              lineColor={0,0,255}),Text(
              extent={{-29,72},{-9,88}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{3,-72},{23,-88}},
              textString="-1",
              lineColor={0,0,255}),Text(
              extent={{72,-8},{98,-26}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
<i>hyperbolic tangent</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>tanh</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\"
     alt=\"tanh.png\">
</p>

</html>"));
  end Tanh;

  block Exp "Output the exponential (base e) of the input"
    extends Interfaces.SISO;

  equation
    y = Modelica.Math.exp(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-86,50},{-14,2}},
            lineColor={192,192,192},
            textString="exp"),
          Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
                {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
                67.1,18.6},{72,38.2},{76,57.6},{80,80}}),
          Line(
            points={{-90,-80.3976},{68,-80.3976}},
            color={192,192,192},
            smooth=Smooth.Bezier),
          Polygon(
            points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
            192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
            points={{0,-90},{0,84}}, color={192,192,192}),Text(
              extent={{9,100},{40,80}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{0,100},{-6,84},{6,84},{0,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,-80.3976},{84,-80.3976}},
            color={192,192,192}),Polygon(
              points={{100,-80.3976},{84,-74.3976},{84,-86.3976},{100,-80.3976}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-31,-77.9},
            {-6.03,-74},{10.9,-68.4},{23.7,-61},{34.2,-51.6},{43,-40.3},{50.3,-27.8},
            {56.7,-13.5},{62.3,2.23},{67.1,18.6},{72,38.2},{76,57.6},{80,80}}),Text(
              extent={{-31,72},{-11,88}},
              textString="20",
              lineColor={0,0,255}),Text(
              extent={{-92,-83},{-72,-103}},
              textString="-3",
              lineColor={0,0,255}),Text(
              extent={{70,-83},{90,-103}},
              textString="3",
              lineColor={0,0,255}),Text(
              extent={{-18,-53},{2,-73}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{66,-52},{96,-72}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
<i>exponential</i> (of base e) of the input <b>u</b>:
</p>
<pre>
    y = <b>exp</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\"
     alt=\"exp.png\">
</p>

</html>"));
  end Exp;

  block Log
    "Output the natural (base e) logarithm of the input (input > 0 required)"

    extends Interfaces.SISO;
  equation
    y = Modelica.Math.log(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
                {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
                {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}},
            smooth=Smooth.Bezier),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-6,-24},{66,-72}},
            lineColor={192,192,192},
            textString="log")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={192,
            192,192}),Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
            Line(points={{-80,-90},{-80,84}}, color={192,192,192}),Text(
              extent={{-67,98},{-40,80}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
            color={192,192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,-50.6},
            {-78.4,-37},{-77.6,-28},{-76.8,-21.3},{-75.2,-11.4},{-72.8,-1.31},{
            -69.5,8.08},{-64.7,17.9},{-57.5,28},{-47,38.1},{-31.8,48.1},{-10.1,
            58},{22.1,68},{68.7,78.1},{80,80}}),Text(
              extent={{-105,72},{-85,88}},
              textString="3",
              lineColor={0,0,255}),Text(
              extent={{-109,-88},{-89,-72}},
              textString="-3",
              lineColor={0,0,255}),Text(
              extent={{70,-3},{90,-23}},
              textString="20",
              lineColor={0,0,255}),Text(
              extent={{-78,-1},{-58,-21}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{68,28},{94,8}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
<i>natural (base e) logarithm</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>log</b>( u );
</pre>
<p>
An error occurs if the elements of the input <b>u</b> are
zero or negative.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\"
     alt=\"log.png\">
</p>

</html>"));
  end Log;

  block Log10 "Output the base 10 logarithm of the input (input > 0 required)"

    extends Interfaces.SISO;
  equation
    y = Modelica.Math.log10(u);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Line(
            points={{-79.8,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
                {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
                {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}},
            smooth=Smooth.Bezier),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
          Text(
            extent={{-30,-22},{60,-70}},
            lineColor={192,192,192},
            textString="log10")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={192,
            192,192}),Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
            Line(points={{-80,-90},{-80,84}}, color={192,192,192}),Text(
              extent={{-65,96},{-38,78}},
              lineColor={160,160,164},
              textString="y"),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
            color={192,192,192}),Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-79.8,-80},{-79.2,-50.6},
            {-78.4,-37},{-77.6,-28},{-76.8,-21.3},{-75.2,-11.4},{-72.8,-1.31},{
            -69.5,8.08},{-64.7,17.9},{-57.5,28},{-47,38.1},{-31.8,48.1},{-10.1,
            58},{22.1,68},{68.7,78.1},{80,80}}),Text(
              extent={{70,-3},{90,-23}},
              textString="20",
              lineColor={0,0,255}),Text(
              extent={{-78,-1},{-58,-21}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{-109,72},{-89,88}},
              textString=" 1.3",
              lineColor={0,0,255}),Text(
              extent={{-109,-88},{-89,-72}},
              textString="-1.3",
              lineColor={0,0,255}),Text(
              extent={{62,30},{90,10}},
              lineColor={160,160,164},
              textString="u")}),
      Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
<i>base 10 logarithm</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>log10</b>( u );
</pre>
<p>
An error occurs if the elements of the input <b>u</b> are
zero or negative.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/log10.png\"
     alt=\"log10.png\">
</p>

</html>"));
  end Log10;

  block RealToInteger "Convert Real to Integer signal"
    extends Modelica.Blocks.Icons.IntegerBlock;
  public
    Interfaces.RealInput u "Connector of Real input signal" annotation (
        Placement(transformation(extent={{-140,-20},{-100,20}})));
    Interfaces.IntegerOutput y "Connector of Integer output signal" annotation (
       Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = if (u > 0) then integer(floor(u + 0.5)) else integer(ceil(u - 0.5));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
          Text(
            lineColor={0,0,127},
            extent={{-100.0,-40.0},{0.0,40.0}},
            textString="R"),
          Text(
            lineColor={255,127,0},
            extent={{20.0,-40.0},{120.0,40.0}},
            textString="I"),
          Polygon(
            lineColor={255,127,0},
            fillColor={255,127,0},
            fillPattern=FillPattern.Solid,
            points={{50.0,0.0},{30.0,20.0},{30.0,10.0},{0.0,10.0},{0.0,-10.0},{
                30.0,-10.0},{30.0,-20.0},{50.0,0.0}})}), Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>nearest integer value</i> of the input <b>u</b>:
</p>
<pre>    y = <b>integer</b>( <b>floor</b>( u + 0.5 ) )  for  u &gt; 0;
    y = <b>integer</b>( <b>ceil </b>( u - 0.5 ) )  for  u &lt; 0;
</pre>
</html>"));
  end RealToInteger;

  block IntegerToReal "Convert Integer to Real signals"
    extends Modelica.Blocks.Icons.Block;
    Interfaces.IntegerInput u "Connector of Integer input signal" annotation (
        Placement(transformation(extent={{-140,-20},{-100,20}})));
    Interfaces.RealOutput y "Connector of Real output signal" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = u;
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
          Text(
            lineColor={255,127,0},
            extent={{-120.0,-40.0},{-20.0,40.0}},
            textString="I"),
          Text(
            lineColor={0,0,127},
            fillPattern=FillPattern.Solid,
            extent={{0.0,-40.0},{100.0,40.0}},
            textString="R"),
          Polygon(
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{10.0,0.0},{-10.0,20.0},{-10.0,10.0},{-40.0,10.0},{-40.0,-10.0},
                {-10.0,-10.0},{-10.0,-20.0},{10.0,0.0}})}), Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>Real equivalent</i> of the Integer input <b>u</b>:
</p>
<pre>    y = u;
</pre>
<p>where <b>u</b> is of Integer and <b>y</b> of Real type.</p>
</html>"));
  end IntegerToReal;

  block BooleanToReal "Convert Boolean to Real signal"
    extends Interfaces.partialBooleanSI;
    parameter Real realTrue=1.0 "Output signal for true Boolean input";
    parameter Real realFalse=0.0 "Output signal for false Boolean input";

    Blocks.Interfaces.RealOutput y "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  equation
    y = if u then realTrue else realFalse;
    annotation (Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>Real equivalent</i> of the Boolean input <b>u</b>:
</p>
<pre>    y = <b>if</b> u <b>then</b> realTrue <b>else</b> realFalse;
</pre>
<p>where <b>u</b> is of Boolean and <b>y</b> of Real type,
and <b>realTrue</b> and <b>realFalse</b> are parameters.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Text(
            extent={{-86,92},{-6,10}},
            lineColor={255,0,255},
            textString="B"),
          Polygon(
            points={{-12,-46},{-32,-26},{-32,-36},{-64,-36},{-64,-56},{-32,-56},
                {-32,-66},{-12,-46}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Text(
            extent={{8,-4},{92,-94}},
            textString="R",
            lineColor={0,0,127})}));
  end BooleanToReal;

  block BooleanToInteger "Convert Boolean to Integer signal"
    extends Interfaces.partialBooleanSI;
    parameter Integer integerTrue=1 "Output signal for true Boolean input";
    parameter Integer integerFalse=0 "Output signal for false Boolean input";

    Blocks.Interfaces.IntegerOutput y "Connector of Integer output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  equation
    y = if u then integerTrue else integerFalse;
    annotation (Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>Integer equivalent</i> of the Boolean input <b>u</b>:
</p>
<pre>    y = <b>if</b> u <b>then</b> integerTrue <b>else</b> integerFalse;
</pre>
<p>where <b>u</b> is of Boolean and <b>y</b> of Integer type,
and <b>integerTrue</b> and <b>integerFalse</b> are parameters.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Text(
            extent={{-86,92},{-6,10}},
            lineColor={255,0,255},
            textString="B"),
          Polygon(
            points={{-12,-46},{-32,-26},{-32,-36},{-64,-36},{-64,-56},{-32,-56},
                {-32,-66},{-12,-46}},
            lineColor={255,170,85},
            fillColor={255,170,85},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{8,-4},{92,-94}},
            lineColor={255,170,85},
            textString="I")}));
  end BooleanToInteger;

  block RealToBoolean "Convert Real to Boolean signal"

    Blocks.Interfaces.RealInput u "Connector of Real input signal" annotation (
        Placement(transformation(extent={{-140,-20},{-100,20}})));
    extends Interfaces.partialBooleanSO;
    parameter Real threshold=0.5
      "Output signal y is true, if input u >= threshold";

  equation
    y = u >= threshold;
    annotation (Documentation(info="<html>
<p>
This block computes the Boolean output <b>y</b>
from the Real input <b>u</b> by the equation:
</p>

<pre>    y = u &ge; threshold;
</pre>

<p>
where <b>threshold</b> is a parameter.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Text(
            extent={{-86,92},{-6,10}},
            lineColor={0,0,127},
            textString="R"),
          Polygon(
            points={{-12,-46},{-32,-26},{-32,-36},{-64,-36},{-64,-56},{-32,-56},
                {-32,-66},{-12,-46}},
            lineColor={255,0,255},
            fillColor={255,0,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{8,-4},{92,-94}},
            lineColor={255,0,255},
            textString="B")}));
  end RealToBoolean;

  block IntegerToBoolean "Convert Integer to Boolean signal"

    Blocks.Interfaces.IntegerInput u "Connector of Integer input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    extends Interfaces.partialBooleanSO;
    parameter Integer threshold=1
      "Output signal y is true, if input u >= threshold";

  equation
    y = u >= threshold;
    annotation (Documentation(info="<html>
<p>
This block computes the Boolean output <b>y</b>
from the Integer input <b>u</b> by the equation:
</p>

<pre>    y = u &ge; threshold;
</pre>

<p>
where <b>threshold</b> is a parameter.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Text(
            extent={{-86,92},{-6,10}},
            lineColor={255,128,0},
            textString="I"),
          Polygon(
            points={{-12,-46},{-32,-26},{-32,-36},{-64,-36},{-64,-56},{-32,-56},
                {-32,-66},{-12,-46}},
            lineColor={255,0,255},
            fillColor={255,0,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{8,-4},{92,-94}},
            lineColor={255,0,255},
            textString="B")}));
  end IntegerToBoolean;

  block RectangularToPolar
    "Convert rectangular coordinates to polar coordinates"
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput u_re
      "Real part of rectangular representation" annotation (Placement(
          transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput u_im
      "Imaginary part of rectangular representation" annotation (Placement(
          transformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput y_abs
      "Length of polar representation" annotation (Placement(transformation(
            extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput y_arg "Angle of polar representation"
      annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

  equation
    y_abs = sqrt(u_re*u_re + u_im*u_im);
    y_arg = Modelica.Math.atan2(u_im, u_re);
    annotation (Icon(graphics={
          Text(
            extent={{-90,80},{-20,40}},
            lineColor={0,0,0},
            textString="re"),
          Text(
            extent={{-90,-40},{-20,-80}},
            lineColor={0,0,0},
            textString="im"),
          Text(
            extent={{20,80},{90,40}},
            lineColor={0,0,0},
            textString="abs"),
          Text(
            extent={{20,-40},{90,-80}},
            lineColor={0,0,0},
            textString="arg")}), Documentation(info="<html>
<p>
The input values of this block are the rectangular components
<code>u_re</code> and <code>u_im</code> of a phasor in two dimensions.
This block calculates the length <code>y_abs</code> and
the angle <code>y_arg</code> of the polar representation of this phasor.
</p>

<pre>
  y_abs = abs(u_re + j*u_im) = sqrt( u_re<sup>2</sup> + u_im<sup>2</sup> )
  y_arg = arg(u_re + j*u_im) = atan2(u_im, u_re)
</pre>
</html>"));
  end RectangularToPolar;

  block PolarToRectangular
    "Convert polar coordinates to rectangular coordinates"
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput u_abs "Length of polar representation"
      annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput u_arg "Angle of polar representation"
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput y_re
      "Real part of rectangular representation" annotation (Placement(
          transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput y_im
      "Imaginary part of rectangular representation" annotation (Placement(
          transformation(extent={{100,-70},{120,-50}})));

  equation
    y_re = u_abs*Modelica.Math.cos(u_arg);
    y_im = u_abs*Modelica.Math.sin(u_arg);
    annotation (Icon(graphics={
          Text(
            extent={{-90,80},{-20,40}},
            lineColor={0,0,0},
            textString="abs"),
          Text(
            extent={{-90,-40},{-20,-80}},
            lineColor={0,0,0},
            textString="arg"),
          Text(
            extent={{20,80},{90,40}},
            lineColor={0,0,0},
            textString="re"),
          Text(
            extent={{20,-40},{90,-80}},
            lineColor={0,0,0},
            textString="im")}), Documentation(info="<html>
<p>
The input values of this block are the polar components <code>uabs</code> and <code>uarg</code> of a phasor.
This block calculates the components <code>y_re</code> and <code>y_im</code> of the rectangular representation of this phasor.
</p>
<pre>
   y_re = u_abs * cos( u_arg )
   y_im = u_abs * sin( u_arg )
</pre>
</html>"));
  end PolarToRectangular;

  block Mean "Calculate mean over period 1/f"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Modelica.SIunits.Frequency f(start=50) "Base frequency";
    parameter Real x0=0 "Start value of integrator state";
    parameter Boolean yGreaterOrEqualZero=false
      "=true, if output y is guaranteed to be >= 0 for the exact solution"
      annotation (Evaluate=true, Dialog(tab="Advanced"));
  protected
    parameter Modelica.SIunits.Time t0(fixed=false) "Start time of simulation";
    Real x "Integrator state";
  initial equation
    t0 = time;
    x = x0;
    y = 0;
  equation
    der(x) = u;
    when sample(t0 + 1/f, 1/f) then
      y = if not yGreaterOrEqualZero then f*pre(x) else max(0.0, f*pre(x));
      reinit(x, 0);
    end when;
    annotation (Documentation(info="<html>
<p>
This block calculates the mean of the input signal u over the given period 1/f:
</p>
<pre>
1 T
- &int; u(t) dt
T 0
</pre>
<p>
Note: The output is updated after each period defined by 1/f.
</p>

<p>
If parameter <b>yGreaterOrEqualZero</b> in the Advanced tab is <b>true</b> (default = <b>false</b>),
then the modeller provides the information that the mean of the input signal is guaranteed
to be &ge; 0 for the exact solution. However, due to inaccuracies in the numerical integration scheme,
the output might be slightly negative. If this parameter is set to true, then the output is
explicitly set to 0.0, if the mean value results in a negative value.
</p>
</html>"), Icon(graphics={Text(
            extent={{-80,60},{80,20}},
            lineColor={0,0,0},
            textString="mean"), Text(
            extent={{-80,-20},{80,-60}},
            lineColor={0,0,0},
            textString="f=%f")}));
  end Mean;

  block RectifiedMean "Calculate rectified mean over period 1/f"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Modelica.SIunits.Frequency f(start=50) "Base frequency";
    parameter Real x0=0 "Start value of integrator state";
    Mean mean(final f=f, final x0=x0)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Blocks.Math.Abs abs1
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  equation
    connect(u, abs1.u) annotation (Line(
        points={{-120,0},{-62,0}},
        color={0,0,127}));
    connect(abs1.y, mean.u) annotation (Line(
        points={{-39,0},{-2,0}},
        color={0,0,127}));
    connect(mean.y, y) annotation (Line(
        points={{21,0},{110,0}},
        color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
This block calculates the rectified mean of the input signal u over the given period 1/f, using the
<a href=\"modelica://Modelica.Blocks.Math.Mean\">mean block</a>.
</p>
<p>
Note: The output is updated after each period defined by 1/f.
</p>
</html>"), Icon(graphics={Text(
            extent={{-80,60},{80,20}},
            lineColor={0,0,0},
            textString="RM"), Text(
            extent={{-80,-20},{80,-60}},
            lineColor={0,0,0},
            textString="f=%f")}));
  end RectifiedMean;

  block ContinuousMean
    "Calculates the empirical expectation (mean) value of its input signal"
    extends Modelica.Blocks.Icons.Block;
    parameter Modelica.SIunits.Time t_eps(min=0.0)=1e-7
      "Mean value calculation starts at startTime + t_eps"
      annotation(Dialog(group="Advanced"));

    Modelica.Blocks.Interfaces.RealInput u "Noisy input signal" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y
      "Expectation (mean) value of the input signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  protected
    Real mu "Internal integrator variable";
    parameter Real t_0(fixed=false) "Start time";
  initial equation
    t_0 = time;
    mu  = u;
  equation
    der(mu) = noEvent(if time >= t_0 + t_eps then (u-mu)/(time-t_0) else 0);
    y       = noEvent(if time >= t_0 + t_eps then mu                else u);

    annotation (Documentation(revisions="<html>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> June 22, 2015 </td>
    <td valign=\"top\">

<table border=0>
<tr><td valign=\"top\">
         <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</p>
</html>",                                   info="<html>
<p>This block continuously calculates the mean value of its input signal. It uses the function:</p>
<blockquote>
<pre>    integral( u over time)
y = ----------------------
      time - startTime</pre>
</blockquote>
<p>This can be used to determine the empirical expectation value of a random signal, such as generated by the <a href=\"Blocks.Noise\">Noise</a> blocks.</p>
<p>The parameter t_eps is used to guard against division by zero (the mean value computation
starts at startTime + t_eps and before that time instant y = u).</p>
<p>See also the <a href=\"Modelica.Blocks.Math.Mean\">Mean</a> block for a sampled implementation.</p>

<p>
This block is demonstrated in the examples
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.UniformNoiseProperties\">UniformNoiseProperties</a>,
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.NormalNoiseProperties\">NormalNoiseProperties</a> and
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.WeibullNoiseProperties\">WeibullNoiseProperties</a>.
</p>
</html>"),                                   Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Polygon(
            points={{94,0},{72,8},{72,-8},{94,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-86,0},{72,0}}, color={192,192,192}),
          Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
          Polygon(
            points={{-76,90},{-84,68},{-68,68},{-76,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
             points={{-76,-31},{-62,-31},{-62,-15},{-54,-15},{-54,-63},{-46,-63},
                {-46,-41},{-38,-41},{-38,43},{-30,43},{-30,11},{-30,11},{-30,-49},
                {-20,-49},{-20,-31},{-10,-31},{-10,-59},{0,-59},{0,23},{6,23},{6,
                37},{12,37},{12,-19},{22,-19},{22,-7},{28,-7},{28,-37},{38,-37},
                {38,35},{48,35},{48,1},{56,1},{56,-65},{66,-65}},
              color={215,215,215}),
          Line(
            points={{-76,-24},{70,-24}})}));
  end ContinuousMean;

  block RootMeanSquare "Calculate root mean square over period 1/f"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Modelica.SIunits.Frequency f(start=50) "Base frequency";
    parameter Real x0=0 "Start value of integrator state";
    MultiProduct product(nu=2)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Mean mean(
      final f=f,
      final yGreaterOrEqualZero=true,
      final x0=x0)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Blocks.Math.Sqrt sqrt1
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  equation

    connect(product.y, mean.u) annotation (Line(
        points={{-18.3,0},{-2,0}},
        color={0,0,127}));
    connect(mean.y, sqrt1.u) annotation (Line(
        points={{21,0},{38,0}},
        color={0,0,127}));
    connect(sqrt1.y, y) annotation (Line(
        points={{61,0},{110,0}},
        color={0,0,127}));
    connect(u, product.u[1]) annotation (Line(
        points={{-120,0},{-60,0},{-60,3.5},{-40,3.5}},
        color={0,0,127}));
    connect(u, product.u[2]) annotation (Line(
        points={{-120,0},{-60,0},{-60,-3.5},{-40,-3.5}},
        color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
This block calculates the root mean square of the input signal u over the given period 1/f, using the
<a href=\"modelica://Modelica.Blocks.Math.Mean\">mean block</a>.
</p>
<p>
Note: The output is updated after each period defined by 1/f.
</p>
</html>"), Icon(graphics={Text(
            extent={{-80,60},{80,20}},
            lineColor={0,0,0},
            textString="RMS"), Text(
            extent={{-80,-20},{80,-60}},
            lineColor={0,0,0},
            textString="f=%f")}));
  end RootMeanSquare;

  block Variance "Calculates the empirical variance of its input signal"
    extends Modelica.Blocks.Icons.Block;
    parameter Modelica.SIunits.Time t_eps(min=0.0)=1e-7
      "Variance calculation starts at startTime + t_eps"
      annotation(Dialog(group="Advanced"));

    Modelica.Blocks.Interfaces.RealInput u "Noisy input signal" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y "Variance of the input signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  protected
    Real mu "Mean value (state variable)";
    Real var "Variance (state variable)";
    parameter Real t_0(fixed=false) "Start time";
  initial equation
    t_0 = time;
    mu  = u;
    var = 0;
  equation
    der(mu)  = noEvent(if time >= t_0 + t_eps then (u-mu)/(time-t_0)             else 0);
    der(var) = noEvent(if time >= t_0 + t_eps then ((u-mu)^2 - var)/(time - t_0) else 0);
    y        = noEvent(if time >= t_0 + t_eps then max(var,0)                    else 0);

    annotation (Documentation(revisions="<html>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> June 22, 2015 </td>
    <td valign=\"top\">

<table border=0>
<tr><td valign=\"top\">
         <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</p>
</html>",                                   info="<html>
<p>
This block calculates the empirical variance of its input signal. It is based on the formula
(but implemented in a more reliable numerical way):
</p>
<blockquote>
<pre>y = mean(  (u - mean(u))^2  )</pre>
</blockquote>

<p>The parameter t_eps is used to guard against division by zero (the variance computation
starts at startTime + t_eps and before that time instant y = 0).</p>
<p>The variance of a signal is also equal to its mean power.</p>

<p>
This block is demonstrated in the examples
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.UniformNoiseProperties\">UniformNoiseProperties</a>,
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.NormalNoiseProperties\">NormalNoiseProperties</a> and
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.WeibullNoiseProperties\">WeibullNoiseProperties</a>.
</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
          Line(points={{-86,0},{72,0}}, color={192,192,192}),
          Line(
             points={{-76,-13},{-62,-13},{-62,3},{-54,3},{-54,-45},{-46,-45},{-46,
                -23},{-38,-23},{-38,61},{-30,61},{-30,29},{-30,29},{-30,-31},{-20,
                -31},{-20,-13},{-10,-13},{-10,-41},{0,-41},{0,41},{6,41},{6,55},
                {12,55},{12,-1},{22,-1},{22,11},{28,11},{28,-19},{38,-19},{38,53},
                {48,53},{48,19},{56,19},{56,-47},{66,-47}},
              color={215,215,215}),
          Polygon(
            points={{94,0},{72,8},{72,-8},{94,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-76,66},{70,66}},
            color={215,215,215}),
          Line(
            points={{-16,0},{-16,48}}),
          Polygon(
            points={{-76,90},{-84,68},{-68,68},{-76,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-16,66},{-24,44},{-8,44},{-16,66}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end Variance;

  block StandardDeviation
    "Calculates the empirical standard deviation of its input signal"
    extends Modelica.Blocks.Icons.Block;
    parameter Modelica.SIunits.Time t_eps(min=0.0)=1e-7
      "Standard deviation calculation starts at startTime + t_eps"
      annotation(Dialog(group="Advanced"));

    Modelica.Blocks.Interfaces.RealInput u "Noisy input signal" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y
      "Standard deviation of the input signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    Modelica.Blocks.Math.Variance variance(t_eps=t_eps)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Blocks.Math.Sqrt sqrt1
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    connect(variance.u, u) annotation (Line(
        points={{-62,0},{-120,0}},
        color={0,0,127}));
    connect(sqrt1.u, variance.y) annotation (Line(
        points={{-22,0},{-39,0}},
        color={0,0,127}));
    connect(sqrt1.y, y) annotation (Line(
        points={{1,0},{110,0}},
        color={0,0,127}));
    annotation (Documentation(revisions="<html>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> June 22, 2015 </td>
    <td valign=\"top\">

<table border=0>
<tr><td valign=\"top\">
         <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</p>
</html>",                                   info="<html>
<p>This block calculates the standard deviation of its input signal. The standard deviation is the square root of the signal&apos;s variance:</p>
<blockquote>
<pre>y = sqrt( variance(u) )</pre>
</blockquote>
<p>
The <a href=\"modelica://Modelica.Blocks.Statistics.Variance\">Variance</a> block is used to
calculate variance(u).
</p>
<p>The parameter t_eps is used to guard against division by zero (the computation of the standard deviation
starts at startTime + t_eps and before that time instant y = 0).
</p>

<p>
This block is demonstrated in the examples
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.UniformNoiseProperties\">UniformNoiseProperties</a>,
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.NormalNoiseProperties\">NormalNoiseProperties</a> and
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.WeibullNoiseProperties\">WeibullNoiseProperties</a>.
</p>
</html>"),
      Icon(graphics={
          Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
          Line(points={{-86,0},{72,0}}, color={192,192,192}),
          Line(
             points={{-76,-13},{-62,-13},{-62,3},{-54,3},{-54,-45},{-46,-45},{-46,
                -23},{-38,-23},{-38,61},{-30,61},{-30,29},{-30,29},{-30,-31},{-20,
                -31},{-20,-13},{-10,-13},{-10,-41},{0,-41},{0,41},{6,41},{6,55},
                {12,55},{12,-1},{22,-1},{22,11},{28,11},{28,-19},{38,-19},{38,53},
                {48,53},{48,19},{56,19},{56,-47},{66,-47}},
              color={215,215,215}),
          Polygon(
            points={{94,0},{72,8},{72,-8},{94,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-76,46},{70,46}},
            color={215,215,215}),
          Line(
            points={{-16,0},{-16,30}}),
          Polygon(
            points={{-76,90},{-84,68},{-68,68},{-76,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-16,46},{-24,24},{-8,24},{-16,46}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end StandardDeviation;

  block Harmonic "Calculate harmonic over period 1/f"
    extends Modelica.Blocks.Icons.Block;
    parameter Modelica.SIunits.Frequency f(start=50) "Base frequency";
    parameter Integer k(start=1) "Order of harmonic";
    parameter Real x0Cos=0 "Start value of cos integrator state";
    parameter Real x0Sin=0 "Start value of sin integrator state";
    Blocks.Sources.Sine sin1(
      final amplitude=sqrt(2),
      final phase=Modelica.Constants.pi/2,
      final freqHz=k*f) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,70})));
    Blocks.Sources.Sine sin2(
      final amplitude=sqrt(2),
      final phase=0,
      final freqHz=k*f) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-80,-70})));
    MultiProduct product1(nu=2)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    MultiProduct product2(nu=2)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    Mean mean1(final f=f, final x0=x0Cos)
      annotation (Placement(transformation(extent={{-20,30},{0,50}})));
    Mean mean2(final f=f, final x0=x0Sin)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
    Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.RealOutput y_rms
      "Root mean square of polar representation" annotation (Placement(
          transformation(extent={{100,50},{120,70}})));
    Blocks.Interfaces.RealOutput y_arg "Angle of polar representation"
      annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
    Blocks.Math.RectangularToPolar rectangularToPolar
      annotation (Placement(transformation(extent={{40,-12},{60,8}})));
  equation

    connect(product2.y, mean2.u) annotation (Line(
        points={{-38.3,-40},{-22,-40}},
        color={0,0,127}));
    connect(product1.y, mean1.u) annotation (Line(
        points={{-38.3,40},{-22,40}},
        color={0,0,127}));
    connect(mean1.y, rectangularToPolar.u_re) annotation (Line(
        points={{1,40},{20,40},{20,4},{38,4}},
        color={0,0,127}));
    connect(mean2.y, rectangularToPolar.u_im) annotation (Line(
        points={{1,-40},{20,-40},{20,-8},{38,-8}},
        color={0,0,127}));
    connect(rectangularToPolar.y_abs, y_rms) annotation (Line(
        points={{61,4},{80,4},{80,60},{110,60}},
        color={0,0,127}));
    connect(rectangularToPolar.y_arg, y_arg) annotation (Line(
        points={{61,-8},{80,-8},{80,-60},{110,-60}},
        color={0,0,127}));
    connect(sin1.y, product1.u[1]) annotation (Line(
        points={{-80,59},{-80,59},{-80,43.5},{-60,43.5}},
        color={0,0,127}));
    connect(u, product1.u[2]) annotation (Line(
        points={{-120,0},{-80,0},{-80,36.5},{-60,36.5}},
        color={0,0,127}));
    connect(u, product2.u[1]) annotation (Line(
        points={{-120,0},{-80,0},{-80,-36.5},{-60,-36.5}},
        color={0,0,127}));
    connect(sin2.y, product2.u[2]) annotation (Line(
        points={{-80,-59},{-80,-43.5},{-60,-43.5}},
        color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
This block calculates the root mean square and the phase angle of a single harmonic <i>k</i> of the input signal u over the given period 1/f, using the
<a href=\"modelica://Modelica.Blocks.Math.Mean\">mean block</a>.
</p>
<p>
Note: The output is updated after each period defined by 1/f.
</p>
<p>
Note: The harmonic is defined by <code>&radic;2 rms cos(k 2 &pi; f t - arg)</code>
</p>
</html>"), Icon(graphics={
          Text(
            extent={{-80,60},{80,20}},
            lineColor={0,0,0},
            textString="H%k"),
          Text(
            extent={{-80,-20},{80,-60}},
            lineColor={0,0,0},
            textString="f=%f"),
          Text(
            extent={{20,100},{100,60}},
            lineColor={0,0,0},
            textString="rms"),
          Text(
            extent={{20,-60},{100,-100}},
            lineColor={0,0,0},
            textString="arg")}));
  end Harmonic;

  block Max "Pass through the largest signal"
    extends Interfaces.SI2SO;
  equation
    y = max(u1, u2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,36},{90,-36}},
            lineColor={160,160,164},
            textString="max()")}), Documentation(info="<html>
<p>
This block computes the output <b>y</b> as <i>maximum</i>
of the two Real inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>    y = <b>max</b> ( u1 , u2 );
</pre>
</html>"));
  end Max;

  block Min "Pass through the smallest signal"
    extends Interfaces.SI2SO;
  equation
    y = min(u1, u2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,36},{90,-36}},
            lineColor={160,160,164},
            textString="min()")}), Documentation(info="<html>
<p>
This block computes the output <b>y</b> as <i>minimum</i> of
the two Real inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>    y = <b>min</b> ( u1 , u2 );
</pre>
</html>"));
  end Min;

  block MinMax "Output the minimum and the maximum element of the input vector"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer nu(min=0) = 0 "Number of input connections"
      annotation (Dialog(connectorSizing=true), HideResult=true);
    Modelica.Blocks.Interfaces.RealVectorInput u[nu]
      annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
    Modelica.Blocks.Interfaces.RealOutput yMax annotation (Placement(
          transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput yMin annotation (Placement(
          transformation(extent={{100,-70},{120,-50}})));
  equation
    yMax = max(u);
    yMin = min(u);
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={Text(
            extent={{-12,80},{100,40}},
            lineColor={0,0,0},
            textString="yMax"), Text(
            extent={{-10,-40},{100,-80}},
            lineColor={0,0,0},
            textString="yMin")}), Documentation(info="<html>
<p>
Determines the minimum and maximum element of the input vector and
provide both values as output.
</p>
</html>"));
  end MinMax;

  block LinearDependency "Output a linear combination of the two inputs"
    extends Modelica.Blocks.Interfaces.SI2SO;
    parameter Real y0=0 "Initial value";
    parameter Real k1=0 "u1 dependency";
    parameter Real k2=0 "u2 dependency";
  equation
    y = y0*(1 + k1*u1 + k2*u2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{-100,60},{100,0},{-100,-60}},
            color={0,0,127}),
          Text(
            extent={{-14,88},{94,32}},
            lineColor={0,0,0},
            textString="%k1"),
          Text(
            extent={{-40,-48},{96,-96}},
            lineColor={0,0,0},
            textString="%k2"),
          Text(
            extent={{-94,26},{8,-30}},
            lineColor={0,0,0},
            textString="%y0")}), Documentation(info="<html>
<p>Determine the linear combination of the two inputs: <code>y = y0*(1 + k1*u1 + k2*u2)</code> </p>
<p><b>Note</b>, for y0=0 the output is always zero. </p>
<p>To improve the implementation, the formula will be changed (non-backwards compatible) in the future: <code>y = y0 + k1*u1 + k2*u2</code> </p>
</html>"));
  end LinearDependency;

  block Edge "Indicates rising edge of Boolean signal"
    extends Interfaces.BooleanSISO;
  equation
    y = edge(u);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,36},{90,-36}},
            lineColor={160,160,164},
            textString="edge()")}), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b> to true,
when the Boolean input <b>u</b> shows a <i>rising edge</i>:
</p>
<pre>    y = <b>edge</b>( u );
</pre>
</html>"));
  end Edge;

  block BooleanChange "Indicates Boolean signal changing"
    extends Interfaces.BooleanSISO;
  equation
    y = change(u);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,36},{90,-36}},
            lineColor={160,160,164},
            textString="change()")}), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b> to true, when the
Boolean input <b>u</b> shows a <i>rising or falling edge</i>,
i.e., when the signal changes:
</p>
<pre>    y = <b>change</b>( u );
</pre>
</html>"));
  end BooleanChange;

  block IntegerChange "Indicates integer signal changing"
    extends Interfaces.IntegerSIBooleanSO;
  equation
    y = change(u);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,36},{90,-36}},
            lineColor={160,160,164},
            textString="change()")}), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b> to true, when the
Integer input <b>u</b> changes:
</p>
<pre>    y = <b>change</b>( u );
</pre>
</html>"));
  end IntegerChange;

  annotation (Documentation(info="<html>
<p>
This package contains basic <b>mathematical operations</b>,
such as summation and multiplication, and basic <b>mathematical
functions</b>, such as <b>sqrt</b> and <b>sin</b>, as
input/output blocks. All blocks of this library can be either
connected with continuous blocks or with sampled-data blocks.
</p>
</html>", revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.</li>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized (partly based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist).
</li>
</ul>
</html>"), Icon(graphics={Line(
          points={{-80,-2},{-68.7,32.2},{-61.5,51.1},{-55.1,64.4},{-49.4,72.6},
              {-43.8,77.1},{-38.2,77.8},{-32.6,74.6},{-26.9,67.7},{-21.3,57.4},
              {-14.9,42.1},{-6.83,19.2},{10.1,-32.8},{17.3,-52.2},{23.7,-66.2},
              {29.3,-75.1},{35,-80.4},{40.6,-82},{46.2,-79.6},{51.9,-73.5},{
              57.5,-63.9},{63.9,-49.2},{72,-26.8},{80,-2}},
          color={95,95,95},
          smooth=Smooth.Bezier)}));
end Math;
