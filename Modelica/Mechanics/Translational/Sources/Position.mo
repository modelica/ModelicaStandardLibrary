within Modelica.Mechanics.Translational.Sources;
model Position
  "Forced movement of a flange according to a reference position"
  extends
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
     s(stateSelect=if exact then StateSelect.default else StateSelect.prefer));
  parameter Boolean exact=false
    "Is true/false for exact treatment/filtering of the input signal, respectively"
    annotation (Evaluate=true);
  parameter SI.Frequency f_crit=50
    "If exact=false, critical frequency of filter to filter input signal"
    annotation (Dialog(enable=not exact));
  SI.Velocity v(start=0,
    stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "If exact=false, absolute velocity of flange else dummy"
    annotation(Dialog(enable=not exact, showStartAttribute = true));
  SI.Acceleration a(start=0)
    "If exact=false, absolute acceleration of flange else dummy"
    annotation(Dialog(enable=not exact, showStartAttribute = true));
  Modelica.Blocks.Interfaces.RealInput s_ref(unit="m")
    "Reference position of flange as input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
protected
  parameter SI.AngularFrequency w_crit=2*Modelica.Constants.pi*f_crit "Critical frequency";
  constant Real af=1.3617 "s coefficient of Bessel filter";
  constant Real bf=0.6180 "s*s coefficient of Bessel filter";

initial equation
  if not exact then
    s = s_ref;
  end if;
equation
  if exact then
    s = s_ref;
    v = 0;
    a = 0;
  else
    // Filter: a = s_ref*S^2/(1 + (af/w_crit)*S + (bf/w_crit^2)*S^2)
    v = der(s);
    a = der(v);
    a = ((s_ref - s)*w_crit - af*v)*(w_crit/bf);
  end if;

  annotation (
    Documentation(info="<html>
<p>
The input signal <strong>s_ref</strong> defines the <strong>reference
position</strong> in [m]. Flange <strong>flange</strong> is <strong>forced</strong>
to move relative to the support connector according to this reference motion. According to parameter
<strong>exact</strong> (default = <strong>false</strong>), this is done in the following way:
</p>
<ol>
<li><strong>exact=true</strong><br>
    The reference position is treated <strong>exactly</strong>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least twice. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal twice
    in order to compute the reference acceleration of the flange.</li>
<li><strong>exact=false</strong><br>
    The reference position is <strong>filtered</strong> and the second derivative
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
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{150,60},{-150,100}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{0,52},{0,32}}, color={0,127,0}),
        Line(points={{-29,32},{30,32}}, color={0,127,0}),
        Line(points={{-30,-32},{30,-32}}, color={0,127,0}),
        Line(points={{0,-32},{0,-100}}, color={0,127,0}),
        Text(extent={{30,-60},{150,-30}},
          textString="exact="),
        Text(extent={{30,-90},{150,-60}},
          textString="%exact"),
        Text(extent={{-140,-60},{-40,-30}},
          textColor={128,128,128},
          horizontalAlignment=TextAlignment.Right,
          textString="s_ref")}));
end Position;
