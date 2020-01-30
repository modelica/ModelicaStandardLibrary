within Modelica.Electrical.Machines.Sensors;
model ElectricalPowerSensor "Instantaneous power from space phasors"
  extends Modelica.Icons.RoundSensor;
  constant Integer m(final min=1) = 3 "Number of phases";
  Modelica.Blocks.Interfaces.RealOutput P(final quantity="Power", final
      unit="W") annotation (Placement(transformation(
        origin={-50,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput Q(final quantity="Power", final
      unit="var") annotation (Placement(transformation(
        origin={50,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_ni(final m=m)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_nv(final m=m)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  SI.Voltage v_[2];
  SI.Current i_[2];
equation
  plug_p.pin.v = plug_ni.pin.v;
  plug_p.pin.i + plug_ni.pin.i = zeros(m);
  plug_nv.pin.i = zeros(m);
  v_ = Machines.SpacePhasors.Functions.ToSpacePhasor(plug_p.pin.v - plug_nv.pin.v);
  i_ = Machines.SpacePhasors.Functions.ToSpacePhasor(plug_p.pin.i);
  2/3*P = +v_[1]*i_[1] + v_[2]*i_[2];
  2/3*Q = -v_[1]*i_[2] + v_[2]*i_[1];
  annotation (defaultComponentName="powerSensor",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{-90,0},{90,0}},
          color={0,0,255}),
          Line(points={{0,-70},{0,-90}}, color={0,0,255}),Line(points={{-10,
          70},{-10,80},{-50,80},{-50,100}}, color={0,0,127}),Line(points={{
          10,70},{10,80},{50,80},{50,100}}, color={0,0,127}),
        Text(
          extent={{-70,100},{-30,60}},
          textColor={64,64,64},
          textString="W"),
        Text(
          extent={{30,100},{70,60}},
          textColor={64,64,64},
          textString="var")}),     Documentation(info="<html>
Three-phase instantaneous voltages (plug_p - plug_nv) and currents (plug_p - plug_ni) are transformed to the corresponding space phasors,<br>
which are used to calculate power quantities:
<ul>
<li>P = instantaneous power, thus giving in stationary state active power.</li>
<li>Q = giving in stationary state reactive power.</li>
</ul></html>"));
end ElectricalPowerSensor;
