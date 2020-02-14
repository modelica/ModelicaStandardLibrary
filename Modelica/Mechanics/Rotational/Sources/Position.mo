within Modelica.Mechanics.Rotational.Sources;
model Position
  "Forced movement of a flange according to a reference angle signal"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  parameter Boolean exact=false
    "Is true/false for exact treatment/filtering of the input signal, respectively"
    annotation (Evaluate=true);
  parameter SI.Frequency f_crit=50
    "If exact=false, critical frequency of filter to filter input signal"
    annotation (Dialog(enable=not exact));
  SI.Angle phi(stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "Rotation angle of flange with respect to support";
  SI.AngularVelocity w(start=0,
    stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "If exact=false, Angular velocity of flange with respect to support else dummy"
    annotation(Dialog(enable=not exact, showStartAttribute = true));
  SI.AngularAcceleration a(start=0)
    "If exact=false, Angular acceleration of flange with respect to support else dummy"
    annotation(Dialog(enable=not exact, showStartAttribute = true));
  Modelica.Blocks.Interfaces.RealInput phi_ref(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg")
    "Reference angle of flange with respect to support as input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

protected
  parameter SI.AngularFrequency w_crit=2*Modelica.Constants.pi*f_crit "Critical frequency";
  constant Real af=1.3617 "s coefficient of Bessel filter";
  constant Real bf=0.6180 "s*s coefficient of Bessel filter";
initial equation
  if not exact then
    phi = phi_ref;
  end if;
equation
  phi = flange.phi - phi_support;
  if exact then
    phi = phi_ref;
    w = 0;
    a = 0;
  else
    // Filter: a = phi_ref*s^2/(1 + (af/w_crit)*s + (bf/w_crit^2)*s^2)
    w = der(phi);
    a = der(w);
    a = ((phi_ref - phi)*w_crit - af*w)*(w_crit/bf);
  end if;
  annotation (
    Documentation(info="<html>
<p>
The input signal <strong>phi_ref</strong> defines the <strong>reference
angle</strong> in [rad]. Flange <strong>flange</strong> is <strong>forced</strong>
to move according to this reference motion relative to flange support. According to parameter
<strong>exact</strong> (default = <strong>false</strong>), this is done in the following way:
</p>
<ol>
<li><strong>exact=true</strong><br>
    The reference angle is treated <strong>exactly</strong>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least twice. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal twice
    in order to compute the reference acceleration of the flange.</li>
<li><strong>exact=false</strong><br>
    The reference angle is <strong>filtered</strong> and the second derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This second derivative is <strong>not</strong> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a second order Bessel filter is used.
    The critical frequency (also called cut-off frequency) of the
    filter is defined via parameter <strong>f_crit</strong> in [Hz]. This value
    should be selected in such a way that it is higher as the essential
    low frequencies in the signal.</li>
</ol>
<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-100.0,-20.0},{100.0,20.0}}),
    Line(points={{-30,-32},{30,-32}}),
    Line(points={{0,52},{0,32}}),
    Line(points={{-29,32},{30,32}}),
    Line(points={{0,-32},{0,-100}}),
    Text(extent={{-150,-60},{-40,-30}},
          textColor={128,128,128},
          textString="phi_ref",
          horizontalAlignment=TextAlignment.Right),
    Text(textColor={0,0,255},
      extent={{-150,60},{150,100}},
      textString="%name"),
    Text(extent={{30,-60},{150,-30}},
      textString="exact="),
    Text(extent={{30,-90},{150,-60}},
      textString="%exact")}));
end Position;
