within Modelica.Electrical.PowerConverters.Interfaces.DCAC;
partial model ACplug "AC polyphase plug"
  parameter Integer m(final min=3) = 3 "Number of phases";
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m)
    "AC output"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.SIunits.Voltage vAC[m]=ac.pin[:].v "AC potential";
  Modelica.SIunits.Current iAC[m]=ac.pin[:].i "AC current";
  Modelica.SIunits.Power powerAC[m]=vAC.*iAC "AC power";
  Modelica.SIunits.Power powerTotalAC=sum(powerAC) "AC total power";
end ACplug;
