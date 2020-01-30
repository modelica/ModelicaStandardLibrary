within Modelica.Thermal.HeatTransfer.Examples;
model TwoMasses "Simple conduction demo"
  extends Modelica.Icons.Example;
  parameter SI.Temperature T_final_K(fixed=false)
    "Projected final temperature";
  HeatTransfer.Components.HeatCapacitor mass1(C=15, T(start=373.15, fixed=true))
    annotation (Placement(transformation(extent={{-100,20},{-40,80}})));
  HeatTransfer.Components.HeatCapacitor mass2(C=15, T(start=273.15, fixed=true))
    annotation (Placement(transformation(extent={{40,20},{100,80}})));
  HeatTransfer.Components.ThermalConductor conduction(G=10)
    annotation (Placement(transformation(extent={{-30,-20},{30,40}})));
  HeatTransfer.Celsius.TemperatureSensor Tsensor1
    annotation (Placement(transformation(extent={{-60,-80},{-20,-40}})));
  HeatTransfer.Celsius.TemperatureSensor Tsensor2
    annotation (Placement(transformation(extent={{60,-80},{20,-40}})));
equation
  connect(mass1.port, conduction.port_a) annotation (Line(points={{-70,20},
          {-70,10},{-30,10}}, color={191,0,0}));
  connect(conduction.port_b, mass2.port) annotation (Line(points={{30,10},{
          70,10},{70,20}}, color={191,0,0}));
  connect(mass1.port, Tsensor1.port) annotation (Line(points={{-70,20},{-70,
          -60},{-60,-60}}, color={191,0,0}));
  connect(mass2.port, Tsensor2.port) annotation (Line(points={{70,20},{70,
          -60},{60,-60}}, color={191,0,0}));
initial equation
  T_final_K = (mass1.T*mass1.C + mass2.T*mass2.C)/(mass1.C + mass2.C);
  annotation (Documentation(info="<html>
<p>
This example demonstrates the thermal response of two masses connected by
a conducting element. The two masses have the same heat capacity but different
initial temperatures (T1=100 [degC], T2= 0 [degC]). The mass with the higher
temperature will cool off while the mass with the lower temperature heats up.
They will each asymptotically approach the calculated temperature <strong>T_final_K</strong>
(<strong>T_final_degC</strong>) that results from dividing the total initial energy in the system by the sum
of the heat capacities of each element.
</p>
<p>
Simulate for 5 s and plot the variables<br>
mass1.T, mass2.T, T_final_K or<br>
Tsensor1.T, Tsensor2.T, T_final_degC
</p>
</html>"),
    experiment(StopTime=1.0, Interval=0.001));
end TwoMasses;
