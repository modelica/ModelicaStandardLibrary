within Modelica.Electrical.Batteries.Utilities;
model CCCVcharger
  "Charger with constant current - constant voltage characteristic"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Modelica.SIunits.Current I "Constant charge current";
  parameter Modelica.SIunits.Time startTime=0 "Start time of charging";
  parameter Modelica.SIunits.Time rampTime=60 "Ramp up charging current";
  parameter Modelica.SIunits.Voltage Vend "End of charge voltage";
  Boolean CV(start=false, fixed=true) "Indicates CV charging";
equation
  CV=v>=Vend;
  if CV then
    v=Vend;
  else
    i = -I*(if time<startTime then 0 else min(1,(time - startTime)/rampTime));
  end if;
  annotation (defaultComponentName="cccvCharger",
    Icon(graphics={   Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        textColor={0,0,255}),
        Polygon(
          points={{20,80},{-50,-20},{0,-20},{-20,-80},{50,20},{0,20},{20,80}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Ideal charger switching from constant current to constant voltage characteristic.
</p>
</html>"));
end CCCVcharger;
