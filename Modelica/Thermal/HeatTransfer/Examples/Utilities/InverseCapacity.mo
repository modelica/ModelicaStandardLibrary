within Modelica.Thermal.HeatTransfer.Examples.Utilities;
model InverseCapacity
  "Input/output block of an inverse heatCapacity model"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.HeatCapacity C(min=0)=1 "HeatCapacity";
  HeatTransfer.Components.HeatCapacitor mass(C=C, T(fixed=true, start=293.15))
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  HeatTransfer.Components.GeneralTemperatureToHeatFlowAdaptor temperatureToHeatFlow
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealInput T(unit="K", displayUnit="degC")
    "Temperature to drive the heatCapacity"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput derT(unit="K/s")
    "Temperature to drive the heatCapacity"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W")
    "Heat flow needed to drive the heatPort according to T, derT"
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
equation

  connect(temperatureToHeatFlow.f, Q_flow) annotation (Line(points={{-23,-8},{-60,
          -8},{-60,-80},{-110,-80}}, color={0,0,127}));
  connect(temperatureToHeatFlow.p, T) annotation (Line(points={{-23,8},{-60,8},{
          -60,80},{-120,80}}, color={0,0,127}));
  connect(temperatureToHeatFlow.pder, derT) annotation (Line(points={{-23,5},{-80,
          5},{-80,30},{-120,30}}, color={0,0,127}));
  connect(temperatureToHeatFlow.heatPort, mass.port)
    annotation (Line(points={{-18,0},{0,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{0,-62},{96,-94}},
                textColor={135,135,135},
                textString="to FMU"),Text(
                extent={{-94,96},{-10,66}},
                horizontalAlignment=TextAlignment.Left,
          textString="T"),        Text(
                extent={{-94,46},{-10,16}},
                horizontalAlignment=TextAlignment.Left,
          textString="dT"),     Text(
                extent={{-150,-110},{150,-140}},
          textString="C=%C"),      Bitmap(extent={{-58,-42},{98,48}},
            fileName="modelica://Modelica/Resources/Images/Thermal/HeatTransfer/InverseCapacity.png"),
          Text( extent={{-90,-64},{-6,-94}},
                horizontalAlignment=TextAlignment.Left,
          textString="Q_flow")}));
end InverseCapacity;
