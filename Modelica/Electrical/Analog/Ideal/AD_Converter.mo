within Modelica.Electrical.Analog.Ideal;
model AD_Converter "Simple n-bit analog to digital converter"
  import L = Modelica.Electrical.Digital.Interfaces.Logic;
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    "Positive electrical pin (input)" annotation (Placement(transformation(
          extent={{-110,90},{-90,110}}),
                                       iconTransformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    "Negative electrical pin (input)" annotation (Placement(transformation(
          extent={{-110,-110},{-90,-90}}),
                                         iconTransformation(
          extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Digital.Interfaces.DigitalOutput y[N] "Digital output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
                                                                     iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Electrical.Digital.Interfaces.DigitalInput trig "Trigger input"
    annotation (Placement(transformation(extent={{-8,90},{12,110}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));
  parameter Integer N(final min=1, start=8)
    "Resolution in bits - output signal width";
  parameter SI.Voltage VRefHigh(start=10) "High reference voltage";
  parameter SI.Voltage VRefLow(final max=VRefHigh, start=0)
    "Low reference voltage";
  parameter SI.Resistance Rin(start=10^6) "Input resistance";
  Integer z(start=0, fixed=true);
  Real u;

initial algorithm
  for i in 1:N loop
    y[i] := L.'X';
  end for;

algorithm
  when (trig == L.'1' or trig == L.'H') then
    z := if u > VRefLow then integer((u - VRefLow)/(VRefHigh - VRefLow)*(2^N
       - 1) + 0.5) else 0;
    for i in 1:N loop
      y[i] := if mod(z, 2) > 0 then L.'1' else L.'0';
      z := div(z, 2);
    end for;
  end when;
equation
  p.v - n.v = u;
  p.i*Rin = u;
  p.i + n.i = 0;
  annotation (defaultComponentName="converter", Documentation(info="<html>
<p>
Simple analog to digital converter with a variable resolution of n bits.
It converts the input voltage <code>ppin.v-npin.v</code> to an n-vector of type Logic
(9-valued logic according to IEEE 1164 STD_ULOGIC). The input resistance between positive and negative pin is determined by <code>Rin</code>.
Further effects (like input capacities) have to be modeled outside the converter, since this should be a general model.</p>

<p>
The input signal range (VRefLo,VRefHi) is divided into 2^n-1 equally spaced stages of length Vlsb:=(VRefHi-VRefLo)/(2^n-1).
The output signal is the binary code of <code> k </code> as long as the input voltage takes values in the k-th stage, namely in the range from
<code>Vlsb*(k-0.5)</code> to <code>m*(k+0.5)</code>. This is called mid-tread operation. Additionally the output can only change
its value if the trigger signal <code>trig</code> of type Logic changes to '1' (forced or weak).
</p>

<p>
The output vector is a 'little-endian'. i.e., that the first bit y[1] is the least significant one (LSB).
</p>

<p>
This is an abstract model of an ADC. Therefore, it can not cover the dynamic behaviour of the converter.
Hence the output will change instantaneously when the trigger signal rises.
</p>

</html>",
        revisions="<html>
<ul>
<li><em> October 13, 2009   </em>
       by Matthias Franke
       </li>
</ul>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(extent={{-100,100},{100,-100}},
                                              lineColor={0,0,255}),
        Polygon(
          points={{-98,-100},{100,98},{100,-100},{-98,-100}},
          lineColor={0,0,255},
          fillColor={127,0,127},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,50},{60,10}},
          textColor={0,0,255},
          textString="%n-bit"),
        Text(
          extent={{-60,-10},{60,-50}},
          textColor={0,0,255},
          textString="ADC")}));
end AD_Converter;
