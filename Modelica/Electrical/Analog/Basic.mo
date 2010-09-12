within Modelica.Electrical.Analog;
package Basic "Basic electrical components"

  extends Modelica.Icons.Package;

  model Ground "Ground node"

    Interfaces.Pin p annotation (Placement(transformation(
          origin={0,100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
  equation
    p.v = 0;
    annotation (
      Documentation(info="<html>
<p>Ground of an electrical circuit. The potential at the ground node is zero. Every electrical circuit has to contain at least one ground object.</p>
</html>",
   revisions="<html>
<ul>
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
            extent={{-144,-19},{156,-59}},
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
  end Ground;

model Resistor "Ideal linear electrical resistor"
  parameter Modelica.SIunits.Resistance R(start=1)
      "Resistance at temperature T_ref";
  parameter Modelica.SIunits.Temperature T_ref=300.15 "Reference temperature";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
      "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(TheatPort - T_ref))";

  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(                    T = T_ref);
  Modelica.SIunits.Resistance R_actual
      "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";

equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
  R_actual = R*(1 + alpha*(T_heatPort - T_ref));
  v = R_actual*i;
  LossPower = v*i;
  annotation (
    Documentation(info="<html>
<p>The linear resistor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>i*R = v</i>. The Resistance <i>R</i> is allowed to be positive, zero, or negative.</p>
</html>",
 revisions="<html>
<ul>
<li><i> August 07, 2009   </i>
       by Anton Haumer<br> temperature dependency of resistance added<br>
       </li>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
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
            extent={{-144,-40},{142,-72}},
            lineColor={0,0,0},
            textString="R=%R"),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-30}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot),
          Text(
            extent={{-152,87},{148,47}},
            textString="%name",
            lineColor={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}),
          Line(points={{-96,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,255})}));
end Resistor;

  model HeatingResistor "Temperature dependent electrical resistor"
    parameter Modelica.SIunits.Resistance R_ref(start=1)
      "Resistance at temperature T_ref";
    parameter Modelica.SIunits.Temperature T_ref=300.15 "Reference temperature";
    parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
      "Temperature coefficient of resistance (R = R_ref*(1 + alpha*(heatPort.T - T_ref))";
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(                    T = T_ref, useHeatPort=true);
    Modelica.SIunits.Resistance R
      "Resistance = R_ref*(1 + alpha*(T_heatPort - T_ref))";
  equation
    assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
    R = R_ref*(1 + alpha*(T_heatPort - T_ref));
    v = R*i;
    LossPower = v*i;
    annotation (__Dymola_structurallyIncomplete=true,
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
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
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-52,-50},{48,50}}, color={0,0,255}),
          Polygon(
            points={{40,52},{50,42},{54,56},{40,52}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-30}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot),
          Text(
            extent={{-156,109},{144,69}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<html>
<p>This is a model for an electrical resistor where the generated heat is dissipated to the environment via connector <b>heatPort</b> and where the resistance R is temperature dependent according to the following equation:</p>
<pre>    R = R_ref*(1 + alpha*(heatPort.T - T_ref))</pre>
<p><b>alpha</b> is the <b>temperature coefficient of resistance</b>, which is often abbreviated as <b>TCR</b>. In resistor catalogues, it is usually defined as <b>X [ppm/K]</b> (parts per million, similarly to per centage) meaning <b>X*1.e-6 [1/K]</b>. Resistors are available for 1 .. 7000 ppm/K, i.e., alpha = 1e-6 .. 7e-3 1/K;</p>
<p>Via parameter <b>useHeatPort</b> the heatPort connector can be enabled and disabled (default = enabled). If it is disabled, the generated heat is transported implicitly to an internal temperature source with a fixed temperature of T_ref.</p><p>If the heatPort connector is enabled, it must be connected.</p>
</html>",
     revisions="<html>
<ul>
<li><i> August 07, 2009   </i>
       by Anton Haumer<br> temperature dependency of resistance added<br>
       </li>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i> 2002   </i>
       by Anton Haumer<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end HeatingResistor;

model Conductor "Ideal linear electrical conductor"
  parameter Modelica.SIunits.Conductance G(start=1)
      "Conductance at temperature T_ref";
  parameter Modelica.SIunits.Temperature T_ref=300.15 "Reference temperature";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
      "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha*(T_heatPort - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
                                                               T = T_ref);
  Modelica.SIunits.Conductance G_actual
      "Actual conductance = G_ref/(1 + alpha*(T_heatPort - T_ref))";

equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
  G_actual = G/(1 + alpha*(T_heatPort - T_ref));
  i = G_actual*v;
  LossPower = v*i;
  annotation (
    Documentation(info="<html>
<p>The linear conductor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>i = v*G</i>. The Conductance <i>G</i> is allowed to be positive, zero, or negative.</p>
</html>",
 revisions="<html>
<ul>
<li><i> August 07, 2009   </i>
       by Anton Haumer<br> temperature dependency of conductance added<br>
       </li>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
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
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-30}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot),
          Text(
            extent={{-152,87},{148,47}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-144,-38},{142,-70}},
            lineColor={0,0,0},
            textString="G=%G")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Line(points={{-96,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,255}),
          Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255})}));
end Conductor;

  model Capacitor "Ideal linear electrical capacitor"
    extends Interfaces.OnePort;
    parameter SI.Capacitance C(start=1) "Capacitance";

  equation
    i = C*der(v);
    annotation (
      Documentation(info="<html>
<p>The linear capacitor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>i = C * dv/dt</i>. The Capacitance <i>C</i> is allowed to be positive, zero, or negative.</p>
</html>",
   revisions="<html>
<ul>
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
            extent={{-136,-60},{136,-92}},
            lineColor={0,0,0},
            textString="C=%C"),
          Text(
            extent={{-150,85},{150,45}},
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
  end Capacitor;

  model Inductor "Ideal linear electrical inductor"
    extends Interfaces.OnePort;
    parameter SI.Inductance L(start=1) "Inductance";
  equation
    L*der(i) = v;
    annotation (
      Documentation(info="<html>
<p>The linear inductor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>v = L * di/dt</i>. The Inductance <i>L</i> is allowed to be positive, zero, or negative.</p>
</html>",
   revisions="<html>
<ul>
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
            extent={{-138,-60},{144,-94}},
            lineColor={0,0,0},
            textString="L=%L"),
          Text(
            extent={{-152,79},{148,39}},
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
  initial equation
    (Lnom - Linf) = (Lzer - Linf)*Ipar/Inom*(Modelica.Constants.pi/2-Modelica.Math.atan(Ipar/Inom));
  equation
    assert(Lzer > Lnom+Modelica.Constants.eps,
           "Lzer (= " + String(Lzer) + ") has to be > Lnom (= " + String(Lnom) + ")");
    assert(Linf < Lnom-Modelica.Constants.eps,
           "Linf (= " + String(Linf) + ") has to be < Lnom (= " + String(Lnom) + ")");
    (Lact - Linf)*i/Ipar = (Lzer - Linf)*noEvent(Modelica.Math.atan(i/Ipar));
    Psi = Lact*i;
    v = der(Psi);
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
            extent={{-148,-50},{152,-80}},
            lineColor={0,0,0},
            textString="Lnom=%Lnom"),
          Text(
            extent={{-148,91},{152,51}},
            textString="%name",
            lineColor={0,0,255})}),                         Documentation(info="<html>
<p>This model approximates the behaviour of an inductor with the influence of saturation, i.e., the value of the inductance depends on the current flowing through the inductor. The inductance decreases as current increases.</p><p>The parameters are:</p>
<p><ul>
<li>Inom...nominal current</li>
<li>Lnom...nominal inductance at nominal current</li>
<li>Lzer...inductance near current = 0; Lzer has to be greater than Lnom</li>
<li>Linf...inductance at large currents; Linf has to be less than Lnom </li>
</ul></p>
</html>",
   revisions="<html>
<dl>
<p>
  <dt><b>Main Author:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
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
  end SaturatingInductor;

  model Transformer "Transformer with two ports"
    extends Interfaces.TwoPort;
    parameter SI.Inductance L1(start=1) "Primary inductance";
    parameter SI.Inductance L2(start=1) "Secondary inductance";
    parameter SI.Inductance M(start=1) "Coupling inductance";
  equation
    v1 = L1*der(i1) + M*der(i2);
    v2 = M*der(i1) + L2*der(i2);
    annotation (
      Documentation(info="<html>
<p>The transformer is a two port. The left port voltage <i>v1</i>, left port current <i>i1</i>, right port voltage <i>v2</i> and right port current <i>i2</i> are connected by the following relation:</p>
<pre>         | v1 |         | L1   M  |  | i1&apos; |
         |    |    =    |         |  |     |
         | v2 |         | M    L2 |  | i2&apos; |</pre>
<p><i>L1</i>, <i>L2</i>, and <i>M</i> are the primary, secondary, and coupling inductances respectively.</p>
</html>",
   revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
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
            extent={{-103,16},{-60,-10}},
            textString="L1",
            lineColor={0,0,0},
            pattern=LinePattern.Dot),
          Text(
            extent={{64,15},{105,-9}},
            textString="L2",
            lineColor={0,0,0},
            pattern=LinePattern.Dot),
          Text(
            extent={{-27,-71},{33,-97}},
            textString="M",
            lineColor={0,0,0}),
          Text(
            extent={{-153,113},{147,73}},
            textString="%name",
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
  end Transformer;

model M_Transformer "Generic transformer with free number of inductors"

  parameter Integer N(final min=1)=3 "number of inductors";
  protected
  parameter Integer dimL=div(N*(N+1),2);
  public
  parameter Modelica.SIunits.Inductance L[dimL]={1,0.1,0.2,2,0.3,3}
      "inductances and coupling inductances";
  Modelica.Electrical.Analog.Interfaces.PositivePin p[N] "Positive pin"
              annotation (extent=[-80,-40; -62,40], Placement(transformation(
          extent={{-80,-40},{-62,40}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[N] "Negative pin"
              annotation (extent=[62,-40; 80,40], Placement(transformation(
          extent={{62,-40},{80,40}}, rotation=0)));

  Modelica.SIunits.Voltage v[N];
  Modelica.SIunits.Current i[N];
  Modelica.SIunits.Inductance Lm[N,N];
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
      coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
        graphics={
          Ellipse(extent={{-36,24},{-18,42}}, lineColor={0,0,255}),
          Ellipse(extent={{18,24},{36,42}}, lineColor={0,0,255}),
          Ellipse(extent={{0,24},{18,42}}, lineColor={0,0,255}),
          Ellipse(extent={{-18,24},{0,42}}, lineColor={0,0,255}),
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
          Ellipse(extent={{-36,8},{-18,26}}, lineColor={0,0,255}),
          Ellipse(extent={{18,8},{36,26}}, lineColor={0,0,255}),
          Ellipse(extent={{0,8},{18,26}}, lineColor={0,0,255}),
          Ellipse(extent={{-18,8},{0,26}}, lineColor={0,0,255}),
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
          Ellipse(extent={{-36,-40},{-18,-22}}, lineColor={0,0,255}),
          Ellipse(extent={{-18,-40},{0,-22}}, lineColor={0,0,255}),
          Ellipse(extent={{0,-40},{18,-22}}, lineColor={0,0,255}),
          Ellipse(extent={{18,-40},{36,-22}}, lineColor={0,0,255}),
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
            pattern=LinePattern.Dot),
          Text(
            extent={{-150,103},{150,63}},
            textString="%name",
            lineColor={0,0,255})},
      Ellipse(extent=[-36,24; -18,42]),
      Ellipse(extent=[18,24; 36,42]),
      Ellipse(extent=[0,24; 18,42]),
      Ellipse(extent=[-18,24; 0,42]),
      Rectangle(extent=[42,24; -44,34], fillColor={255,255,255}),
      Line(points=[-36,34; -62,34]),
      Line(points=[62,34; 36,34]),
      Ellipse(extent=[-36,8; -18,26]),
      Ellipse(extent=[18,8; 36,26]),
      Ellipse(extent=[0,8; 18,26]),
      Ellipse(extent=[-18,8; 0,26]),
      Rectangle(extent=[42,6; -44,18], fillColor={255,255,255}),
      Line(points=[-36,18; -62,18]),
      Line(points=[62,18; 36,18]),
      Line(points=[-36,-29; -62,-29]),
      Ellipse(extent=[-36,-40; -18,-22]),
      Ellipse(extent=[-18,-40; 0,-22]),
      Ellipse(extent=[0,-40; 18,-22]),
      Ellipse(extent=[18,-40; 36,-22]),
      Line(points=[62,-29; 36,-29]),
      Rectangle(extent=[42,-42; -44,-30], fillColor={255,255,255}),
      Line(points=[0,8; 0,-18])), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                    graphics),
Documentation(info="<html>
<p>The model <i>M_Transformer</i> is a model of a transformer with the posibility to choose the number of inductors. Inside the model, an inductance matrix is built based on the inductance of the inductors and the coupling inductances between the inductors given as a parameter vector from the user of the model.</p>

<p>An example shows that approach:<br/>
The user chooses a model with <b>three</b> inductors, that means the parameter <i><b>N</b></i> has to be <b>3</b>. Then he has to specify the inductances of the three inductors and the three coupling inductances. The coupling inductances are no real existing devices, but effects that occur between two inductors. The inductivities (main diagonal of the inductance matrix) and the coupling inductivities have to be specified in the parameter vector <i>L</i>. The length <i>dimL</i> of the parameter vector is calculated as follows: <i><b>dimL=(N*(N+1))/2</b></i></p>

<p>The following example shows how the parameter vector is used to fill in the inductance matrix. To specify the inductance matrix of a three inductances transformer (<i>N=3</i>):</p>
<p>
<img
 src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Basic/M_Transformer-eq.png\"
 alt=\"L_m\">
</p>

<p>the user has to allocate the parameter vector <i>L[6] </i>, since <i>Nv=(N*(N+1))/2=(3*(3+1))/2=6</i>. The parameter vector must be filled like this: <i>L=[1,0.1,0.2,2,0.3,3] </i>.</p>
<p>Inside the model, two loops are used to fill the inductance matrix to guarantee that it is filled in a symmetric way.</p>
</html>",
revisions="
<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Version</th>
      <th>Revision</th>
      <th>Date</th>
      <th>Author</th>
      <th>Comment</th>
    </tr>
   <tr>
      <td valign=\"top\"></td>
      <td valign=\"top\">4163</td>
      <td valign=\"top\">2010-09-11</td>
      <td valign=\"top\">Dietmar Winkler</td>
      <td valign=\"top\">Documentation corrected according to documentation guidelines.</td>
    </tr>
    <tr>
      <td valign=\"top\"></td>
      <td valign=\"top\"></td>
      <td valign=\"top\">2008-11-24</td>
      <td valign=\"top\">Kristin Majetta</td>
      <td valign=\"top\">Documentation added.</td>
    </tr>
    <tr>
      <td valign=\"top\"></td>
      <td valign=\"top\"></td>
      <td valign=\"top\">2008-11-16</td>
      <td valign=\"top\">Kristin Majetta</td>
      <td valign=\"top\">Initially implemented</td>
    </tr>
</table>
</html>
"));
end M_Transformer;

  model Gyrator "Gyrator"
    extends Interfaces.TwoPort;
    parameter SI.Conductance G1(start=1) "Gyration conductance";
    parameter SI.Conductance G2(start=1) "Gyration conductance";
  equation
    i1 = G2*v2;
    i2 = -G1*v1;
    annotation (
      Documentation(info="<html>
<p>A gyrator is a two-port element defined by the following equations:</p>
<pre>    i1 =  G2 * v2
    i2 = -G1 * v1</pre>
<p>where the constants <i>G1</i>, <i>G2</i> are called the gyration conductance.</p>
</html>",
   revisions="<html>
<ul>
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
          Line(points={{-5,10},{-10,-10}}, color={0,0,0}),
          Line(points={{9,10},{4,-9}}, color={0,0,0}),
          Line(points={{-14,9},{16,10}}, color={0,0,0}),
          Text(
            extent={{-29,59},{30,30}},
            textString="G1",
            lineColor={0,0,0}),
          Text(
            extent={{-29,-29},{29,-58}},
            textString="G2",
            lineColor={0,0,0}),
          Text(
            extent={{-156,117},{144,77}},
            textString="%name",
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
    SI.AngularVelocity w "Angular velocity of flange relative to support";
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
            extent={{0,-50},{199,-90}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{0,80},{189,46}},
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
      Documentation(info="<html>
<p>EMF transforms electrical energy into rotational mechanical energy. It is used as basic building block of an electrical motor. The mechanical connector flange can be connected to elements of the Modelica.Mechanics.Rotational library. flange.tau is the cut-torque, flange.phi is the angle at the rotational connection.</p>
</html>",
   revisions="<html>
<ul>
<li><i> 1998   </i>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end EMF;

  model TranslationalEMF "Electromotoric force (electric/mechanic transformer)"
    parameter Boolean useSupport=false
      "= true, if support flange enabled, otherwise implicitly grounded"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Modelica.SIunits.ElectricalForceConstant k(start=1)
      "Transformation coefficient";

    Modelica.SIunits.Voltage v "Voltage drop between the two pins";
    Modelica.SIunits.Current i "Current flowing from positive to negative pin";
    Modelica.SIunits.Position s "Position of flange relative to support";
    Modelica.SIunits.Velocity vel "Velocity of flange relative to support";

    Modelica.Electrical.Analog.Interfaces.PositivePin p
      annotation (Placement(transformation(
          origin={0,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Electrical.Analog.Interfaces.NegativePin n
      annotation (Placement(transformation(
          origin={0,-100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange
       annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
    Modelica.Mechanics.Translational.Interfaces.Support support if useSupport
      "Support/housing"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  protected
    Modelica.Mechanics.Translational.Components.Fixed fixed if not useSupport
      annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
    Modelica.Mechanics.Translational.Interfaces.InternalSupport internalSupport(f=-flange.f)
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  equation
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;

    s = flange.s - internalSupport.s;
    vel = der(s);
    k*vel = v;
    flange.f = -k*i;
    connect(internalSupport.flange, support) annotation (Line(
        points={{-80,0},{-90,0},{-90,0},{-100,0}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(internalSupport.flange, fixed.flange) annotation (Line(
        points={{-80,0},{-80,-10}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (defaultComponentName="emf",
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-90,51},{-40,-50}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-21,20},{90,-20}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{0,80},{148,44}},
            lineColor={160,160,164},
            textString="k=%k"),
          Line(points={{-30,49},{-30,80},{0,80},{0,91}}, color={0,0,255}),
          Line(points={{20,-49},{20,-80},{0,-80},{0,-89},{0,-90}}, color={0,0,
                255}),
          Ellipse(extent={{-21,50},{9,-50}}, lineColor={0,0,255}),
          Ellipse(extent={{2,50},{32,-50}}, lineColor={0,0,255}),
          Ellipse(extent={{-43,50},{-13,-50}}, lineColor={0,0,255}),
          Rectangle(
            extent={{-4,20},{-1,-20}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{7,20},{10,-20}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-14,20},{-11,-20}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{19,20},{44,-20}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Line(
            visible=not useSupport,
            points={{-100,-70},{-40,-70}},
            color={0,0,0}),
          Line(
            visible=not useSupport,
            points={{-100,-90},{-80,-70}},
            color={0,0,0}),
          Line(
            visible=not useSupport,
            points={{-80,-90},{-60,-70}},
            color={0,0,0}),
          Line(
            visible=not useSupport,
            points={{-60,-90},{-40,-70}},
            color={0,0,0}),
          Line(
            visible=not useSupport,
            points={{-70,-70},{-70,-50}},
            color={0,0,0}),
          Text(
            extent={{0,-50},{199,-90}},
            textString="%name",
            lineColor={0,0,255})}),
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
          Line(points={{14,80},{14,70}}, color={192,192,192}),
          Polygon(
            points={{140,3},{150,0},{140,-3},{140,3},{140,3}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Window(
        x=0.21,
        y=0,
        width=0.65,
        height=0.66),
      Documentation(info="<html>
<p>EMF transforms electrical energy into translational mechanical energy. It is used as basic building block of an electrical linear motor. The mechanical connector flange can be connected to elements of the Modelica.Mechanics.Translational library. flange.f is the cut-force, flange.s is the distance at the translational connection.</p>
</html>",
   revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 2009   </i>
       by Anton Haumer<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end TranslationalEMF;

  model VCV "Linear voltage-controlled voltage source"
    extends Interfaces.TwoPort;
    parameter Real gain(start=1) "Voltage gain";

  equation
    v2 = v1*gain;
    i1 = 0;
    annotation (
      Documentation(info="<html>
<p>The linear voltage-controlled voltage source is a TwoPort. The right port voltage v2 is controlled by the left port voltage v1 via</p>
<pre>    v2 = v1 * gain. </pre>
<p>The left port current is zero. Any voltage gain can be chosen.</p>
</html>",
   revisions="<html>
<ul>
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
          Line(points={{-90,50},{-30,50}}, color={0,0,255}),
          Line(points={{-30,-50},{-90,-50}}, color={0,0,255}),
          Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}),
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-148,-81},{152,-121}},
            textString="%name",
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
  end VCV;

  model VCC "Linear voltage-controlled current source"
    extends Interfaces.TwoPort;
    parameter SI.Conductance transConductance(start=1) "Transconductance";
  equation
    i2 = v1*transConductance;
    i1 = 0;
    annotation (
      Documentation(info="<html>
<p>The linear voltage-controlled current source is a TwoPort. The right port current i2 is controlled by the left port voltage v1 via</p>
<pre>    i2 = v1 * transConductance. </pre>
<p>The left port current is zero. Any transConductance can be chosen.</p>
</html>",
   revisions="<html>
<ul>
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
          Line(points={{10,0},{50,0}}, color={0,0,255}),
          Text(
            extent={{-143,-82},{157,-122}},
            textString="%name",
            lineColor={0,0,255})}),
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
  end VCC;

  model CCV "Linear current-controlled voltage source"
    extends Interfaces.TwoPort;

    parameter SI.Resistance transResistance(start=1) "Transresistance";

  equation
    v2 = i1*transResistance;
    v1 = 0;
    annotation (
      Documentation(info="<html>
<p>The linear current-controlled voltage source is a TwoPort. The right port voltage v2 is controlled by the left port current i1 via</p>
<pre>    v2 = i1 * transResistance. </pre>
<p>The left port voltage is zero. Any transResistance can be chosen.</p>
</html>",
   revisions="<html>
<ul>
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
          Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}),
          Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
          Line(points={{-20,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,60},{10,63},{10,57},{20,60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-90,50},{-20,50},{-20,-50},{-90,-50}}, color={0,0,255}),
          Text(
            extent={{-140,-82},{160,-122}},
            textString="%name",
            lineColor={0,0,255})}),
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
  end CCV;

  model CCC "Linear current-controlled current source"
    extends Interfaces.TwoPort;
    parameter Real gain(start=1) "Current gain";

  equation
    i2 = i1*gain;
    v1 = 0;
    annotation (
      Documentation(info="<html>
<p>The linear current-controlled current source is a TwoPort. The right port current i2 is controlled by the left port current i1 via</p>
<pre>    i2 = i1 * gain. </pre>
<p>The left port voltage is zero. Any current gain can be chosen.</p>
</html>",
   revisions="<html>
<ul>
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
          Line(points={{10,0},{50,0}}, color={0,0,255}),
          Text(
            extent={{-146,-76},{154,-116}},
            textString="%name",
            lineColor={0,0,255})}),
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
    annotation (
      Documentation(info="<html>
<p>The OpAmp is a simle nonideal model with a smooth out.v = f(vin) characteristic, where &QUOT;vin = in_p.v - in_n.v&QUOT;. The characteristic is limited by VMax.v and VMin.v. Its slope at vin=0 is the parameter Slope, which must be positive. (Therefore, the absolute value of Slope is taken into calculation.)</p>
</html>",
   revisions="<html>
<ul>
<li><i> 2000   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
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
          Line(points={{0,35},{0,80}}, color={0,0,255}),
          Line(points={{0,-35},{0,-80}}, color={0,0,255}),
          Line(points={{-90,50},{-60,50}}, color={0,0,255}),
          Line(points={{-90,-50},{-60,-50}}, color={0,0,255}),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Line(points={{-48,32},{-28,32}}, color={0,0,255}),
          Line(points={{-39,-20},{-39,-41}}, color={0,0,255}),
          Line(points={{-50,-31},{-28,-31}}, color={0,0,255}),
          Text(
            extent={{-149,138},{151,98}},
            textString="%name",
            lineColor={0,0,255})}),
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
            textString="i2"),
          Text(
            extent={{-111,60},{-85,80}},
            lineColor={160,160,164},
            textString="in_n.i=0"),
          Line(
            points={{-100,-35},{-100,23},{-100,24}},
            color={160,160,164},
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{-97,-16},{-74,4}},
            lineColor={160,160,164},
            textString="vin")}));
  end OpAmp;

  model OpAmpDetailed "Detailed model of an operational amplifier"
  // literature: Conelly, J.A.; Choi, P.: Macromodelling with SPICE. Englewood Cliffs: Prentice-Hall, 1992
    import SI = Modelica.SIunits;
    parameter SI.Resistance Rdm=2.0e6
      "Input resistance (differential input mode)";
    parameter SI.Resistance Rcm=2.0e9 "Input resistance (common mode)";
    parameter SI.Capacitance Cin=1.4e-12 "Input capacitance";
    parameter SI.Voltage Vos=1.0e-3 "Input offset voltage";
    parameter SI.Current Ib=80.0e-9 "Input bias current";
    parameter SI.Current Ios=20.0e-9 "Input offset current";
    parameter SI.Voltage vcp=0.0 "Correction value for limiting by p_supply";
    parameter SI.Voltage vcm=0.0 "Correction value for limiting by msupply";
    parameter Real Avd0=106.0 "Differential amplifier [dB]";
    parameter Real CMRR=90.0 "Common-mode rejection [dB]";
    parameter SI.Frequency fp1=5.0 "Dominant pole";
    parameter SI.Frequency fp2=2.0e6 "Pole frequency";
    parameter SI.Frequency fp3=20.0e6 "Pole frequency";
    parameter SI.Frequency fp4=100.0e6 "Pole frequency";
    parameter SI.Frequency fz=5.0e6 "Zero frequency";
    parameter SI.VoltageSlope sr_p=0.5e6 "Slew rate for increase";
    parameter SI.VoltageSlope sr_m=0.5e6 "Slew rate for decrease";
    parameter SI.Resistance Rout=75.0 "Output resistance";
    parameter SI.Current Imaxso=25.0e-3
      "Maximal output current (source current)";
    parameter SI.Current Imaxsi=25.0e-3 "Maximal output current (sink current)";

  // number of intervalls: 2500, stop time: 0.003
    parameter SI.Time Ts=0.0000012 "sampling time";

  // constant expressions
    constant Real Pi=3.141592654;

   // power supply
    final parameter SI.Voltage vcp_abs = abs(vcp)
      "Positive correction value for limiting by p_supply";
    final parameter SI.Voltage vcm_abs = abs(vcm)
      "Positive correction value for limiting by msupply";

  // input stage
  //  Ib = 0.5*(I1 + I2);
  //  Ios = I1 - I2;
    final parameter SI.Current I1 =  Ib + Ios/2.0
      "Current of internal source I1";
    final parameter SI.Current I2 =  Ib - Ios/2.0
      "Current of internal source I2";

  // gain stage (difference and common mode)
    final parameter Real Avd0_val = 10.0^(Avd0/20.0) "differential mode gain";
    final parameter Real Avcm_val = (Avd0_val/(10.0^(CMRR/20.0)))/2.0
      "common mode gain";

  // slew rate stage
    final parameter SI.VoltageSlope sr_p_val =  abs(sr_p)
      "Value of slew rate for increase";
    final parameter SI.VoltageSlope sr_m_val = -abs(sr_m)
      "Negative alue of slew rate for increase";

  // output stage
    final parameter SI.Current Imaxso_val = abs(Imaxso) "Orientation out outp";
    final parameter SI.Current Imaxsi_val = abs(Imaxsi) "Orientation into outp";

    Modelica.Electrical.Analog.Interfaces.PositivePin p
      "Positive pin of the input port" annotation (Placement(transformation(
            extent={{-111,-61},{-90,-40}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin m
      "Negative pin of the input port" annotation (Placement(transformation(
            extent={{-90,40},{-111,61}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin outp "Output pin"
      annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=
             0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin p_supply
      "Positive output voltage limitation" annotation (Placement(transformation(
            extent={{-8,65},{9,82}},   rotation=0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin m_supply
      "Negative output voltage limitation" annotation (Placement(transformation(
            extent={{-9,-83},{9,-65}},   rotation=0)));

  // power supply
    SI.Voltage v_pos;
    SI.Voltage v_neg;

  // input stage
    Modelica.SIunits.Voltage v_vos;
    Modelica.SIunits.Voltage v_3;
    Modelica.SIunits.Voltage v_in;
    Modelica.SIunits.Voltage v_4;

    Modelica.SIunits.Current i_vos;
    Modelica.SIunits.Current i_3;
    Modelica.SIunits.Current i_r2;
    Modelica.SIunits.Current i_c3;
    Modelica.SIunits.Current i_4;

  // frequency response
    Real q_fr1;
    Real q_fr2;
    Real q_fr3;

  // gain stage
    SI.Voltage q_sum;
    SI.Voltage q_sum_help;
    SI.Voltage q_fp1;

  // slew rate stage
    SI.Voltage v_source;

    SI.Voltage x "auxiliary variable for slew rate";

  // output stage
    Modelica.SIunits.Voltage v_out;

    Modelica.SIunits.Current i_out;

  // functions
    function FCNiout_limit "Internal limitation function"
      input SI.Voltage v_source;
      input SI.Voltage v_out;
      input SI.Resistance Rout;
      input SI.Current Imaxsi_val;
      input SI.Current Imaxso_val;
      output SI.Current result;

    algorithm
        if  v_out > v_source + Rout*Imaxsi_val then
            result := Imaxsi_val;
        elseif v_out < v_source - Rout*Imaxso_val then
            result := -Imaxso_val;
        else
            result := (v_out - v_source)/Rout;
        end if;
        return;
      annotation (Documentation(info="<html>
<p>Internal limitation function, designed for OpAmpDetailed, not for purpose of external usage.</p>
</html>"));
    end FCNiout_limit;

    function FCNq_sum_limit "Internal limitation function"
      input SI.Voltage q_sum;
      input SI.Voltage q_sum_ltf;
      input SI.Voltage v_pos;
      input SI.Voltage v_neg;
      input SI.Voltage vcp;
      input SI.Voltage vcm;
      output SI.Voltage result;

    algorithm
        if  q_sum > v_pos - vcp and q_sum_ltf >= v_pos - vcp then
          result := v_pos - vcp;
        elseif q_sum < v_neg + vcm and q_sum_ltf <= v_neg + vcm then
          result := v_neg + vcm;
        else
          result := q_sum;
        end if;
      return;
      annotation (Documentation(info="<html>
<p>Internal limitation function, designed for OpAmpDetailed, not for purpose of external usage.</p>
</html>"));
    end FCNq_sum_limit;

  equation
  assert(Rout > 0.0, "Rout must be > 0.0.");

  // power supply
    v_pos = p_supply.v;
    v_neg = m_supply.v;

  // input stage
    p.i = i_vos;
    m.i = i_4 - i_r2 - i_c3;
    0 = i_3 + i_r2 + i_c3 - i_vos;
    p.v - m.v = v_vos + v_in;
    v_4 = m.v;
    v_3 = p.v - v_vos;
    v_vos = Vos;
    i_3 = I1 + v_3/Rcm;
    v_in = Rdm*i_r2;
    i_c3 = Cin*der(v_in);
    i_4 = I2 + v_4/Rcm;

  // frequency response
  // Laplace transformation
      der(q_fr1) = 2.0*Pi*fp2*(v_in - q_fr1);
      q_fr2 + (1.0/(2.0*Pi*fp3))*der(q_fr2) = q_fr1 + (1.0/(2.0*Pi*fz))*der(q_fr1);
      der(q_fr3) = 2.0*Pi*fp4*(q_fr2 - q_fr3);

  // gain stage
  // Laplace transformation
    q_sum = Avd0_val*q_fr3 + Avcm_val*(v_3 + v_4);
    q_sum_help = FCNq_sum_limit(
      q_sum,
      q_fp1,
      v_pos,
      v_neg,
      vcp_abs,
      vcm_abs);
    der(q_fp1) = 2.0*Pi*fp1*(q_sum_help - q_fp1);

  // slew rate stage
     if initial() then
        v_source = q_fp1;
        x = 0;
     end if;

     der(x) = (q_fp1 - v_source)/Ts;
     der(v_source) = smooth(0,noEvent(
     if der(x) > sr_p_val then sr_p_val else
     if der(x) < sr_m_val then sr_m_val else
        der(x)));

  // output stage
    v_out = outp.v;
    i_out = outp.i;
    i_out = FCNiout_limit(
      v_source,
      v_out,
      Rout,
      Imaxsi_val,
      Imaxso_val);

    p_supply.i = 0;
    m_supply.i = 0;

    annotation (
      Documentation(info="<html>
<p>The OpAmpDetailed model is a general operational amplifier model. The emphasis is on separating each important data sheet parameter into a sub-circuit independent of the other parameters. The model is broken down into five functional stages <b>input</b>, <b>frequency response</b>, <b>gain</b>, <b>slew rate</b> and an <b>output</b> stage. Each stage contains data sheet parameters to be modeled. This partitioning and the modelling of the separate submodels are based on the description in <b>[CP92]</b>.</p>
<p>Using <b>[CP92]</b> Joachim Haase (Fraunhofer Institute for Integrated Circuits, Design Automation Division) transfered 2001 operational amplifier models into VHDL-AMS. Now one of these models, the model &QUOT;amp(macro)&QUOT; was transferred into Modelica.</p>
<dl><dt><b>Reference:</b> </dt>
<dd><b>[CP92]</b> Conelly, J.A.; Choi, P.: Macromodelling with SPICE. Englewood Cliffs: Prentice-Hall, 1992 </dd>
</dl></html>",
   revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> Juni 17, 2009   </i>
       by Susann Wolf<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{60,0},{-60,70},{-60,-70},{60,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{0,35},{0,80}}, color={0,0,255}),
          Line(points={{0,-35},{0,-80}}, color={0,0,255}),
          Line(points={{-90,50},{-60,50}}, color={0,0,255}),
          Line(points={{-90,-50},{-60,-50}}, color={0,0,255}),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Line(points={{-48,32},{-28,32}}, color={0,0,255}),
          Line(points={{-39,-20},{-39,-41}}, color={0,0,255}),
          Line(points={{-50,-31},{-28,-31}}, color={0,0,255}),
          Text(
            extent={{-151,141},{149,101}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{60,0},{-60,70},{-60,-70},{60,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{0,35},{0,70}}, color={0,0,255}),
          Line(points={{0,-35},{0,-70}}, color={0,0,255}),
          Line(points={{-96,50},{-60,50}}, color={0,0,255}),
          Line(points={{-96,-50},{-60,-50}}, color={0,0,255}),
          Line(points={{60,0},{96,0}}, color={0,0,255}),
          Line(points={{-55,50},{-45,50}}, color={0,0,255}),
          Line(points={{-50,-45},{-50,-55}}, color={0,0,255}),
          Line(points={{-55,-50},{-45,-50}}, color={0,0,255}),
          Polygon(
            points={{120,3},{110,0},{120,-3},{120,3}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={160,160,164}),
          Line(points={{111,0},{136,0}}, color={0,0,0}),
          Text(
            extent={{114,2},{131,17}},
            lineColor={0,0,0},
            textString="i2"),
          Line(
            points={{-100,-35},{-100,23},{-100,24}},
            color={160,160,164},
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{-97,-16},{-74,4}},
            lineColor={160,160,164},
            textString="vin")}));
  end OpAmpDetailed;

      model VariableResistor
    "Ideal linear electrical resistor with variable resistance"
        parameter Modelica.SIunits.Temperature T_ref=300.15
      "Reference temperature";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
      "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(TheatPort - T_ref))";
        extends Modelica.Electrical.Analog.Interfaces.OnePort;
        extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(                    T = T_ref);
        Modelica.SIunits.Resistance R_actual
      "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";
        Modelica.Blocks.Interfaces.RealInput R
          annotation (Placement(transformation(
        origin={0,110},
        extent={{-20,-20},{20,20}},
        rotation=270)));
      equation
        assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
        R_actual = R*(1 + alpha*(T_heatPort - T_ref));
        v = R_actual*i;
        LossPower = v*i;
        annotation (
          Documentation(info="<html>
<p><br/>The linear resistor connects the branch voltage <i>v</i> with the branch current <i>i</i> by</p><p><br/><i><b>i*R = v</b></i></p>
<p>The Resistance <i>R</i> is given as input signal.</p>
<p><br/><b>Attention!!!</b></p><p><br/>It is recommended that the R signal should not cross the zero value. Otherwise depending on the surrounding circuit the probability of singularities is high.</p>
</html>",revisions="<html>
<ul>
<li><i> August 07, 2009   </i>
       by Anton Haumer<br> temperature dependency of resistance added<br>
       </li>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>June 7, 2004   </i>
       by Christoph Clauss<br>changed, docu added<br>
       </li>
<li><i>April 30, 2004</i>
       by Anton Haumer<br>implemented.
       </li>
</ul>
</html>"),Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Line(points={{0,90},{0,30}}, color={0,0,255}),
          Text(
            extent={{-148,-41},{152,-81}},
            textString="%name",
            lineColor={0,0,255})}),
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
      end VariableResistor;

      model VariableConductor
    "Ideal linear electrical conductor with variable conductance"
        parameter Modelica.SIunits.Temperature T_ref=300.15
      "Reference temperature";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
      "Temperature coefficient of conductance (G_actual = G/(1 + alpha*(TheatPort - T_ref))";
        extends Modelica.Electrical.Analog.Interfaces.OnePort;
        extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(                    T = T_ref);
        Modelica.SIunits.Conductance G_actual
      "Actual conductance = G/(1 + alpha*(T_heatPort - T_ref))";
        Modelica.Blocks.Interfaces.RealInput G
          annotation (Placement(transformation(
        origin={0,110},
        extent={{-20,-20},{20,20}},
        rotation=270)));
      equation
        assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
        G_actual = G/(1 + alpha*(T_heatPort - T_ref));
        i = G_actual*v;
        LossPower = v*i;
        annotation (
          Documentation(info="<html>
<p><br/>The linear conductor connects the branch voltage <i>v</i> with the branch current <i>i</i> by</p><p><br/><i><b>i = G*v</b></i></p>
<p>The Conductance <i>G</i> is given as input signal.</p>
<p><br/><b>Attention!!!</b></p><p><br/>It is recommended that the G signal should not cross the zero value. Otherwise depending on the surrounding circuit the probability of singularities is high.</p>
</html>",revisions="<html>
<ul>
<li><i> August 07, 2009   </i>
       by Anton Haumer<br> temperature dependency of conductance added<br>
       </li>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>June 7, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Line(points={{0,90},{0,30}}, color={0,0,255}),
          Text(
            extent={{-148,-41},{152,-81}},
            textString="%name",
            lineColor={0,0,255})}),
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
        equation
          assert(C>=0,"Capacitance C (= " +
                 String(C) + ") has to be >= 0!");
          // protect solver from index change
          Q = noEvent(max(C,Cmin))*v;
          i = der(Q);
          annotation (
            Documentation(info="<html>
<p><br/>The linear capacitor connects the branch voltage <i>v</i> with the branch current <i>i</i> by</p><p><br/><i><b>i = dQ/dt</b></i> with <i><b>Q = C * v</b></i><b> </b>.</p>
<p>The capacitance <i>C</i> is given as input signal.</p>
<p>It is required that C &ge; 0, otherwise an assertion is raised. To avoid a variable index system,</p><p>C = Cmin, if 0 &le; C &LT; Cmin, where Cmin is a parameter with default value Modelica.Constants.eps.</p>
</html>",  revisions=
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
            color={0,0,255}),
          Text(
            extent={{-144,-43},{156,-83}},
            textString="%name",
            lineColor={0,0,255})}),
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
        equation
          assert(L>=0,"Inductance L_ (= " +
                 String(L) + ") has to be >= 0!");
          // protect solver from index change
          Psi = noEvent(max(L,Lmin))*i;
          v = der(Psi);
          annotation (
            Documentation(info="<html>
<p><br/>The linear inductor connects the branch voltage <i>v</i> with the branch current <i>i</i> by</p><p><br/><i><b>v = d Psi/dt </b></i>with <i><b>Psi = L * i </b></i>.</p>
<p>The inductance <i>L</i> is as input signal.</p>
<p>It is required that L &ge; 0, otherwise an assertion is raised. To avoid a variable index system,</p><p>L = Lmin, if 0 &le; L &LT; Lmin, where Lmin is a parameter with default value Modelica.Constants.eps.</p>
</html>",  revisions=
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
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-146,-47},{154,-87}},
            textString="%name",
            lineColor={0,0,255})}),
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
        end VariableInductor;

  annotation (
Documentation(info="<html>
<p>This package contains very basic analog electrical components such as resistor, conductor, condensator, inductor, and the ground (which is needed in each electrical circuit description. Furthermore, controled sources, coupling components, and some improved (but newertheless basic) are in this package.</p>
</html>",
   revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
</dl>
</html>"));
end Basic;
