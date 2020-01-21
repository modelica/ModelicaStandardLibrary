within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model ACtwoPlug "Two AC polyphase plugs"
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac_p(final m=m)
    "Positive potential AC input"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug ac_n(final m=m)
    "Negative potential AC input"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  SI.Voltage vAC[m]=ac_p.pin[:].v - ac_n.pin[:].v "AC voltages";
  SI.Current iAC[m]=ac_p.pin[:].i "AC currents";
  SI.Power powerAC[m]=vAC.*iAC "AC power";
  SI.Power powerTotalAC=sum(powerAC) "AC total power";
end ACtwoPlug;
