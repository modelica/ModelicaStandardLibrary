within Modelica.Mechanics.Rotational.Sources;
model Speed
  "Forced movement of a flange according to a reference angular velocity signal"
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  parameter Boolean exact=false
    "Is true/false for exact treatment/filtering of the input signal, respectively"
    annotation (Evaluate=true);
  parameter SI.Frequency f_crit=50
    "If exact=false, critical frequency of filter to filter input signal"
    annotation (Dialog(enable=not exact));
  SI.Angle phi(
    start=0,
    fixed=true,
    stateSelect=StateSelect.prefer)
    "Rotation angle of flange with respect to support";
  SI.AngularVelocity w(stateSelect=if exact then StateSelect.default else
        StateSelect.prefer)
    "Angular velocity of flange with respect to support";
  SI.AngularAcceleration a
    "If exact=false, angular acceleration of flange with respect to support else dummy";
  Modelica.Blocks.Interfaces.RealInput w_ref(unit="rad/s")
    "Reference angular velocity of flange with respect to support as input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

protected
  parameter SI.AngularFrequency w_crit=2*Modelica.Constants.pi
      *f_crit "Critical frequency";
initial equation
  if not exact then
    w = w_ref;
  end if;
equation
  phi = flange.phi - phi_support;
  w = der(phi);
  if exact then
    w = w_ref;
    a = 0;
  else
    // Filter: a = w_ref/(1 + (1/w_crit)*s)
    a = der(w);
    a = (w_ref - w)*w_crit;
  end if;
  annotation (
    Documentation(info="<html>
<p>
The input signal <strong>w_ref</strong> defines the <strong>reference
speed</strong> in [rad/s]. Flange <strong>flange</strong> is <strong>forced</strong>
to move relative to flange support according to this reference motion. According to parameter
<strong>exact</strong> (default = <strong>false</strong>), this is done in the following way:
</p>
<ol>
<li><strong>exact=true</strong><br>
    The reference speed is treated <strong>exactly</strong>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least once. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal once
    in order to compute the reference acceleration of the flange.</li>
<li><strong>exact=false</strong><br>
    The reference angle is <strong>filtered</strong> and the second derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This second derivative is <strong>not</strong> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a first order filter is used.
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
    Text(extent={{-140,-60},{-40,-30}},
          textColor={128,128,128},
          horizontalAlignment=TextAlignment.Right,
          textString="w_ref"),
    Text(extent={{30,-60},{150,-30}},
      textString="exact="),
    Text(extent={{30,-90},{150,-60}},
      textString="%exact"),
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-100.0,-20.0},{100.0,20.0}}),
    Line(points={{-30.0,-32.0},{30.0,-32.0}}),
    Line(points={{0.0,52.0},{0.0,32.0}}),
    Line(points={{-29.0,32.0},{30.0,32.0}}),
    Line(points={{0.0,-32.0},{0.0,-100.0}}),
    Text(textColor={0,0,255},
      extent={{-150,60},{150,100}},
      textString="%name")}));
end Speed;
