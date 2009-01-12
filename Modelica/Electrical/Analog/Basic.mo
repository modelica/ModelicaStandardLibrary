within Modelica.Electrical.Analog;
package Basic
  "Basic electrical components such as resistor, capacitor, transformer"

  extends Modelica.Icons.Library;

  annotation (
Documentation(info="<HTML>
<p>
This package contains basic analog electrical components.
</p>
 
</HTML>
", revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
<a href=\"http://people.eas.iis.fhg.de/Christoph.Clauss/\">Christoph Clau&szlig;</a>
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://people.eas.iis.fhg.de/Andre.Schneider/\">Andr&eacute; Schneider</a>
    &lt;<a href=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
</dl>
</html>"));
  model Ground "Ground node"
    Interfaces.Pin p annotation (Placement(transformation(
          origin={0,100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
    annotation (
      Documentation(info="<HTML>
<P>
Ground of an electrical circuit. The potential at the
ground node is zero. Every electrical circuit has to contain
at least one ground object.
</P>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-60,50},{60,50}}, color={0,0,255}),
          Line(points={{-40,30},{40,30}}, color={0,0,255}),
          Line(points={{-20,10},{20,10}}, color={0,0,255}),
          Line(points={{0,90},{0,50}}, color={0,0,255}),
          Text(
            extent={{-144,-60},{138,0}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{-60,50},{60,50}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{-40,30},{40,30}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{-20,10},{20,10}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{0,96},{0,50}},
            thickness=0.5,
            color={0,0,255}),
          Text(
            extent={{-24,-38},{22,-6}},
            textString="p.v=0",
            lineColor={0,0,255})}));
  equation
    p.v = 0;
  end Ground;

  model Resistor "Ideal linear electrical resistor"
    extends Interfaces.OnePort;
    parameter SI.Resistance R(start=1) "Resistance";
    annotation (
      Documentation(info="<HTML>
<P>
The linear resistor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i*R = v</i>.
The Resistance <i>R</i> is allowed to be positive, zero, or negative.
</P>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-144,-60},{144,-100}},
            lineColor={0,0,0},
            textString="R=%R"),
          Text(
            extent={{-144,40},{144,100}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}),
          Line(points={{-96,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,255})}));
  equation
    R*i = v;
  end Resistor;

    model HeatingResistor "Temperature dependent electrical resistor"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;

      parameter SI.Resistance R_ref(start=1) "Resistance at temperature T_ref";
      parameter SI.Temperature T_ref(start=300) "Reference temperature";
      parameter SI.LinearTemperatureCoefficient alpha(start=0)
      "Temperature coefficient of resistance (R = R_ref*(1 + alpha*(heatPort.T - T_ref))";

      SI.Resistance R "Resistance = R_ref*(1 + alpha*(heatPort.T - T_ref));";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (Placement(
          transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(points={{-110,20},{-85,20}}, color={160,160,164}),
          Polygon(
            points={{-95,23},{-85,20},{-95,17},{-95,23}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{90,20},{115,20}}, color={160,160,164}),
          Line(points={{-125,0},{-115,0}}, color={160,160,164}),
          Line(points={{-120,-5},{-120,5}}, color={160,160,164}),
          Text(
            extent={{-110,25},{-90,45}},
            lineColor={160,160,164},
            textString="i"),
          Polygon(
            points={{105,23},{115,20},{105,17},{105,23}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{115,0},{125,0}}, color={160,160,164}),
          Text(
            extent={{90,45},{110,25}},
            lineColor={160,160,164},
            textString="i")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Text(
            extent={{-142,60},{143,118}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-30},{0,-91}}, color={191,0,0}),
          Line(points={{-52,-50},{48,50}}, color={0,0,255}),
          Polygon(
            points={{40,52},{50,42},{54,56},{40,52}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),
        Documentation(info="<HTML>
<p>This is a model for an electrical resistor where the generated heat
is dissipated to the environment via connector <b>heatPort</b> and where
the resistance R is temperature dependent according to the following
equation:</p>
<pre>    R = R_ref*(1 + alpha*(heatPort.T - T_ref))
</pre>
<p><b>alpha</b> is the <b>temperature coefficient of resistance</b>, which
is often abbreviated as <b>TCR</b>. In resistor catalogues, it is usually
defined as <b>X [ppm/K]</b> (parts per million, similarly to per centage)
meaning <b>X*1.e-6 [1/K]</b>. Resistors are available for 1 .. 7000 ppm/K,
i.e., alpha = 1e-6 .. 7e-3 1/K;</p>
 
<p>
Via parameter <b>useHeatPort</b> the heatPort connector can be enabled and disabled
(default = enabled). If it is disabled, the generated heat is transported implicitly
to an internal temperature source with a fixed temperature of T_ref.<br>
If the heatPort connector is enabled, it must be connected.
</p>
 
</HTML>
",     revisions=
             "<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 2002   </i>
       by Anton Haumer<br> initially implemented<br>
       </li>
</ul>
</html>"));
    equation
      assert(cardinality(heatPort) > 0, "Connector heatPort of HeatingResistor must be connected");
      R = R_ref*(1 + alpha*(heatPort.T - T_ref));
      v = R*i;
      heatPort.Q_flow = -v*i;
    end HeatingResistor;

  model Conductor "Ideal linear electrical conductor"
    extends Interfaces.OnePort;
    parameter SI.Conductance G(start=1) "Conductance";
    annotation (
      Documentation(info="<HTML>
<P>
The linear conductor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i = v*G</i>.
The Conductance <i>G</i> is allowed to be positive, zero, or negative.
</P>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}),
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-138,-60},{140,-100}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            textString="G=%G"),
          Text(
            extent={{-140,40},{142,100}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-96,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,255}),
          Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255})}));
  equation
    i = G*v;
  end Conductor;

  model Capacitor "Ideal linear electrical capacitor"
    extends Interfaces.OnePort;
    parameter SI.Capacitance C(start=1) "Capacitance";
    annotation (
      Documentation(info="<HTML>
<p>
The linear capacitor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i = C * dv/dt</i>.
The Capacitance <i>C</i> is allowed to be positive, zero, or negative.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{-14,28},{-14,-28}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{14,28},{14,-28}},
            thickness=0.5,
            color={0,0,255}),
          Line(points={{-90,0},{-14,0}}, color={0,0,255}),
          Line(points={{14,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-136,-60},{136,-100}},
            lineColor={0,0,0},
            textString="C=%C"),
          Text(
            extent={{-142,40},{140,100}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{-20,40},{-20,-40}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{20,40},{20,-40}},
            thickness=0.5,
            color={0,0,255}),
          Line(points={{-96,0},{-20,0}}, color={0,0,255}),
          Line(points={{20,0},{96,0}}, color={0,0,255})}));

  equation
    i = C*der(v);
  end Capacitor;

  model Inductor "Ideal linear electrical inductor"
    extends Interfaces.OnePort;
    parameter SI.Inductance L(start=1) "Inductance";
    annotation (
      Documentation(info="<HTML>
<P>
The linear inductor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by  <i>v = L * di/dt</i>.
The Inductance <i>L</i> is allowed to be positive, zero, or negative.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
          Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-60,-30},{60,0}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Line(points={{-90,0},{-60,0}}, color={0,0,255}),
          Text(
            extent={{-138,-60},{144,-102}},
            lineColor={0,0,0},
            textString="L=%L"),
          Text(
            extent={{-146,38},{148,100}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
          Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-60,-30},{60,0}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{60,0},{96,0}}, color={0,0,255}),
          Line(points={{-96,0},{-60,0}}, color={0,0,255})}));
  equation
    L*der(i) = v;
  end Inductor;

  model SaturatingInductor "Simple model of an inductor with saturation"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Modelica.SIunits.Current Inom(start=1) "Nominal current";
    parameter Modelica.SIunits.Inductance Lnom(start=1)
      "Nominal inductance at Nominal current";
    parameter Modelica.SIunits.Inductance Lzer(start=2*Lnom)
      "Inductance near current=0";
    parameter Modelica.SIunits.Inductance Linf(start=Lnom/2)
      "Inductance at large currents";
    Modelica.SIunits.Inductance Lact(start=Lzer);
    Modelica.SIunits.MagneticFlux Psi;
  protected
    parameter Modelica.SIunits.Current Ipar(start=Inom/10, fixed=false);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
          Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-60,-20},{62,0}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Line(points={{-90,0},{-60,0}}, color={0,0,255}),
          Rectangle(
            extent={{-60,-10},{60,-20}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,0,255}),
          Text(
            extent={{-142,40},{148,102}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-150,-48},{150,-92}},
            lineColor={0,0,0},
            textString="Lnom=%Lnom")}),                     Documentation(info="<HTML>
<p>
This model approximates the behaviour of an inductor with the influence of saturation,
i.e. the value of the inductance depends on the current flowing through the inductor.
The inductance decreases as current increases.<br>
The parameters are:
<ul>
<li>Inom...nominal current</li>
<li>Lnom...nominal inductance at nominal current</li>
<li>Lzer...inductance near current = 0; Lzer has to be greater than Lnom</li>
<li>Linf...inductance at large currents; Linf has to be less than Lnom</li>
</ul>
</p>
</HTML>
", revisions="<html>
<dl>
<p>
  <dt><b>Main Author:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> May 27, 2004: Implemented by Anton Haumer</li>
  </ul>
  </dd>
</dl>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
          Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-60,-20},{62,0}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{60,0},{96,0}}, color={0,0,255}),
          Line(points={{-96,0},{-60,0}}, color={0,0,255}),
          Rectangle(
            extent={{-60,-10},{60,-20}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,0,255})}));
  initial equation
    (Lnom - Linf) = (Lzer - Linf)*Ipar/Inom*(Modelica.Constants.pi/2-atan(Ipar/Inom));
  equation
    assert(Lzer > Lnom+Modelica.Constants.eps,
           "Lzer (= " + String(Lzer) + ") has to be > Lnom (= " + String(Lnom) + ")");
    assert(Linf < Lnom-Modelica.Constants.eps,
           "Linf (= " + String(Linf) + ") has to be < Lnom (= " + String(Lnom) + ")");
    (Lact - Linf)*i/Ipar = (Lzer - Linf)*noEvent(atan(i/Ipar));
    Psi = Lact*i;
    v = der(Psi);
  end SaturatingInductor;

  model Transformer "Transformer with two ports"
    extends Interfaces.TwoPort;
    parameter SI.Inductance L1(start=1) "Primary inductance";
    parameter SI.Inductance L2(start=1) "Secondary inductance";
    parameter SI.Inductance M(start=1) "Coupling inductance";
    annotation (
      Documentation(info="<HTML>
<p>The transformer is a two port. The left port voltage <i>v1</i>, left port current <i>i1</i>,
right port voltage <i>v2</i> and right port current <i>i2</i> are connected by the following
relation:</p>
<pre>         | v1 |         | L1   M  |  | i1' |
         |    |    =    |         |  |     |
         | v2 |         | M    L2 |  | i2' |</pre>
<p><i>L1</i>, <i>L2</i>, and <i>M</i> are the primary, secondary, and coupling inductances respectively.</p>
</html>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-100,128},{100,70}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(extent={{-45,-50},{-20,-25}}, lineColor={0,0,255}),
          Ellipse(extent={{-45,-25},{-20,0}}, lineColor={0,0,255}),
          Ellipse(extent={{-45,0},{-20,25}}, lineColor={0,0,255}),
          Ellipse(extent={{-45,25},{-20,50}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-72,-60},{-33,60}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,50},{-32,50}}, color={0,0,255}),
          Line(points={{-90,-50},{-32,-50}}, color={0,0,255}),
          Ellipse(extent={{20,-50},{45,-25}}, lineColor={0,0,255}),
          Ellipse(extent={{20,-25},{45,0}}, lineColor={0,0,255}),
          Ellipse(extent={{20,0},{45,25}}, lineColor={0,0,255}),
          Ellipse(extent={{20,25},{45,50}}, lineColor={0,0,255}),
          Rectangle(
            extent={{33,-60},{72,60}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{32,50},{90,50}}, color={0,0,255}),
          Line(points={{32,-50},{90,-50}}, color={0,0,255}),
          Text(
            extent={{-89,18},{-60,-10}},
            textString="L1",
            lineColor={0,0,255}),
          Text(
            extent={{64,18},{90,-10}},
            textString="L2",
            lineColor={0,0,255}),
          Text(
            extent={{-18,-70},{20,-98}},
            textString="M",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(extent={{-45,-50},{-20,-25}}, lineColor={0,0,255}),
          Ellipse(extent={{-45,-25},{-20,0}}, lineColor={0,0,255}),
          Ellipse(extent={{-45,0},{-20,25}}, lineColor={0,0,255}),
          Ellipse(extent={{-45,25},{-20,50}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-72,-60},{-33,60}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-96,50},{-32,50}}, color={0,0,255}),
          Line(points={{-96,-50},{-32,-50}}, color={0,0,255}),
          Ellipse(extent={{20,-50},{45,-25}}, lineColor={0,0,255}),
          Ellipse(extent={{20,-25},{45,0}}, lineColor={0,0,255}),
          Ellipse(extent={{20,0},{45,25}}, lineColor={0,0,255}),
          Ellipse(extent={{20,25},{45,50}}, lineColor={0,0,255}),
          Rectangle(
            extent={{33,-60},{72,60}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{32,50},{96,50}}, color={0,0,255}),
          Line(points={{32,-50},{96,-50}}, color={0,0,255})}));
  equation
    v1 = L1*der(i1) + M*der(i2);
    v2 = M*der(i1) + L2*der(i2);
  end Transformer;

model M_Transformer

  parameter Integer N(final min=1)=3 "number of inductors";
  protected
  parameter Integer dimL=div(N*(N+1),2);
  public
  parameter Real L[dimL]={1, 0.1, 0.2, 2, 0.3, 3}
      "inductances and coupling inductances";
  Modelica.Electrical.Analog.Interfaces.PositivePin p[N] "Positive pin" 
              annotation (extent=[-80,-40; -62,40], Placement(transformation(
          extent={{-80,-40},{-62,40}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[N] "Negative pin" 
              annotation (extent=[62,-40; 80,40], Placement(transformation(
          extent={{62,-40},{80,40}}, rotation=0)));

  Real v[N];
  Real i[N];
  Real Lm[N,N];
algorithm
  for s in 1:N loop
     for z in 1:N loop
       Lm[z,s]:= if (z>=s) then L[(s-1)*N+z-div((s-1)*s,2)] else 
                 Lm[s,z];
     end for;
  end for;

equation
  for j in 1:N loop
    v[j] = p[j].v - n[j].v;
    0 = p[j].i + n[j].i;
    i[j] = p[j].i;
  end for;

  v =Lm*der(i);

  annotation (Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
          Ellipse(extent={{-36,24},{-18,42}}),
          Text(
            extent={{-70,44},{68,86}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="%name"),
          Ellipse(extent={{18,24},{36,42}}),
          Ellipse(extent={{0,24},{18,42}}),
          Ellipse(extent={{-18,24},{0,42}}),
          Rectangle(
            extent={{42,24},{-44,34}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-36,34},{-62,34}},
            color={0,0,255},
            pattern=LinePattern.None),
          Line(
            points={{62,34},{36,34}},
            color={0,0,255},
            pattern=LinePattern.None),
          Ellipse(extent={{-36,8},{-18,26}}),
          Ellipse(extent={{18,8},{36,26}}),
          Ellipse(extent={{0,8},{18,26}}),
          Ellipse(extent={{-18,8},{0,26}}),
          Rectangle(
            extent={{42,6},{-44,18}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-36,18},{-62,18}},
            color={0,0,255},
            pattern=LinePattern.None),
          Line(
            points={{62,18},{36,18}},
            color={0,0,255},
            pattern=LinePattern.None),
          Line(
            points={{-36,-29},{-62,-29}},
            color={0,0,255},
            pattern=LinePattern.None),
          Ellipse(extent={{-36,-40},{-18,-22}}),
          Ellipse(extent={{-18,-40},{0,-22}}),
          Ellipse(extent={{0,-40},{18,-22}}),
          Ellipse(extent={{18,-40},{36,-22}}),
          Line(
            points={{62,-29},{36,-29}},
            color={0,0,255},
            pattern=LinePattern.None),
          Rectangle(
            extent={{42,-42},{-44,-30}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{0,8},{0,-18}},
            color={0,0,255},
            pattern=LinePattern.Dot)},
      Ellipse(extent=[-36,24; -18,42]),
      Text(
        extent=[-70,44; 68,86],
        style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1),
        string="%name"),
      Ellipse(extent=[18,24; 36,42]),
      Ellipse(extent=[0,24; 18,42]),
      Ellipse(extent=[-18,24; 0,42]),
      Rectangle(extent=[42,24; -44,34], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255})),
      Line(points=[-36,34; -62,34], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1)),
      Line(points=[62,34; 36,34], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1)),
      Ellipse(extent=[-36,8; -18,26]),
      Ellipse(extent=[18,8; 36,26]),
      Ellipse(extent=[0,8; 18,26]),
      Ellipse(extent=[-18,8; 0,26]),
      Rectangle(extent=[42,6; -44,18], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255})),
      Line(points=[-36,18; -62,18], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1)),
      Line(points=[62,18; 36,18], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1)),
      Line(points=[-36,-29; -62,-29], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1)),
      Ellipse(extent=[-36,-40; -18,-22]),
      Ellipse(extent=[-18,-40; 0,-22]),
      Ellipse(extent=[0,-40; 18,-22]),
      Ellipse(extent=[18,-40; 36,-22]),
      Line(points=[62,-29; 36,-29], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1)),
      Rectangle(extent=[42,-42; -44,-30], style(
          pattern=0,
          fillColor=7,
          rgbfillColor={255,255,255})),
      Line(points=[0,8; 0,-18], style(
          pattern=3,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1))), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                    graphics),
    uses(Modelica(version="3.0")),
    Documentation(info="<html>
The model <i> M_Transformer </i> is a model of a transformer with the posibility to choose the 
number of inductors. Inside the model, an inductance matrix is built based on the  
inductance of the inductors and the coupling inductances between the inductors given as a
parameter vector from the user of the model.<br>
<br>
An example shows that approach: <br>
<br>
The user chooses a model with <b>three</b> inductors, that means the parameter <b><i> N </i></b> has to be <b>3</b>. 
Then he has to specify the inductances of the three inductors and the three coupling inductances. The coupling 
inductances are no real existing devices, but effects that occur between two inductors.
 
The inductivities (main diagonal of the inductance matrix) and the coupling inductivities have 
to be specified in the parameter vector <i> L </i> .  The length <i> dimL </i> of the parameter vector is calculated as follows: <b><i> dimL=(N*(N+1))/2 </i></b> <br> The following example shows how the parameter vector is used to fill in the inductance matrix. 
For example: To specify the inductance matrix of a three inductances transformer (<i> N=3 </i>), e.g.<br><br> 
<center>
<table>
  <tr>
    <td></td>
    <td></td>
    <td>1</td>
    <td>0.1</td>
    <td>0.2</td> 
  </tr>
  <tr>
    <td>Lm</td>
    <td>=</td>
    <td>0.1</td>
    <td>2</td>
    <td>0.3</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>0.2</td>
    <td>0.3</td>
    <td>3</td>
  </tr>
</table>
</center>
 
the user has to allocate the parameter vector <i>L[6] </i>, since <i> Nv=(N*(N+1))/2=(3*(3+1))/2=6</i>. The parameter vector must be filled like this: <i> L=[1,0.1,0.2,2,0.3,3] </i>. <br>
<br>
Inside the model, two loops are used to fill the inductance matrix to guarantee that it is filled in a symmetric way.
</html>",
        revisions="
<html>
<ul>
<li><i>  </i>
       </li>
<li><i> November 24, 2008   </i> docu added, K. Majetta
       </li>
<li><i> September 16, 2008   </i>
       by Kristin Majetta<br> initially implemented<br>
       </li>
</ul>
</html>
"), version="1",
    conversion(noneFromVersion=""));

end M_Transformer;

  model Gyrator "Gyrator"
    extends Interfaces.TwoPort;
    parameter SI.Conductance G1(start=1) "Gyration conductance";
    parameter SI.Conductance G2(start=1) "Gyration conductance";
    annotation (
      Documentation(info="<HTML>
<P>
A gyrator is a two-port element defined by the following equations:
</P>
<PRE>
    i1 =  G2 * v2
    i2 = -G1 * v1
</PRE>
<P>
where the constants <i>G1</i>, <i>G2</i> are called the gyration conductance.
</P>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-90,50},{-60,50}}, color={0,0,255}),
          Line(points={{-90,-50},{-60,-50}}, color={0,0,255}),
          Line(points={{60,50},{90,50}}, color={0,0,255}),
          Line(points={{60,-50},{90,-50}}, color={0,0,255}),
          Line(points={{-40,30},{40,30}}, color={0,0,255}),
          Line(points={{-20,-20},{20,-20}}, color={0,0,255}),
          Polygon(
            points={{30,34},{40,30},{30,26},{30,34}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{-26,-19},{-16,-15},{-16,-23},{-26,-19}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(
            points={{-5,10},{-10,-10}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{9,10},{4,-9}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{-14,9},{16,10}},
            thickness=0.5,
            color={0,0,255}),
          Text(
            extent={{-100,130},{100,69}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-29,59},{30,30}},
            textString="G1",
            lineColor={0,0,255}),
          Text(
            extent={{-29,-29},{29,-58}},
            textString="G2",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{-96,50},{-60,50}}, color={0,0,255}),
          Line(points={{-96,-50},{-60,-50}}, color={0,0,255}),
          Line(points={{60,50},{96,50}}, color={0,0,255}),
          Line(points={{60,-50},{96,-50}}, color={0,0,255}),
          Line(points={{-40,30},{40,30}}, color={0,0,255}),
          Line(points={{-21,-22},{19,-22}}, color={0,0,255}),
          Polygon(
            points={{30,34},{40,30},{30,26},{30,34}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{-20,-30},{-10,-26},{-10,-34},{-20,-30}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(
            points={{-4,5},{-6,-5}},
            thickness=1,
            color={0,0,255}),
          Line(
            points={{3,5},{1,-5}},
            thickness=1,
            color={0,0,255}),
          Line(
            points={{-8,5},{7,5}},
            thickness=1,
            color={0,0,255}),
          Text(
            extent={{-20,50},{20,35}},
            textString="G1",
            lineColor={0,0,255}),
          Text(
            extent={{-20,-35},{20,-50}},
            textString="G2",
            lineColor={0,0,255})}));
  equation
    i1 = G2*v2;
    i2 = -G1*v1;
  end Gyrator;

  model EMF "Electromotoric force (electric/mechanic transformer)"
    parameter Boolean useSupport=false
      "= true, if support flange enabled, otherwise implicitly grounded" 
        annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter SI.ElectricalTorqueConstant k(start=1)
      "Transformation coefficient";
    SI.Voltage v "Voltage drop between the two pins";
    SI.Current i "Current flowing from positive to negative pin";
    SI.Angle phi
      "Angle of shaft flange with respect to support (= flange.phi - support.phi)";
    SI.AngularVelocity w "Angular velocity of flange relatuve to support";
    Interfaces.PositivePin p annotation (Placement(transformation(
          origin={0,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Interfaces.NegativePin n annotation (Placement(transformation(
          origin={0,-100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange 
      annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
    Mechanics.Rotational.Interfaces.Support support if useSupport
      "Support/housing of emf shaft" 
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    annotation (
      defaultComponentName="emf",
      Icon(
          coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-85,10},{-36,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Line(points={{0,90},{0,40}}, color={0,0,255}),
          Rectangle(
            extent={{35,10},{100,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Ellipse(
            extent={{-40,40},{40,-40}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{0,-90},{0,-40}}, color={0,0,255}),
          Text(
            extent={{20,-40},{100,-100}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{0,80},{148,44}},
            lineColor={160,160,164},
            textString="k=%k"),
          Line(
            visible=not useSupport,
            points={{-100,-30},{-40,-30}},
            color={0,0,0}),
          Line(
            visible=not useSupport,
            points={{-100,-50},{-80,-30}},
            color={0,0,0}),
          Line(
            visible=not useSupport,
            points={{-80,-50},{-60,-30}},
            color={0,0,0}),
          Line(
            visible=not useSupport,
            points={{-60,-50},{-40,-30}},
            color={0,0,0}),
          Line(
            visible=not useSupport,
            points={{-70,-30},{-70,-10}},
            color={0,0,0})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{-17,95},{-20,85},{-23,95},{-17,95}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{-20,110},{-20,85}}, color={160,160,164}),
          Text(
            extent={{-40,110},{-30,90}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid,
            textString="i"),
          Line(points={{9,75},{19,75}}, color={192,192,192}),
          Line(points={{-20,-110},{-20,-85}}, color={160,160,164}),
          Polygon(
            points={{-17,-100},{-20,-110},{-23,-100},{-17,-100}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-40,-110},{-30,-90}},
            lineColor={160,160,164},
            textString="i"),
          Line(points={{8,-79},{18,-79}}, color={192,192,192}),
          Line(points={{14,80},{14,70}}, color={192,192,192})}),
      Documentation(info="<HTML>
<p>
EMF transforms electrical energy into rotational mechanical energy.
It is used as basic building block of an electrical motor. The mechanical
connector shaft can be connected to elements of the
Modelica.Mechanics.Rotational library. shaft.tau is the cut-torque,
flange.phi is the angle at the rotational connection.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>"));
  protected
    Mechanics.Rotational.Components.Fixed fixed if not useSupport 
      annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
    Mechanics.Rotational.Interfaces.InternalSupport internalSupport(tau=-flange.tau) 
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  equation
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;

    phi = flange.phi - internalSupport.phi;
    w = der(phi);
    k*w = v;
    flange.tau = -k*i;
    connect(internalSupport.flange, support) annotation (Line(
        points={{-80,0},{-100,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(internalSupport.flange,fixed. flange) annotation (Line(
        points={{-80,0},{-80,-10}},
        color={0,0,0},
        smooth=Smooth.None));
  end EMF;

  model VCV "Linear voltage-controlled voltage source"
    extends Interfaces.TwoPort;
    parameter Real gain(start=1) "Voltage gain";
    annotation (
      Documentation(info="<HTML>
<p>
The linear voltage-controlled voltage source is a TwoPort.
The right port voltage v2 is controlled by the left port voltage v1
via
</p>
<pre>
    v2 = v1 * gain.
</pre>
<p>
The left port current is zero. Any voltage gain can be chosen.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-70,70},{70,-70}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-99,-79},{100,-129}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-90,50},{-30,50}}, color={0,0,255}),
          Line(points={{-30,-50},{-90,-50}}, color={0,0,255}),
          Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}),
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-96,50},{-31,50}}, color={0,0,255}),
          Line(points={{-30,-50},{-96,-50}}, color={0,0,255}),
          Line(points={{96,50},{30,50},{30,-50},{96,-50}}, color={0,0,255}),
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Rectangle(extent={{-70,70},{70,-70}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
  equation
    v2 = v1*gain;
    i1 = 0;
  end VCV;

  model VCC "Linear voltage-controlled current source"
    extends Interfaces.TwoPort;
    parameter SI.Conductance transConductance(start=1) "Transconductance";
    annotation (
      Documentation(info="<HTML>
<p>
The linear voltage-controlled current source is a TwoPort.
The right port current i2 is controlled by the left port voltage v1
via
</p>
<pre>
    i2 = v1 * transConductance.
</pre>
<p>
The left port current is zero. Any transConductance can be chosen.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-70,70},{70,-70}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-99,-80},{100,-129}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-90,50},{-30,50}}, color={0,0,255}),
          Line(points={{-30,-50},{-90,-50}}, color={0,0,255}),
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{90,50},{30,50},{30,20}}, color={0,0,255}),
          Line(points={{91,-50},{30,-50},{30,-20}}, color={0,0,255}),
          Line(points={{10,0},{50,0}}, color={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-96,50},{-30,50}}, color={0,0,255}),
          Line(points={{-30,-50},{-96,-50}}, color={0,0,255}),
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Rectangle(extent={{-70,70},{70,-70}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{96,50},{30,50},{30,20}}, color={0,0,255}),
          Line(points={{96,-50},{30,-50},{30,-20}}, color={0,0,255}),
          Line(points={{10,0},{50,0}}, color={0,0,255})}));
  equation
    i2 = v1*transConductance;
    i1 = 0;
  end VCC;

  model CCV "Linear current-controlled voltage source"
    extends Interfaces.TwoPort;

    parameter SI.Resistance transResistance(start=1) "Transresistance";
    annotation (
      Documentation(info="<HTML>
<p>
The linear current-controlled voltage source is a TwoPort.
The right port voltage v2 is controlled by the left port current i1
via
</p>
<pre>
    v2 = i1 * transResistance.
</pre>
<p>
The left port voltage is zero. Any transResistance can be chosen.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-70,70},{70,-70}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-99,-80},{100,-130}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}),
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-90,50},{-20,50},{-20,-50},{-90,-50}}, color={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Rectangle(extent={{-70,70},{70,-70}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{96,50},{30,50},{30,-50},{96,-50}}, color={0,0,255}),
          Line(points={{-96,50},{-30,50},{-30,-50},{-96,-50}}, color={0,0,255})}));
  equation
    v2 = i1*transResistance;
    v1 = 0;
  end CCV;

  model CCC "Linear current-controlled current source"
    extends Interfaces.TwoPort;
    parameter Real gain(start=1) "Current gain";
    annotation (
      Documentation(info="<HTML>
<p>
The linear current-controlled current source is a TwoPort.
The right port current i2 is controlled by the left port current i1
via
</p>
<pre>
    i2 = i1 * gain.
</pre>
<p>
The left port voltage is zero. Any current gain can be chosen.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-70,70},{70,-70}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-104,-76},{97,-127}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-100,50},{-30,50},{-30,-50},{-100,-50}}, color={0,0,255}),
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{90,50},{30,50},{30,20}}, color={0,0,255}),
          Line(points={{91,-50},{30,-50},{30,-20}}, color={0,0,255}),
          Line(points={{10,0},{50,0}}, color={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Rectangle(extent={{-70,70},{70,-70}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{96,50},{30,50},{30,20}}, color={0,0,255}),
          Line(points={{96,-50},{30,-50},{30,-20}}, color={0,0,255}),
          Line(points={{10,0},{50,0}}, color={0,0,255}),
          Line(points={{-96,50},{-30,50},{-30,-50},{-96,-50}}, color={0,0,255})}));

  equation
    i2 = i1*gain;
    v1 = 0;
  end CCC;

  model OpAmp "Simple nonideal model of an OpAmp with limitation"
    parameter Real Slope(start=1)
      "Slope of the out.v/vin characteristic at vin=0";
    Modelica.Electrical.Analog.Interfaces.PositivePin in_p
      "Positive pin of the input port" annotation (Placement(transformation(
            extent={{-110,-60},{-90,-40}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin in_n
      "Negative pin of the input port" annotation (Placement(transformation(
            extent={{-90,40},{-110,60}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin out "Output pin" 
      annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=
             0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin VMax
      "Positive output voltage limitation" annotation (Placement(transformation(
            extent={{-10,60},{10,80}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin VMin
      "Negative output voltage limitation" annotation (Placement(transformation(
            extent={{-10,-80},{10,-60}}, rotation=0)));
    SI.Voltage vin "input voltagae";
  protected
    Real f "auxiliary variable";
    Real absSlope;
    annotation (
      Documentation(info="<HTML>
<P>
The OpAmp is a simle nonideal model with a smooth out.v = f(vin) characteristic,
where \"vin = in_p.v - in_n.v\".
The characteristic is limited by VMax.v and VMin.v. Its slope at vin=0
is the parameter Slope, which must be positive. (Therefore, the absolute 
value of Slope is taken into calculation.)
</P>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 2000   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-95,88},{115,146}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{60,0},{-60,70},{-60,-70},{60,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-45,-10},{-20,-10},{-14,-9},{-11,-7},{-9,7},{-6,9},{0,
                10},{20,10}}, color={0,0,255}),
          Line(points={{0,35},{0,80}}, color={0,0,255}),
          Line(points={{0,-35},{0,-80}}, color={0,0,255}),
          Line(points={{-90,50},{-60,50}}, color={0,0,255}),
          Line(points={{-90,-50},{-60,-50}}, color={0,0,255}),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Line(points={{-48,32},{-28,32}}, color={0,0,255}),
          Line(points={{-39,-20},{-39,-41}}, color={0,0,255}),
          Line(points={{-50,-31},{-28,-31}}, color={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{60,0},{-60,70},{-60,-70},{60,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-45,-10},{-20,-10},{-14,-9},{-11,-7},{-9,7},{-6,9},{0,
                10},{20,10}}, color={0,0,255}),
          Line(points={{0,35},{0,70}}, color={0,0,255}),
          Line(points={{0,-35},{0,-70}}, color={0,0,255}),
          Line(points={{-96,50},{-60,50}}, color={0,0,255}),
          Line(points={{-96,-50},{-60,-50}}, color={0,0,255}),
          Line(points={{60,0},{96,0}}, color={0,0,255}),
          Line(points={{-55,50},{-45,50}}, color={0,0,255}),
          Line(points={{-50,-45},{-50,-55}}, color={0,0,255}),
          Line(points={{-55,-50},{-45,-50}}, color={0,0,255}),
          Text(
            extent={{-112,-93},{-91,-73}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid,
            textString="in_p.i=0"),
          Polygon(
            points={{120,3},{110,0},{120,-3},{120,3}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={160,160,164}),
          Line(points={{111,0},{136,0}}, color={0,0,0}),
          Text(
            extent={{118,2},{135,17}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={160,160,164},
            textString="i2"),
          Text(
            extent={{-111,60},{-85,80}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid,
            textString="in_n.i=0"),
          Line(
            points={{-100,-35},{-100,23},{-100,24}},
            color={160,160,164},
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{-97,-16},{-74,4}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid,
            textString="vin")}));
  equation
    in_p.i = 0;
    in_n.i = 0;
    VMax.i = 0;
    VMin.i = 0;
    vin = in_p.v - in_n.v;
    f = 2/(VMax.v - VMin.v);
    absSlope = smooth(0,(if (Slope < 0) then -Slope else Slope));
    out.v = (VMax.v + VMin.v)/2 + absSlope*vin/(1 + absSlope*smooth(0,(if (f*vin
       < 0) then -f*vin else f*vin)));
  end OpAmp;

        model VariableResistor
    "Ideal linear electrical resistor with variable resistance"
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          Modelica.Blocks.Interfaces.RealInput R 
            annotation (Placement(transformation(
          origin={0,110},
          extent={{-20,-20},{20,20}},
          rotation=270)));
          annotation (
            Documentation(info="<HTML>
<P>
The linear resistor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <br><br>
      <b> <i>i*R = v</i></b>
</P>
<P>
The Resistance <i>R</i> is given as input signal.
<P>
<b>Attention!!!</b><br>
  It is recommended that the R signal should not cross the zero value. Otherwise 
  depending on the surrounding circuit the probability of singularities is high. <br>
</P>
</HTML>
",         revisions=
             "<html>
<ul>
<li><i>June 7, 2004   </i>
       by Christoph Clauss<br>changed, docu added<br>
       </li>
<li><i>April 30, 2004</i>
       by Anton Haumer<br>implemented.
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-148,-100},{144,-40}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Line(points={{0,90},{0,30}}, color={0,0,255})}),
            Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-96,0},{-70,0}}, color={0,0,255}),
          Line(points={{0,90},{0,30}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,255})}));
        equation
          v = R*i;
        end VariableResistor;

        model VariableConductor
    "Ideal linear electrical conductor with variable conductance"
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          Modelica.Blocks.Interfaces.RealInput G 
            annotation (Placement(transformation(
          origin={0,110},
          extent={{-20,-20},{20,20}},
          rotation=270)));
          annotation (
            Documentation(info="<HTML>
<P>
The linear conductor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <br><br>
      <b> <i>i = G*v</i></b>
</P>
<P>
The Conductance <i>G</i> is given as input signal.
</P>
<P>
<b>Attention!!!</b><br>
  It is recommended that the G signal should not cross the zero value. Otherwise 
  depending on the surrounding circuit the probability of singularities is high. <br>
</P>
</HTML>
",         revisions=
             "<html>
<ul>
<li><i>June 7, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-144,-102},{142,-40}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Line(points={{0,90},{0,30}}, color={0,0,255})}),
            Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{0,90},{0,30}}, color={0,0,255}),
          Line(points={{-96,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,255}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
        equation
          i = G*v;
        end VariableConductor;

        model VariableCapacitor
    "Ideal linear electrical capacitor with variable capacitance"
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          Modelica.Blocks.Interfaces.RealInput C 
            annotation (Placement(transformation(
          origin={0,110},
          extent={{-20,-20},{20,20}},
          rotation=270)));
          parameter Modelica.SIunits.Capacitance Cmin=Modelica.Constants.eps
      "lower bound for variable capacitance";
          Modelica.SIunits.ElectricCharge Q;
          annotation (
            Documentation(info="<HTML>
<P>
The linear capacitor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <br><br>
      <b> <i>i = dQ/dt</i></b>  with <b><i>Q = C * v</i> </b>.
</P>
<P>
The capacitance <i>C</i> is given as input signal.
</P>
<P>
It is required that C &ge; 0, otherwise an 
assertion is raised. To avoid a variable index system,<br>
C = Cmin, if 0 &le; C &lt; Cmin, where
Cmin is a parameter with default value Modelica.Constants.eps.
</P>
</HTML>
",         revisions=
             "<html>
<ul>
<li><i>June 7, 2004   </i>
       by Christoph Clauss<br>changed, docu added<br>
       </li>
<li><i>April 30, 2004</i>
       by Anton Haumer<br>implemented.
       </li>
</ul>
</html>"),  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Text(
            extent={{-134,-100},{136,-40}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-90,0},{-14,0}}, color={0,0,255}),
          Line(points={{14,0},{90,0}}, color={0,0,255}),
          Line(points={{0,90},{0,30}}, color={0,0,255}),
          Line(
            points={{-14,28},{-14,-28}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{14,28},{14,-28}},
            thickness=0.5,
            color={0,0,255})}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Line(points={{-96,0},{-14,0}}, color={0,0,255}),
          Line(points={{14,0},{96,0}}, color={0,0,255}),
          Line(points={{0,90},{0,30}}, color={0,0,255}),
          Line(
            points={{-14,28},{-14,-28}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{14,28},{14,-28}},
            thickness=0.5,
            color={0,0,255})}));
        equation
          assert(C>=0,"Capacitance C (= " +
                 String(C) + ") has to be >= 0!");
          // protect solver from index change
          Q = noEvent(max(C,Cmin))*v;
          i = der(Q);
        end VariableCapacitor;

        model VariableInductor
    "Ideal linear electrical inductor with variable inductance"

          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          Modelica.Blocks.Interfaces.RealInput L 
            annotation (Placement(transformation(
          origin={0,108},
          extent={{-20,-20},{20,20}},
          rotation=270)));
          Modelica.SIunits.MagneticFlux Psi;
          parameter Modelica.SIunits.Inductance Lmin=Modelica.Constants.eps
      "lower bound for variable inductance";
          annotation (
            Documentation(info="<HTML>
<P>
The linear inductor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <br><br>
      <b> <i>v = d Psi/dt </i></b>   with  <b><i>Psi = L * i </i></b>.
</P>
<P>
The inductance <i>L</i> is as input signal.
</P>
<P>
It is required that L &ge; 0, otherwise an 
assertion is raised. To avoid a variable index system,<br>
L = Lmin, if 0 &le; L &lt; Lmin, where
Lmin is a parameter with default value Modelica.Constants.eps.
</P>
</HTML>
",         revisions=
             "<html>
<ul>
<li><i>June 7, 2004   </i>
       by Christoph Clauss<br>changed, docu added<br>
       </li>
<li><i>April 30, 2004</i>
       by Anton Haumer<br>implemented.
       </li>
</ul>
</html>"),  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Text(
            extent={{-138,-100},{136,-40}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-90,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Line(points={{0,90},{0,8}}, color={0,0,255}),
          Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
          Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-60,-30},{60,0}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Line(points={{-96,0},{-60,0}}, color={0,0,255}),
          Line(points={{0,90},{0,8}}, color={0,0,255}),
          Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
          Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
          Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-60,-30},{62,0}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{60,0},{96,0}}, color={0,0,255})}));
        equation
          assert(L>=0,"Inductance L_ (= " +
                 String(L) + ") has to be >= 0!");
          // protect solver from index change
          Psi = noEvent(max(L,Lmin))*i;
          v = der(Psi);
        end VariableInductor;

end Basic;
