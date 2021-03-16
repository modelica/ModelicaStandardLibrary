within Modelica.Electrical.PowerConverters.DCDC;
model ChopperBuckBost "Bidirectional chopper"
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  parameter Modelica.Units.SI.Resistance RonTransistor=1e-05
    "Transistor closed resistance";
  parameter Modelica.Units.SI.Conductance GoffTransistor=1e-05
    "Transistor opened conductance";
  parameter Modelica.Units.SI.Voltage VkneeTransistor=0
    "Transistor threshold voltage";
  parameter Modelica.Units.SI.Resistance RonDiode=1e-05
    "Diode closed resistance";
  parameter Modelica.Units.SI.Conductance GoffDiode=1e-05
    "Diode opened conductance";
  parameter Modelica.Units.SI.Voltage VkneeDiode=0
    "Diode threshold voltage";
  extends Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable2;
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorLS(
    useHeatPort=useHeatPort,
    Ron=RonTransistor,
    Goff=GoffTransistor,
    Vknee=VkneeTransistor) "Switching transistor low side" annotation (
      Placement(transformation(
        origin={-40,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeLS(
    useHeatPort=useHeatPort,
    Ron=RonDiode,
    Goff=GoffDiode,
    Vknee=VkneeDiode) "Free wheeling diode low side" annotation (Placement(
        transformation(
        origin={-20,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorHS(
    useHeatPort=useHeatPort,
    Ron=RonTransistor,
    Goff=GoffTransistor,
    Vknee=VkneeTransistor) "Switching transistor high side" annotation (
      Placement(transformation(
        origin={50,60},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeHS(
    useHeatPort=useHeatPort,
    Ron=RonDiode,
    Goff=GoffDiode,
    Vknee=VkneeDiode) "Free wheeling diode high side" annotation (Placement(
        transformation(
        origin={50,80},
        extent={{-10,10},{10,-10}},
        rotation=0)));
equation
  if not useHeatPort then
    LossPower = diodeLS.LossPower + transistorLS.LossPower
              + diodeHS.LossPower + transistorHS.LossPower;
  end if;
  connect(transistorLS.p, diodeLS.n)
    annotation (Line(points={{-40,10},{-20,10}}, color={0,0,255}));
  connect(dc_n1, transistorLS.n) annotation (Line(points={{-100,-60},{-40,-60},
          {-40,-10}},color={0,0,255}));
  connect(transistorLS.n, diodeLS.p)
    annotation (Line(points={{-40,-10},{-20,-10}}, color={0,0,255}));
  connect(diodeHS.p, transistorHS.n)
    annotation (Line(points={{40,80},{40,60}}, color={0,0,255}));
  connect(diodeHS.n, transistorHS.p)
    annotation (Line(points={{60,80},{60,60}}, color={0,0,255}));
  connect(transistorHS.p, dc_p2)
    annotation (Line(points={{60,60},{100,60}}, color={0,0,255}));
  connect(dc_n1, dc_n2)
    annotation (Line(points={{-100,-60},{100,-60}}, color={0,0,255}));
  connect(diodeLS.heatPort, heatPort) annotation (Line(points={{-10,5.55112e-16},
          {-10,-40},{0,-40},{0,-100}},
                             color={191,0,0}));
  connect(transistorLS.heatPort, heatPort) annotation (Line(points={{-30,-1.77636e-15},
          {-30,-40},{0,-40},{0,-100}},
                                  color={191,0,0}));
  connect(diodeHS.heatPort, heatPort)
    annotation (Line(points={{50,90},{0,90},{0,-100}}, color={191,0,0}));
  connect(transistorHS.heatPort, heatPort)
    annotation (Line(points={{50,70},{0,70},{0,-100}}, color={191,0,0}));
  connect(dc_p1, transistorLS.p)
    annotation (Line(points={{-100,60},{-40,60},{-40,10}}, color={0,0,255}));
  connect(transistorHS.n, dc_p1)
    annotation (Line(points={{40,60},{-100,60}}, color={0,0,255}));
  connect(andCondition_n.y, transistorHS.fire) annotation (Line(points={{60,-69},
          {60,40},{40,40},{40,48}}, color={255,0,255}));
  connect(andCondition_p.y, transistorLS.fire) annotation (Line(points={{-60,-69},
          {-60,-10},{-52,-10}}, color={255,0,255}));
  annotation (defaultComponentName="dcdc",
    Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                   Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},{-10,
              -8},{-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,-24},{-30,
              8},{-20,-8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},{-30,24},{-20,
              24},{-20,60},{-20,24},{0,4}},
                                   color={28,108,200}), Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
          color={28,108,200},
          origin={40,55},
          rotation=360),
        Line(points={{-90,-60},{90,-60}}, color={28,108,200}),
        Text(
          extent={{-150,148},{150,108}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This is a bidirectional buck / boost - converter with 2 transistors and 2 freewheeling diodes.
</p>
</html>"));
end ChopperBuckBost;
