within Modelica.Electrical.Analog.Examples.Utilities;
model DirectInductor "Input/output block of a direct inductor model"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Inductance L(min=0)=1 "Inductance";
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true, start=0), L=
        L) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-20,10})));
  Modelica.Electrical.Analog.Sources.SignalVoltage voltageSource annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,0})));
  Modelica.Blocks.Interfaces.RealInput vDrive(unit="V")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor currentToVoltage(
      use_pder=false, use_fder=true)
    annotation (Placement(transformation(extent={{28,-10},{12,10}})));
  Modelica.Blocks.Interfaces.RealOutput i(unit="A")
    "Inductor changes current due to voltage"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput di(unit="A/s")
    "Inductor changes current due to voltage"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealInput v(unit="V") "Voltage to the inductor"
    annotation (Placement(transformation(extent={{140,60},{100,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
equation
  connect(vDrive,voltageSource. v)
    annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
  connect(voltageSource.n, ground.p)
    annotation (Line(points={{-40,-10},{-20,-10}}, color={0,0,255}));
  connect(voltageSource.p, inductor.p)
    annotation (Line(points={{-40,10},{-30,10}}, color={0,0,255}));
  connect(inductor.n, currentToVoltage.pin_p) annotation (Line(points={{-10,10},
          {0,10},{0,8},{18.4,8}}, color={0,0,255}));
  connect(ground.p, currentToVoltage.pin_n) annotation (Line(points={{-20,-10},{
          0,-10},{0,-8},{18.4,-8}}, color={0,0,255}));
  connect(currentToVoltage.p, v) annotation (Line(points={{22.4,8},{40,8},{40,80},
          {120,80}}, color={0,0,127}));
  connect(currentToVoltage.f, i) annotation (Line(points={{22.4,-8},{40,-8},{40,
          -80},{110,-80}}, color={0,0,127}));
  connect(currentToVoltage.fder, di) annotation (Line(points={{22.4,-5},{60,-5},
          {60,-30},{110,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{-84,-58},{24,-90}},
                lineColor={135,135,135},
                textString="to FMU"),Text(
                extent={{8,96},{92,66}},
                horizontalAlignment=TextAlignment.Right,
          textString="v"),                               Text(
                extent={{12,-10},{96,-40}},
                horizontalAlignment=TextAlignment.Right,
          textString="di"),     Text(
                extent={{-150,-110},{150,-140}},
          textString="L=%L"),      Bitmap(extent={{-96,-42},{64,54}},
            fileName="modelica://Modelica/Resources/Images/Electrical/Analog/DirectInductor.png"),
          Text( extent={{10,-60},{94,-90}},
                horizontalAlignment=TextAlignment.Right,
          textString="i")}));
end DirectInductor;
