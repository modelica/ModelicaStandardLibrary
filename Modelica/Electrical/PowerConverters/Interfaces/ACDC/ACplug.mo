within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model ACplug "AC polyphase plug"
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m)
    "AC input"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  SI.Voltage vAC[m]=ac.pin[:].v "AC potentials";
  SI.Current iAC[m]=ac.pin[:].i "AC currents";
  SI.Power powerAC[m]=vAC.*iAC "AC power";
  SI.Power powerTotalAC=sum(powerAC) "AC total power";
end ACplug;
