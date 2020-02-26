within Modelica.Electrical.Analog.Semiconductors;
model SimpleTriac "Simple triac, based on Semiconductors.Thyristor model"
  parameter SI.Voltage VDRM(final min=0) = 100
    "Forward breakthrough voltage";
  parameter SI.Voltage VRRM(final min=0) = 100
    "Reverse breakthrough voltage";
  parameter SI.Current IDRM=0.1 "Saturation current";
  parameter SI.Voltage VTM= 1.7 "Conducting voltage";
  parameter SI.Current IH=6e-3 "Holding current";
  parameter SI.Current ITM= 25 "Conducting current";

  parameter SI.Voltage VGT= 0.7 "Gate trigger voltage";
  parameter SI.Current IGT= 5e-3 "Gate trigger current";

  parameter SI.Time TON = 1e-6 "Switch on time";
  parameter SI.Time TOFF = 15e-6 "Switch off time";
  parameter SI.Voltage Vt=0.04
    "Voltage equivalent of temperature (kT/qn)";
  parameter Real Nbv=0.74 "Reverse Breakthrough emission coefficient";

  Modelica.Electrical.Analog.Interfaces.NegativePin n "Cathode"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "Anode"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin g "Gate"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor(VDRM=VDRM, VRRM=VRRM, IDRM=IDRM, VTM=VTM, IH=IH, ITM=ITM, VGT=VGT, IGT=IGT, TON=TON, TOFF=TOFF, Vt=Vt, Nbv=Nbv, useHeatPort=useHeatPort, T=T)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor1(VDRM=VDRM, VRRM=VRRM, IDRM=IDRM, VTM=VTM, IH=IH, ITM=ITM, VGT=VGT, IGT=IGT, TON=TON, TOFF=TOFF, Vt=Vt, Nbv=Nbv, useHeatPort=useHeatPort, T=T)
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,-40})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Vknee=0)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1(Vknee=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-40,-60})));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
equation
  if useHeatPort then
   connect(heatPort, thyristor.heatPort);
   connect(heatPort, thyristor1.heatPort);
 end if;
  connect(thyristor.Anode, n) annotation (Line(
      points={{-20,40},{-30,40},{-30,0},{-100,0}}, color={0,0,255}));
  connect(thyristor1.Anode, p) annotation (Line(
      points={{0,-40},{10,-40},{10,0},{100,0}}, color={0,0,255}));
  connect(thyristor1.Anode, thyristor.Cathode) annotation (Line(
      points={{0,-40},{10,-40},{10,40},{0,40}}, color={0,0,255}));
  connect(thyristor1.Cathode, thyristor.Anode) annotation (Line(
      points={{-20,-40},{-30,-40},{-30,40},{-20,40}}, color={0,0,255}));
  connect(thyristor.Gate, idealDiode.n) annotation (Line(
      points={{0,50},{0,60},{-30,60}}, color={0,0,255}));
  connect(idealDiode.p, g) annotation (Line(
      points={{-50,60},{-60,60},{-60,-100},{-100,-100}}, color={0,0,255}));
  connect(idealDiode1.n, thyristor1.Gate) annotation (Line(
      points={{-30,-60},{-20,-60},{-20,-50}}, color={0,0,255}));
  connect(idealDiode1.p, g) annotation (Line(
      points={{-50,-60},{-60,-60},{-60,-100},{-100,-100}}, color={0,0,255}));
  LossPower = p.i*p.v + n.i*n.v + g.i*g.v;
  annotation (defaultComponentName="triac",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-40,-70},{-40,70}}, color={0,0,255}),
        Line(points={{40,-72},{40,70}}, color={0,0,255}),
        Polygon(points={{-40,-70},{40,-30},{-40,10},{-40,-70}},
                                                             lineColor={0,0,
              255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{40,-10},{-40,30},{40,70},{40,-10}}, lineColor={0,0,
              255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,0},{-90,0}}, color={0,0,255}),
        Line(points={{90,0},{40,0}}, color={0,0,255}),
        Line(points={{-100,-100},{-100,-60},{-40,-30}},
                                                    color={0,0,255})}),
    Documentation(info="<html>
<p>This is a simple TRIAC model based on the extended thyristor model Modelica.Electrical.Analog.Semiconductors.Thyristor.
<br>Two thyristors are contrarily connected in parallel, whereas each transistor is connected with a diode.
<br>Further information regarding the electrical component TRIAC can be detected in documentation of the ideal TRIAC model.
<br>As an additional information: this model is based on the Modelica.Electrical.Analog.Semiconductors.Thyristor.</p>
<p><strong>Attention:</strong> The model seems to be very sensitive with respect to the choice of some parameters (e.g., VDRM, VRRM). This is caused by the thyristor model. Further investigations are necessary.</p>
</html>",
   revisions="<html>
<ul>
<li><em>November 25, 2009   </em><br>
       by Susann Wolf<br><br>
       </li>
</ul>
</html>"));
end SimpleTriac;
