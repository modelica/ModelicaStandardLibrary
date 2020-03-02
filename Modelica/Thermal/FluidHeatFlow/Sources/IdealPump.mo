within Modelica.Thermal.FluidHeatFlow.Sources;
model IdealPump "Model of an ideal pump"

  extends FluidHeatFlow.BaseClasses.TwoPort(final tapT=1);
  parameter SI.AngularVelocity wNominal(start=1, displayUnit="rev/min")
    "Nominal speed"
      annotation(Dialog(group="Pump characteristic"));
  parameter SI.Pressure dp0(start=2)
    "Max. pressure increase @ V_flow=0"
      annotation(Dialog(group="Pump characteristic"));
  parameter SI.VolumeFlowRate V_flow0(start=2)
    "Max. volume flow rate @ dp=0"
      annotation(Dialog(group="Pump characteristic"));
  SI.AngularVelocity w=der(flange_a.phi) "Speed";
protected
  SI.Pressure dp1;
  SI.VolumeFlowRate V_flow1;
public
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
equation
  // pump characteristic
  dp1 = dp0*sign(w/wNominal)*(w/wNominal)^2;
  V_flow1 = V_flow0*(w/wNominal);
  if noEvent(abs(w)<Modelica.Constants.small) then
    dp = 0;
    flange_a.tau = 0;
  else
    dp = -dp1*(1 - V_flow/V_flow1);
    flange_a.tau*w = -dp*V_flow;
  end if;
  // no energy exchange with medium
  Q_flow = 0;
annotation (Documentation(info="<html>
<p>
Simple fan resp. pump where characteristic is dependent on shaft's speed, <br>
torque * speed = pressure increase * volume flow (without losses)<br>
Pressure increase versus volume flow is defined by a linear function,
from dp0(V_flow=0) to V_flow0(dp=0).<br>
The axis intersections vary with speed as follows:
</p>
<ul>
<li>dp prop. speed^2</li>
<li>V_flow prop. speed</li>
</ul>
<p>
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to negligence of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by BaseClasses.TwoPort.
</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,90}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-10,-40},{10,-100}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={175,175,175}),
        Polygon(
          points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255})}));
end IdealPump;
