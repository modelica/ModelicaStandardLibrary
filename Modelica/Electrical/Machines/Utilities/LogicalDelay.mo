within Modelica.Electrical.Machines.Utilities;
block LogicalDelay "Delay boolean signal"
  extends Blocks.Icons.BooleanBlock;
  parameter SIunits.Time delayTime(final min=0)=0 "Time delay";
  Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.BooleanOutput y1
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Blocks.Interfaces.BooleanOutput y2
  annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
protected
  discrete SIunits.Time tSwitch;
initial equation
  tSwitch = time - 2*delayTime;
equation
  when {u, not u} then
    tSwitch = time;
  end when;
  y1 = if u then true else not (time >= tSwitch + delayTime);
  y2 = if not u then false else (time >= tSwitch + delayTime);
  annotation (Documentation(info="<html>
<p>
When input <code>u</code> gets true, output <code>y1</code> gets immediately true, whereas output <code>y2</code> gets true after <code>delayTime</code>.
</p>
<p>
When input <code>u</code> gets false, output <code>y1</code> gets false after <code>delayTime</code>, whereas output <code>y2</code> gets immediately false.
</p>
</html>"));
end LogicalDelay;
