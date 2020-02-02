within Modelica.Electrical.PowerConverters.Interfaces.DCAC;
partial model ACplug "AC polyphase plug"
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m)
    "AC output"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  SI.Voltage vAC[m]=ac.pin[:].v "AC potential";
  SI.Current iAC[m]=ac.pin[:].i "AC current";
  SI.Power powerAC[m]=vAC.*iAC "AC power";
  SI.Power powerTotalAC=sum(powerAC) "AC total power";
end ACplug;
