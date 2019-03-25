within Modelica.Electrical.Analog.Examples.Utilities;
model InverseInductor "Input/output block of an inverse inductor model"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Inductance L(min=0)=1 "Inductance";
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true, start=0), L=
        L) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,0})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor currentToVoltage(
      use_pder=false, use_fder=true)
    annotation (Placement(transformation(extent={{-10,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.RealInput i(unit="A")
    "Current to drive the Inductor"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput di(unit="A/s")
    "Current to drive the Inductor"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="V")
    "Voltage needed to drive the oneport according to i, di"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
equation

  connect(currentToVoltage.pin_p, inductor.p)
    annotation (Line(points={{-18,8},{0,8},{0,10},{20,10}}, color={0,0,255}));
  connect(ground.p, inductor.n)
    annotation (Line(points={{0,-10},{20,-10}}, color={0,0,255}));
  connect(currentToVoltage.pin_n, ground.p) annotation (Line(points={{-18,-8},{0,
          -8},{0,-10}},             color={0,0,255}));
  connect(i, currentToVoltage.f) annotation (Line(points={{-120,-80},{-40,-80},{
          -40,-8},{-23,-8}}, color={0,0,127}));
  connect(di, currentToVoltage.fder) annotation (Line(points={{-120,-30},{-60,-30},
          {-60,-5},{-23,-5}}, color={0,0,127}));
  connect(currentToVoltage.p, v) annotation (Line(points={{-23,8},{-40,8},{-40,80},
          {-110,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{0,-62},{96,-94}},
                lineColor={135,135,135},
                textString="to FMU"),Text(
                extent={{-94,96},{-10,66}},
                horizontalAlignment=TextAlignment.Left,
          textString="v"),        Text(
                extent={{-94,-12},{-10,-42}},
                horizontalAlignment=TextAlignment.Left,
          textString="di"),     Text(
                extent={{-150,-110},{150,-140}},
          textString="L=%L"),      Bitmap(extent={{-58,-42},{98,48}},
            fileName="modelica://Modelica/Resources/Images/Electrical/Analog/InverseInductor.png"),
          Text( extent={{-90,-64},{-6,-94}},
                horizontalAlignment=TextAlignment.Left,
          textString="i")}));
end InverseInductor;
