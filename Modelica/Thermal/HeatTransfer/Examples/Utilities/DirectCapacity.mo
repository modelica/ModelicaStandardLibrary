within Modelica.Thermal.HeatTransfer.Examples.Utilities;
model DirectCapacity
  "Input/output block of a direct heatCapacity model"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.HeatCapacity C(min=0)=1 "HeatCapacity";
  HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C, T(fixed=true, start=
          293.15))
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  HeatTransfer.Sources.PrescribedHeatFlow forceSource
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowDrive(unit="W")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  HeatTransfer.Components.GeneralHeatFlowToTemperatureAdaptor heatFlowToTemperature(use_pder=
        true) annotation (Placement(transformation(extent={{12,-10},{28,10}})));
  Modelica.Blocks.Interfaces.RealOutput T(unit="K", displayUnit="degC")
    "Heat capacity changes temperature T due to heat flow Q_flow"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput derT(unit="K/s")
    "Heat capacity changes temperature T due to heat flow Q_flow"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")
    "Heat flow to the heat capacity"
    annotation (Placement(transformation(extent={{140,-100},{100,-60}})));
equation
  connect(heatFlowToTemperature.f, Q_flow) annotation (Line(points={{22.4,-8},{60,-8},{60,-80},{120,-80}},
                                   color={0,0,127}));
  connect(heatFlowToTemperature.p, T) annotation (Line(points={{22.4,8},{60,8},{60,80},{110,80}},
                            color={0,0,127}));
  connect(heatFlowToTemperature.pder, derT) annotation (Line(points={{22.4,5},{80,5},{80,30},{110,30}},
                                color={0,0,127}));
  connect(heatCapacitor.port,heatFlowToTemperature. heatPort)
    annotation (Line(points={{-10,0},{18.4,0}}, color={191,0,0}));
  connect(Q_flowDrive, forceSource.Q_flow)
    annotation (Line(points={{-120,0},{-50,0}}, color={0,0,127}));
  connect(heatCapacitor.port, forceSource.port)
    annotation (Line(points={{-10,0},{-30,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{-84,-58},{24,-90}},
                textColor={135,135,135},
                textString="to FMU"),Text(
                extent={{8,96},{92,66}},
                horizontalAlignment=TextAlignment.Right,
          textString="T"),                               Text(
                extent={{10,46},{94,16}},
                horizontalAlignment=TextAlignment.Right,
          textString="dT"),     Text(
                extent={{-150,-110},{150,-140}},
          textString="C=%C"),      Bitmap(extent={{-96,-42},{64,54}},
            fileName="modelica://Modelica/Resources/Images/Thermal/HeatTransfer/DirectCapacity.png"),
          Text( extent={{10,-60},{94,-90}},
                horizontalAlignment=TextAlignment.Right,
          textString="Q_flow")}));
end DirectCapacity;
