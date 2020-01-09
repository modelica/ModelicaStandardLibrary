within Modelica.Electrical.Machines.Examples.Transformers;
model Rectifier12pulse "12-pulse rectifier with 2 transformers"
  extends Machines.Examples.Transformers.Rectifier6pulse(RL=0.2);
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode3(
    m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m),
    Vknee=fill(0, m)) annotation (Placement(transformation(
        origin={-20,-20},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star3(m=m) annotation (
      Placement(transformation(extent={{-10,0},{10,-20}})));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode4(
    m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m),
    Vknee=fill(0, m)) annotation (Placement(transformation(
        origin={-20,-60},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star4(m=m) annotation (
      Placement(transformation(extent={{-10,-60},{10,-80}})));
  Machines.BasicMachines.Transformers.Dd.Dd00 transformer2(
    n=transformerData2.n,
    R1=transformerData2.R1,
    L1sigma=transformerData2.L1sigma,
    R2=transformerData2.R2,
    L2sigma=transformerData2.L2sigma,
    T1Ref=293.15,
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T2Ref=293.15,
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T1Operational=293.15,
    T2Operational=293.15)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));

  parameter Machines.Utilities.TransformerData transformerData2(
    C1=Modelica.Utilities.Strings.substring(
        transformer2.VectorGroup,
        1,
        1),
    C2=Modelica.Utilities.Strings.substring(
        transformer2.VectorGroup,
        2,
        2),
    f=50,
    V1=100,
    V2=100,
    SNominal=30E3,
    v_sc=0.05,
    P_sc=300) "Data of transformer 2"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
initial equation
  transformer2.core.plug_p1.pin[1:3].i = zeros(3);
equation
  connect(diode3.plug_n, star3.plug_p)
    annotation (Line(points={{-20,-10},{-10,-10}}, color={0,0,255}));
  connect(diode4.plug_p, star4.plug_p)
    annotation (Line(points={{-20,-70},{-10,-70}}, color={0,0,255}));
  connect(diode4.plug_n, diode3.plug_p)
    annotation (Line(points={{-20,-50},{-20,-30}}, color={0,0,255}));
  connect(star4.pin_n, cDC2.n) annotation (Line(points={{10,-70},{70,-70},
          {70,-30}}, color={0,0,255}));
  connect(star3.pin_n, cDC1.p) annotation (Line(points={{10,-10},{18,-10},
          {18,-8},{22,-8},{22,-10},{30,-10},{30,70},{70,70},{70,30}}, color={0,0,255}));
  connect(transformer2.plug2, diode4.plug_n) annotation (Line(
      points={{-30,-40},{-20,-40},{-20,-50}}, color={0,0,255}));
  connect(transformer2.plug1, currentSensor.plug_n) annotation (Line(
      points={{-50,-40},{-60,-40},{-60,0}}, color={0,0,255}));
  annotation (Documentation(info="<html>
Test example with polyphase components:<br>
Star-connected voltage source feeds via two transformers (Dd0 and Dy1) two diode bridge rectifiers with a single DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden,
neglecting initial transient.
</html>"),
     experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
end Rectifier12pulse;
