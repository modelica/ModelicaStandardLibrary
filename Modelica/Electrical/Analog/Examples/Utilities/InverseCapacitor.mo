within Modelica.Electrical.Analog.Examples.Utilities;
model InverseCapacitor "Input/output block of an inverse capacitor model"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Capacitance C(min=0)=1 "Capacitance";
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=C, v(fixed=
          true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,0})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor voltageToCurrent(
      use_fder=false)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealInput v(unit="V")
    "Voltage to drive the Capacitor"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput dv(unit="V/s")
    "Voltage to drive the Capacitor"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealOutput i(unit="A")
    "Current needed to drive the oneport according to v, dv"
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
equation

  connect(voltageToCurrent.f, i) annotation (Line(points={{-23,-8},{-60,
          -8},{-60,-80},{-110,-80}}, color={0,0,127}));
  connect(voltageToCurrent.p, v) annotation (Line(points={{-23,8},{-60,
          8},{-60,80},{-120,80}}, color={0,0,127}));
  connect(voltageToCurrent.pder, dv) annotation (Line(points={{-23,5},
          {-80,5},{-80,30},{-120,30}}, color={0,0,127}));
  connect(voltageToCurrent.pin_p, capacitor.p) annotation (Line(
        points={{-18,8},{0,8},{0,10},{20,10}}, color={0,0,255}));
  connect(ground.p, capacitor.n)
    annotation (Line(points={{0,-10},{20,-10}}, color={0,0,255}));
  connect(voltageToCurrent.pin_n, ground.p) annotation (Line(points={
          {-18,-8},{0,-8},{0,-10}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{0,-62},{96,-94}},
                lineColor={135,135,135},
                textString="to FMU"),Text(
                extent={{-94,96},{-10,66}},
                horizontalAlignment=TextAlignment.Left,
          textString="v"),        Text(
                extent={{-94,46},{-10,16}},
                horizontalAlignment=TextAlignment.Left,
          textString="dv"),     Text(
                extent={{-150,-110},{150,-140}},
          textString="C=%C"),      Bitmap(extent={{-58,-42},{98,48}},
            fileName="modelica://Modelica/Resources/Images/Electrical/Analog/InverseCapacitor.png"),
          Text( extent={{-90,-64},{-6,-94}},
                horizontalAlignment=TextAlignment.Left,
          textString="i")}));
end InverseCapacitor;
