within Modelica.Mechanics.Translational.Sources;
model Speed "Forced movement of a flange according to a reference speed"
  extends
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
     s(
      start=0,
      fixed=true,
      stateSelect=StateSelect.prefer));
  parameter Boolean exact=false
    "Is true/false for exact treatment/filtering of the input signal, respectively"
    annotation (Evaluate=true);
  parameter SI.Frequency f_crit=50
    "If exact=false, critical frequency of filter to filter input signal"
    annotation (Dialog(enable=not exact));
  SI.Velocity v(stateSelect=if exact then StateSelect.default else
        StateSelect.prefer) "Absolute velocity of flange";
  SI.Acceleration a
    "If exact=false, absolute acceleration of flange else dummy";
  Modelica.Blocks.Interfaces.RealInput v_ref(unit="m/s")
    "Reference speed of flange as input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));

protected
  parameter SI.AngularFrequency w_crit=2*Modelica.Constants.pi
      *f_crit "Critical frequency";
initial equation
  if not exact then
    v = v_ref;
  end if;
equation
  v = der(s);
  if exact then
    v = v_ref;
    a = 0;
  else
    // Filter: a = v_ref/(1 + (1/w_crit)*s)
    a = der(v);
    a = (v_ref - v)*w_crit;
  end if;

  annotation (
    Documentation(info="<html>
<p>
The input signal <strong>v_ref</strong> defines the <strong>reference
speed</strong> in [m/s]. Flange <strong>flange</strong> is <strong>forced</strong>
to move relative to the support connector  according to this reference motion. According to parameter
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
    The reference speed is <strong>filtered</strong> and the first derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This first derivative is <strong>not</strong> computed by
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
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-30,-32},{30,-32}}, color={0,127,0}),
        Line(points={{0,-32},{0,-100}}, color={0,127,0}),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Line(points={{-29,32},{30,32}}, color={0,127,0}),
        Line(points={{0,52},{0,32}}, color={0,127,0}),
        Text(
          extent={{150,60},{-150,100}},
          textString="%name",
          textColor={0,0,255}),
        Text(extent={{-140,-60},{-40,-30}},
          textColor={128,128,128},
          horizontalAlignment=TextAlignment.Right,
          textString="v_ref"),
        Text(extent={{30,-60},{150,-30}},
          textString="exact="),
        Text(extent={{30,-90},{150,-60}},
          textString="%exact")}));
end Speed;
