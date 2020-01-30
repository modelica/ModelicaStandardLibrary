within Modelica.Electrical.Batteries.Utilities;
block BusTranscription "Transcribe bus signals"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer Ns(final min = 1) = 1 "Number of series connected cells";
  parameter Integer Np(final min = 1) = 1 "Number of parallel connected cells";
  Modelica.Electrical.Batteries.Interfaces.StackBus stackBus(Np=Np, Ns=Ns)
    "Stack bus" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,0})));
  Modelica.Electrical.Batteries.Interfaces.StackBusArrays stackBusArrays(Np=Np,
      Ns=Ns) "Stack bus with signal arrays" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0})));
protected
  Modelica.Blocks.Math.Gain gainV[Ns,Np](each k=1)
    annotation (Placement(transformation(extent={{-8,70},{12,90}})));
  Modelica.Blocks.Math.Gain gainI[Ns,Np](each k=1)
    annotation (Placement(transformation(extent={{-8,40},{12,60}})));
  Modelica.Blocks.Math.Gain gainSOC[Ns,Np](each k=1)
    annotation (Placement(transformation(extent={{-8,10},{12,30}})));
  Modelica.Blocks.Math.Gain gainP[Ns,Np](each k=1)
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
  Modelica.Blocks.Math.Gain gainLosses[Ns,Np](each k=1)
    annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
  Modelica.Blocks.Math.Gain gainT[Ns,Np](each k=1)
    annotation (Placement(transformation(extent={{-8,-90},{12,-70}})));
equation
  connect(gainV.y, stackBusArrays.v) annotation (Line(points={{13,80},{80,80},{80,
          -0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(gainI.y, stackBusArrays.i) annotation (Line(points={{13,50},{60,50},{60,
          -0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(gainSOC.y, stackBusArrays.soc) annotation (Line(points={{13,20},{40,20},
          {40,-0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(gainP.y, stackBusArrays.power) annotation (Line(points={{13,-20},{40,-20},
          {40,-0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(gainLosses.y, stackBusArrays.lossPower) annotation (Line(points={{13,-50},
          {60,-50},{60,-0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(gainT.y, stackBusArrays.T) annotation (Line(points={{13,-80},{80,-80},
          {80,-0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(gainV.u, stackBus.cellBus.v) annotation (Line(points={{-10,80},{
          -80,80},{-80,0.1},{-100.1,0.1}}, color={0,0,127}));
  connect(gainI.u, stackBus.cellBus.i) annotation (Line(points={{-10,50},{
          -60,50},{-60,0.1},{-100.1,0.1}}, color={0,0,127}));
  connect(gainSOC.u, stackBus.cellBus.soc) annotation (Line(points={{-10,20},
          {-40,20},{-40,0.1},{-100.1,0.1}}, color={0,0,127}));
  connect(gainP.u, stackBus.cellBus.power) annotation (Line(points={{-10,-20},
          {-40,-20},{-40,0.1},{-100.1,0.1}}, color={0,0,127}));
  connect(gainLosses.u, stackBus.cellBus.lossPower) annotation (Line(points={
          {-10,-50},{-60,-50},{-60,0.1},{-100.1,0.1}}, color={0,0,127}));
  connect(gainT.u, stackBus.cellBus.T) annotation (Line(points={{-10,-80},
          {-80,-80},{-80,0.1},{-100.1,0.1}}, color={0,0,127}));
  annotation (Icon(graphics={Polygon(
          points={{-80,0},{-40,20},{-40,8},{100,8},{100,-10},{-40,-10},{-40,-20},
              {-80,0}},
          lineColor={0,0,0},
          origin={10,0},
          rotation=180,
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,42},{100,22}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString=" cellBus[Ns,Np].v"),
        Text(
          extent={{-100,-20},{100,-40}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Right,
          textString="v[Ns,Np] ")}),   Documentation(info="<html>
<p>
Transfers the information from the <a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.StackBus\">stackBus</a> to the <a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.StackBusArrays\">stackBusArrays</a>.
</p>
</html>"));
end BusTranscription;
