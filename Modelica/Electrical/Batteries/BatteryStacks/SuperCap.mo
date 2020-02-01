within Modelica.Electrical.Batteries.BatteryStacks;
model SuperCap "Simple model of a supercapacitor"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  SI.Current i = p.i "Current into the supercap";
  parameter SI.Voltage Vnom "Nominal voltage";
  parameter SI.Voltage V0=Vnom "Initial voltage";
  parameter SI.Capacitance C "Capacitance";
  parameter SI.ElectricCharge Qnom=C*Vnom "Nominal charge";
  parameter SI.Resistance Rs "Series resistance";
  parameter SI.Temperature T_ref=293.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha=0 "Temperature coefficient of resistance at T_ref";
  parameter SI.Current Idis=0 "Self-discharge current at nominal voltage"
    annotation(Evaluate=true);
  extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    final R=Rs,
    final T_ref=T_ref,
    final alpha=alpha,
    final useHeatPort=true)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Electrical.Analog.Basic.Conductor conductor(
    final G=Idis/Vnom,
    T_ref=293.15,
    final useHeatPort=true)
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(v(start=V0, fixed=true), final C=C)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
equation
  connect(p, resistor.p)
    annotation (Line(points={{-100,0},{-50,0}}, color={0,0,255}));
  connect(resistor.n, capacitor.p)
    annotation (Line(points={{-30,0},{30,0}}, color={0,0,255}));
  connect(capacitor.n, n)
    annotation (Line(points={{50,0},{100,0}}, color={0,0,255}));
  connect(capacitor.p, conductor.p)
    annotation (Line(points={{30,0},{30,-30},{30,-30}}, color={0,0,255}));
  connect(capacitor.n, conductor.n)
    annotation (Line(points={{50,0},{50,-30}}, color={0,0,255}));
  connect(internalHeatPort, conductor.heatPort) annotation (Line(points={{0,-80},
          {0,-60},{40,-60},{40,-40}}, color={191,0,0}));
  connect(internalHeatPort, resistor.heatPort) annotation (Line(points={{0,-80},
          {0,-60},{-40,-60},{-40,-10}}, color={191,0,0}));
  annotation (Icon(graphics={
        Text(
          extent={{-150,60},{150,100}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-150,-90},{150,-50}},
          textColor={0,0,0},
          textString="C=%C"),
        Rectangle(
          extent={{-20,40},{-10,-40}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,40},{20,-40}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-20,0}}, color={0,0,255}),
        Line(points={{20,0},{90,0}}, color={0,0,255})}), Documentation(info="<html>
<p>
This is a simple model of a supercapacitor, comprising:
</p>
<ul>
<li>an ideal capacitance</li>
<li>a series resistance</li>
<li>a self-discharge conductor</li>
</ul>
<h4>Note</h4>
<p>
There is no limit included against too high charging and too low discharging or even charging in the opposite direction.
</p>
</html>"));
end SuperCap;
