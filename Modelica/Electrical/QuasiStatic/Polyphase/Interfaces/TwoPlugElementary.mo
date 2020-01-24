within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model TwoPlugElementary "Two plugs with pin-adapter and reference connection, without declaration of voltage and current"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  SI.AngularVelocity omega "Angular velocity of reference frame";

  PositivePlug plug_p(final m=m)
    "Positive quasi-static polyphase plug" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  NegativePlug plug_n(final m=m)
    "Negative quasi-static polyphase plug" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Basic.PlugToPins_p plugToPins_p(final m=m) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));
  Basic.PlugToPins_n plugToPins_n(final m=m) annotation (Placement(
        transformation(
        origin={70,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  omega = der(plug_p.reference.gamma);
  connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,0},{-86,0},{-72,0}}, color={85,170,255}));
  connect(plugToPins_n.plug_n, plug_n) annotation (Line(points={{72,0},{86,0},{100,0}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">negative plug</a>
but no complex voltage, current, power, etc.
A <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p\">positive</a> and
a <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n\">negative adapter</a>
are used to give easy access to the single pins of both plugs. Additionally, the angular velocity of the
quasi-static system is explicitly defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlug\">TwoPlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPlugElementary;
