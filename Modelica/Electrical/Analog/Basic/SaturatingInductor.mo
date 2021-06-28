within Modelica.Electrical.Analog.Basic;
model SaturatingInductor "Simple model of an inductor with saturation"
  extends Modelica.Electrical.Analog.Interfaces.OnePort(i(start=0));
  import Modelica.Constants.pi;
  import Modelica.Constants.eps;
  import Modelica.Constants.small;
  import Modelica.Math.atan;
  parameter SI.Current Inom(start=1) "Nominal current" annotation(Dialog(
    groupImage="modelica://Modelica/Resources/Images/Electrical/Analog/Basic/SaturatingInductor_Lact_i_tight.png"));
  parameter SI.Inductance Lnom(start=1)
    "Nominal inductance at Nominal current";
  parameter SI.Inductance Lzer(start=2*Lnom)
    "Inductance near current=0";
  parameter SI.Inductance Linf(start=Lnom/2)
    "Inductance at large currents";
  SI.Inductance Lact(start=Lzer) "Present inductance";
  SI.MagneticFlux Psi "Present flux";
protected
  parameter SI.Current Ipar(start=Inom/10, fixed=false);
initial equation
  (Lnom - Linf)/(Lzer - Linf)=Ipar/Inom*(pi/2 - atan(Ipar/Inom));
equation
  assert(Lzer > Lnom*(1 + eps), "Lzer (= " + String(Lzer) +
    ") has to be > Lnom (= " + String(Lnom) + ")");
  assert(Linf < Lnom*(1 - eps), "Linf (= " + String(Linf) +
    ") has to be < Lnom (= " + String(Lnom) + ")");
  Lact = Linf + (Lzer - Linf)*(if noEvent(abs(i)/Ipar<small) then 1 else atan(i/Ipar)/(i/Ipar));
  Psi = Linf*i + (Lzer - Linf)*Ipar*atan(i/Ipar);
  v = der(Psi);
  annotation (defaultComponentName="inductor",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{60,0},{90,0}}, color={0,0,255}),
        Line(points={{-90,0},{-60,0}}, color={0,0,255}),
        Text(
          extent={{-150,-40},{150,-80}},
          textString="Lnom=%Lnom"),
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-60,-20},{60,-20}}, color={0,0,255})}),
    Documentation(info="<html>
<p>This model approximates the behaviour of an inductor with the influence of saturation, i.e.,
the value of the inductance depends on the current flowing through the inductor (<strong>Fig.&nbsp;1</strong>).
The inductance decreases as current increases. Note, that hysteresis is not taken into account.
</p>

<p>
The approximation of the flux linkage is based on the <code>atan</code> function with an additional linear term,
as shown in <strong>Fig.&nbsp;2</strong>:</p>

<blockquote><pre>
Psi = Linf*i + (Lzer - Linf)*Ipar*atan(i/Ipar)
L = Psi/i = Linf + (Lzer - Linf)*atan(i/Ipar)/(i/Ipar)
</pre></blockquote>

<p>
This approximation is with good performance and easy to adjust to a given characteristic with only four parameters (<strong>Tab.&nbsp;1</strong>).
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Tab.&nbsp;1:</strong> Characteristic parameters of the saturating inductor model</caption>
  <tr>
    <th>Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>Inom</code>.</td>
    <td>Nominal current</td>
  </tr>
  <tr>
    <td><code>Lnom</code></td>
    <td>Nominal inductance at nominal current</td>
  </tr>
  <tr>
    <td><code>Lzer</code></td>
    <td>Inductance near current = 0; <code>Lzer</code> has to be greater than <code>Lnom</code></td>
  </tr>
  <tr>
    <td><code>Linf</code></td>
    <td>Inductance at large currents; <code>Linf</code> has to be less than <code>Lnom</code></td>
  </tr>
</table>

<p>
The parameter <code>Ipar</code> is calculated internally from the relationship:</p>
<blockquote><pre>
Lnom = Linf + (Lzer - Linf)*atan(Inom/Ipar)/(Inom/Ipar)
</pre></blockquote>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig.&nbsp;1:</strong> Actual inductance <code>Lact</code> versus current <code>i</code></caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Basic/SaturatingInductor_Lact_i.png\" alt=\"Lact vs. i\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig.&nbsp;2:</strong> Actual flux linkage <code>Psi</code> versus current <code>i</code></caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Basic/SaturatingInductor_Psi_i.png\" alt=\"Psi vs. i\">
    </td>
  </tr>
</table>

<p>The flux slope in <strong>Fig.&nbsp;2</strong> is equal to <code>Lzer</code> for small currents.
The limit of the flux slope is <code>Linf</code> as the current <code>i</code> approaches infinity.
The nominal flux is indicated by the product of the nominal inductance <code>Lnom</code> and the nominal current <code>Inom</code>.
</p>
</html>",
        revisions="<html>
<dl>
  <dt><strong>Main Author:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>Jul 23, 2019: Improved by Anton Haumer</dd>
  <dd>May 27, 2004: Implemented by Anton Haumer</dd>
 </dl>
</html>"));
end SaturatingInductor;
