within Modelica.Electrical.Analog.Examples.Utilities;
model DirectCapacitor "Input/output block of a direct capacitor model"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Capacitance C(min=0)=1 "Capacitance";
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=C, v(fixed=
          true, start=0))                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
  Modelica.Electrical.Analog.Sources.SignalCurrent currentSource annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  Modelica.Blocks.Interfaces.RealInput iDrive(unit="A")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor currentToVoltage(
      use_pder=true, use_fder=false)
    annotation (Placement(transformation(extent={{12,-10},{28,10}})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="V")
    "Capacitor changes voltage due to current"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput dv(unit="V/s")
    "Capacitor changes voltage due to current"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealInput i(unit="A") "Current to the capacitor"
    annotation (Placement(transformation(extent={{140,-100},{100,-60}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
equation
  connect(currentToVoltage.f, i) annotation (Line(points={{22.4,-8},{60,-8},{60,
          -80},{120,-80}}, color={0,0,127}));
  connect(currentToVoltage.p, v) annotation (Line(points={{22.4,8},{60,8},{60,80},
          {110,80}}, color={0,0,127}));
  connect(currentToVoltage.pder, dv) annotation (Line(points={{22.4,5},{80,5},{80,
          30},{110,30}}, color={0,0,127}));
  connect(iDrive, currentSource.i)
    annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
  connect(capacitor.p, currentToVoltage.pin_p) annotation (Line(points={{
          1.77636e-015,10},{10,10},{10,8},{18.4,8}},
                                  color={0,0,255}));
  connect(capacitor.n, currentToVoltage.pin_n) annotation (Line(points={{
          -1.77636e-015,-10},{10,-10},{10,-8},{18.4,-8}},
                                     color={0,0,255}));
  connect(currentSource.p, ground.p)
    annotation (Line(points={{-40,-10},{-20,-10}}, color={0,0,255}));
  connect(ground.p, capacitor.n)
    annotation (Line(points={{-20,-10},{-1.77636e-015,-10}},
                                                   color={0,0,255}));
  connect(currentSource.n, capacitor.p)
    annotation (Line(points={{-40,10},{1.77636e-015,10}},
                                                 color={0,0,255}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{-84,-58},{24,-90}},
                lineColor={135,135,135},
                textString="to FMU"),Text(
                extent={{8,96},{92,66}},
                horizontalAlignment=TextAlignment.Right,
          textString="v"),                               Text(
                extent={{10,46},{94,16}},
                horizontalAlignment=TextAlignment.Right,
          textString="dv"),     Text(
                extent={{-150,-110},{150,-140}},
          textString="C=%C"),      Bitmap(extent={{-96,-42},{64,54}},
            fileName="modelica://Modelica/Resources/Images/Electrical/Analog/DirectCapacitor.png"),
          Text( extent={{10,-60},{94,-90}},
                horizontalAlignment=TextAlignment.Right,
          textString="i")}));
end DirectCapacitor;
