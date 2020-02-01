within Modelica.Mechanics.Rotational.Components;
model IdealGear "Ideal gear without inertia"
  extends Modelica.Mechanics.Rotational.Icons.Gear;
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  parameter Real ratio(start=1)
    "Transmission ratio (flange_a.phi/flange_b.phi)";
  SI.Angle phi_a
    "Angle between left shaft flange and support";
  SI.Angle phi_b
    "Angle between right shaft flange and support";

equation
  phi_a = flange_a.phi - phi_support;
  phi_b = flange_b.phi - phi_support;
  phi_a = ratio*phi_b;
  0 = ratio*flange_a.tau + flange_b.tau;
  annotation (
    Documentation(info="<html>
<p>
This element characterizes any type of gear box which is fixed in the
ground and which has one driving shaft and one driven shaft.
The gear is <strong>ideal</strong>, i.e., it does not have inertia, elasticity, damping
or backlash. If these effects have to be considered, the gear has to be
connected to other elements in an appropriate way.
</p>

</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),
    graphics={
      Text(extent={{-153,145},{147,105}},
        textColor={0,0,255},
        textString="%name"),
      Text(extent={{-146,-49},{154,-79}},
        textString="ratio=%ratio")}));
end IdealGear;
