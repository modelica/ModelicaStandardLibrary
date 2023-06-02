within Modelica.Electrical.PowerConverters.DCDC;
model ChopperStepUp "Step up chopper"
  import Modelica.Constants.pi;
  extends Icons.Converter;
  parameter SI.Resistance RonTransistor=1e-05
    "Transistor closed resistance";
  parameter SI.Conductance GoffTransistor=1e-05
    "Transistor opened conductance";
  parameter SI.Voltage VkneeTransistor=0
    "Transistor threshold voltage";
  parameter SI.Resistance RonDiode(final min=0) = 1e-05
    "Closed diode resistance";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05
    "Opened diode conductance";
  parameter SI.Voltage VkneeDiode(final min=0) = 0
    "Diode forward threshold voltage";
  extends PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends PowerConverters.Interfaces.DCDC.DCtwoPin2;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  extends Interfaces.Enable.Enable1;
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistor(
    useHeatPort=useHeatPort,
    Ron=RonTransistor,
    Goff=GoffTransistor,
    Vknee=VkneeTransistor) "Switching transistor" annotation (Placement(
        transformation(
        origin={-40,0},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode(
    Ron=RonDiode,
    Goff=GoffDiode,
    Vknee=VkneeDiode,
    useHeatPort=useHeatPort) "Free wheeling diode" annotation (Placement(
        transformation(
        origin={0,60},
        extent={{-10,-10},{10,10}})));
equation
  if not useHeatPort then
    LossPower = diode.LossPower + transistor.LossPower;
  end if;
  connect(andCondition_p.y, transistor.fire) annotation (Line(points={{-60,
          -69},{-60,-10},{-52,-10}}, color={255,0,255}));
  connect(dc_p1, transistor.p) annotation (Line(points={{-100,60},{-40,60},
          {-40,10}}, color={0,0,255}));
  connect(dc_n1, transistor.n) annotation (Line(points={{-100,-60},{-40,-60},
          {-40,-10}}, color={0,0,255}));
  connect(dc_p1, diode.p)
    annotation (Line(points={{-100,60},{-10,60}}, color={0,0,255}));
  connect(diode.n, dc_p2)
    annotation (Line(points={{10,60},{100,60}}, color={0,0,255}));
  connect(dc_n1, dc_n2)
    annotation (Line(points={{-100,-60},{100,-60}}, color={0,0,255}));
  connect(transistor.heatPort, heatPort) annotation (Line(points={{-30,
          -4.44089e-16},{-16,-4.44089e-16},{-16,0},{0,0},{0,-100}}, color={
          191,0,0}));
  connect(heatPort, diode.heatPort)
    annotation (Line(points={{0,-100},{0,50}}, color={191,0,0}));
  annotation (defaultComponentName="dcdc",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,70},{0,50}},
          textColor={0,0,255},
          textString="DC in"),
        Text(
          extent={{0,-50},{100,-70}},
          textColor={0,0,255},
          textString="DC out"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-62,32},{-58,28}}, lineColor={0,0,255}),
        Ellipse(extent={{-38,14},{-10,-14}},lineColor={0,0,255}),
        Line(points={{-60,30},{60,30}}, color={0,0,255}),
        Ellipse(extent={{-22,32},{-18,28}},
                                          lineColor={0,0,255}),
        Line(points={{0,10},{0,-10}},   color={255,0,255},
          origin={-40,0},
          rotation=90),
        Line(points={{-20,30},{-20,10}},color={0,0,255}),
        Line(points={{-10,0},{10,0}},  color={0,0,255},
          origin={30,30},
          rotation=270),
        Polygon(points={{0,10},{-10,-10},{10,-10},{0,10}},  lineColor={0,0,
              255},
          origin={20,30},
          rotation=270),
        Ellipse(extent={{58,-28},{62,-32}}, lineColor={0,0,255}),
        Line(points={{-60,-30},{60,-30}}, color={0,0,255}),
        Ellipse(extent={{58,32},{62,28}}, lineColor={0,0,255}),
        Ellipse(extent={{-22,-28},{-18,-32}},
                                            lineColor={0,0,255}),
        Ellipse(extent={{-62,-28},{-58,-32}}, lineColor={0,0,255}),
        Polygon(
          points={{3,3},{-3,-1},{-1,-3},{3,3}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={-23,-7},
          rotation=270),
        Line(points={{-10,0},{10,0}},    color={0,0,255},
          origin={-30,0},
          rotation=90),
        Line(points={{-20,10},{-30,0},{-20,-10}}, color={0,0,255}),
        Line(points={{-20,-10},{-20,-30}},
                                        color={0,0,255})}),
    Documentation(info="<html>
<p>
This is a conventional step up chopper (boost converter) model. It consists of a transistor and free wheeling diode.
</p>
</html>"));
end ChopperStepUp;
