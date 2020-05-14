package ModelicaTestConversion4
  extends Modelica.Icons.ExamplesPackage;
  package Blocks
    extends Modelica.Icons.ExamplesPackage;
    model Issue813 "Conversion test for #813"
      extends Modelica.Icons.Example;
      block B
        output Real y;
        parameter Real p;
      equation
        y = p*time;
      end B;

      block B1
        extends Modelica.Blocks.Interfaces.BlockIcon;
        extends B(p=1);
      end B1;

      block B2
        extends Modelica.Blocks.Interfaces.BooleanBlockIcon;
        extends B(p=2);
      end B2;

      block B3
        extends Modelica.Blocks.Interfaces.DiscreteBlockIcon;
        extends B(p=3);
      end B3;

      block B4
        extends Modelica.Blocks.Interfaces.IntegerBlockIcon;
        extends B(p=4);
      end B4;

      block B5
        extends Modelica.Blocks.Interfaces.partialBooleanBlockIcon;
        extends B(p=5);
      end B5;
      B1 b1;
      B2 b2;
      B3 b3;
      B4 b4;
      B5 b5;
      Modelica.Blocks.Interfaces.Adaptors.SendReal sendReal;
      Modelica.Blocks.Interfaces.Adaptors.ReceiveReal receiveReal;
      Modelica.Blocks.Sources.RealExpression realExpression;
      Modelica.Blocks.Interfaces.Adaptors.SendBoolean sendBoolean;
      Modelica.Blocks.Interfaces.Adaptors.ReceiveBoolean receiveBoolean;
      Modelica.Blocks.Sources.BooleanExpression booleanExpression;
      Modelica.Blocks.Interfaces.Adaptors.SendInteger sendInteger;
      Modelica.Blocks.Interfaces.Adaptors.ReceiveInteger receiveInteger;
      Modelica.Blocks.Sources.IntegerExpression integerExpression;
    equation
      connect(sendReal.toBus, receiveReal.fromBus);
      connect(realExpression.y, sendReal.u);
      connect(sendBoolean.toBus, receiveBoolean.fromBus);
      connect(booleanExpression.y, sendBoolean.u);
      connect(sendInteger.toBus, receiveInteger.fromBus);
      connect(integerExpression.y, sendInteger.u);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/813\">#813</a>.
</p>
</html>"));
    end Issue813;

    model Issue1724 "Conversion test for #1724"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Math.LinearDependency linearDependency(
        y0=10,
        k1=100,
        k2=1000) annotation(Placement(transformation(extent={{-70,65},{-50,85}})));
      Modelica.Blocks.Sources.Constant const(k=1) annotation(Placement(transformation(extent={{-115,65},{-95,85}})));
    equation
      assert(noEvent(linearDependency.y > 11009 and linearDependency.y < 11011), "Break in backward compatibilityof Modelica.Blocks.Math.LinearDependency");
      connect(const.y, linearDependency.u1) annotation(Line(points={{-94,75},{-89,75},{-77,75},{-77,81},{-72,81}},color={0,0,127}));
      connect(const.y, linearDependency.u2) annotation(Line(points={{-94,75},{-89,75},{-77,75},{-77,69},{-72,69}},color={0,0,127}));
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1724\">#1724</a>.
</p>
</html>"));
    end Issue1724;

    model Issue2441 "Conversion test for #2441"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Tables.CombiTable1D table1(table=[0,0;0,1]);
      Modelica.Blocks.Tables.CombiTable2D table2(table=[0,0;0,1]);
    equation
      table1.u[1] = time;
      table2.u1 = time;
      table2.u2 = time;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2441\">#2441</a>.
</p>
</html>"));
    end Issue2441;

    model Issue2891 "Conversion test for #2891"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Continuous.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        yMax=0.5,
        initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,
        limitsAtInit=true);
      Modelica.Blocks.Sources.Clock clock;
      Modelica.Blocks.Nonlinear.Limiter limiter(
        uMax=0.5,
        limitsAtInit=true);
      Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter(
        limitsAtInit=false);
      Modelica.Blocks.Nonlinear.DeadZone deadZone(
        uMax=0.5,
        deadZoneAtInit=false);
      Modelica.Blocks.Sources.Constant const1(k=0.5);
      Modelica.Blocks.Sources.Constant const2(k=-0.5);
    equation
      connect(clock.y, PID.u_s);
      connect(clock.y, PID.u_m);
      connect(clock.y, limiter.u);
      connect(clock.y, variableLimiter.u);
      connect(clock.y, deadZone.u);
      connect(const1.y, variableLimiter.limit1);
      connect(const2.y, variableLimiter.limit2);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2891\">#2891</a>.
</p>
</html>"));
    end Issue2891;

    model Issue2892 "Conversion test for #2892"
      extends Modelica.Icons.Example;
      import Modelica.Blocks.Types.InitPID;
      Modelica.Blocks.Continuous.LimPID pid1(initType=InitPID(3), yMax=1);
      Modelica.Blocks.Continuous.LimPID pid2(initType=InitPID.DoNotUse_InitialIntegratorState, yMax=1);
      Modelica.Blocks.Continuous.LimPID pid3(initType=InitPID.SteadyState, yMax=1);
      Modelica.Blocks.Continuous.LimPID pid4(yMax=1);
      Modelica.Blocks.Continuous.PID pid5(initType=Modelica.Blocks.Types.InitPID(3), Td=0.5, Ti=0.5);
      Modelica.Blocks.Continuous.PID pid6(initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState, Td=0.5, Ti=0.5);
      Modelica.Blocks.Continuous.PID pid7(initType=Modelica.Blocks.Types.InitPID.NoInit, Td=0.5, Ti=0.5);
      Modelica.Blocks.Continuous.PID pid8(Td=0.5, Ti=0.5);
      Modelica.Blocks.Sources.Clock clock;
    equation
      connect(clock.y, pid1.u_s);
      connect(clock.y, pid1.u_m);
      connect(clock.y, pid2.u_s);
      connect(clock.y, pid2.u_m);
      connect(clock.y, pid3.u_s);
      connect(clock.y, pid3.u_m);
      connect(clock.y, pid4.u_s);
      connect(clock.y, pid4.u_m);
      connect(clock.y, pid5.u);
      connect(clock.y, pid6.u);
      connect(clock.y, pid7.u);
      connect(clock.y, pid8.u);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2892\">#2892</a>.
</p>
</html>"));
    end Issue2892;

    model Issue2945 "Conversion test for #2945"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Clock clock(
        offset=-0.5,
        startTime=0.5);
    annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2945\">#2945</a>.
</p>
</html>"));
    end Issue2945;

    model Issue3035 "Conversion test for #3035"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Clock clock(
        offset=-0.5,
        startTime=0.5);
      Modelica.Blocks.Sources.Sine sine(
        amplitude=1,
        freqHz=1,
        phase=0,
        offset=0,
        startTime=0.1) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Cosine cosine(
        amplitude=1,
        freqHz=1,
        phase=0,
        offset=0,
        startTime=0.1) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Blocks.Sources.ExpSine expSine(
        amplitude=1,
        freqHz=1,
        phase=0,
        damping=1,
        offset=0,
        startTime=0.1) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
    annotation(experiment(StopTime=1, Tolerance=1e-06), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3035\">#3035</a>.
</p>
</html>"));
    end Issue3035;
  end Blocks;

  package ComplexBlocks
    "Library of basic input/output control blocks with Complex signals"
    extends Modelica.Icons.ExamplesPackage;
    model Issue2157 "Conversion test for #2157"
      extends Modelica.Icons.Example;
      Modelica.ComplexBlocks.Sources.LogFrequencySweep logSweep(
        wMin=0.01,
        wMax=100,
        duration=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2157\">#2157</a>.
</p>
</html>"));
    end Issue2157;
  end ComplexBlocks;

  package Constants
    extends Modelica.Icons.ExamplesPackage;
    model Issue194 "Conversion test for #194"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Constant constantBlock(
        k=Modelica.Constants.mue_0);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
    end Issue194;
  end Constants;

  package StateGraph
    extends Modelica.Icons.ExamplesPackage;
    model Issue2112 "Conversion test for #2112"
      extends Modelica.Icons.Example;
      Boolean b1 = Modelica.StateGraph.Temporary.anyTrue({true, false});
      Boolean b2;
    algorithm
      b2 := not Modelica.StateGraph.Temporary.allTrue({true, false});
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2112\">#2112</a>.
</p>
</html>"));
    end Issue2112;

    model Issue2113 "Conversion test for #2113"
      extends Modelica.Icons.Example;
      Modelica.StateGraph.Temporary.NumericValue numericValue1(
        precision=2,
        hideConnector=false)
        annotation(Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.StateGraph.Temporary.NumericValue numericValue2(
        precision=3,
        hideConnector=true,
        Value=time*2)
        annotation(Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica.StateGraph.Temporary.IndicatorLamp indicatorLamp
        annotation(Placement(transformation(extent={{20,40},{40,60}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=time >= 0.5)
        annotation(Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=time*3)
        annotation(Placement(transformation(extent={{-100,0},{-80,20}})));
    equation
      connect(booleanExpression.y, indicatorLamp.u) annotation(Line(points={{1,50},{18,50}}, color={255,0,255}));
      connect(realExpression.y, numericValue1.Value) annotation(Line(points={{-79,10},{-62,10}}, color={0,0,127}));
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2113\">#2113</a>.
</p>
</html>"));
    end Issue2113;

    model Issue2880 "Conversion test for #2880"
      extends Modelica.Icons.Example;
      parameter Modelica.StateGraph.Temporary.SetRealParameter limit=0.98 "Limit level of tank 1"
        annotation(Placement(transformation(extent={{-64,76},{-44,96}})));
      parameter Modelica.StateGraph.Temporary.SetRealParameter waitTime=3 "Wait time"
        annotation(Placement(transformation(extent={{-91,76},{-71,96}})));
      Modelica.StateGraph.Temporary.RadioButton start(reset={stop.on,shut.on}, buttonTimeTable={20,280})
        annotation(Placement(transformation(extent={{-66,40},{-46,60}})));
      Modelica.StateGraph.Temporary.RadioButton stop(reset={start.on,shut.on}, buttonTimeTable={220,650})
        annotation(Placement(transformation(extent={{-66,10},{-46,30}})));
      Modelica.StateGraph.Temporary.RadioButton shut(reset={start.on,stop.on}, buttonTimeTable={700})
        annotation(Placement(transformation(extent={{-66,-20},{-46,0}})));
      annotation(experiment(StopTime=900), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2880\">#2880</a>.
</p>
</html>"));
    end Issue2880;

    model Issue3086 "Conversion test for #3086"
      extends Modelica.Icons.Example;
      Modelica.StateGraph.InitialStep initialStep annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
      Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=1) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.StateGraph.Step step annotation (Placement(transformation(extent={{10,0},{30,20}})));
      Modelica.StateGraph.Transition transition2(enableTimer=true, waitTime=1) annotation (Placement(transformation(extent={{40,0},{60,20}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    equation
      connect(initialStep.outPort[1], transition1.inPort) annotation (Line(points={{-27.5,10},{-14,10}}));
      connect(transition1.outPort, step.inPort[1]) annotation (Line(points={{-8.5,10},{9,10}}));
      connect(step.outPort[1], transition2.inPort) annotation (Line(points={{30.5,10},{46,10}}));
      connect(transition2.outPort, initialStep.inPort[1]) annotation (Line(points={{51.5,10},{70,10},{70,32},{-62,32},{-62,10},{-49,10}}));
      annotation(experiment(StopTime=5), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3086\">#3086</a>.
</p>
</html>"));
    end Issue3086;

    model Issue3086_WithSignal "Conversion test for #3086"
      extends Modelica.Icons.Example;
      Modelica.StateGraph.InitialStepWithSignal initialStep annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
      Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=1) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.StateGraph.StepWithSignal step annotation (Placement(transformation(extent={{10,0},{30,20}})));
      Modelica.StateGraph.Transition transition2(enableTimer=true, waitTime=1) annotation (Placement(transformation(extent={{40,0},{60,20}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    equation
      connect(initialStep.outPort[1], transition1.inPort) annotation (Line(points={{-27.5,10},{-14,10}}));
      connect(transition1.outPort, step.inPort[1]) annotation (Line(points={{-8.5,10},{9,10}}));
      connect(step.outPort[1], transition2.inPort) annotation (Line(points={{30.5,10},{46,10}}));
      connect(transition2.outPort, initialStep.inPort[1]) annotation (Line(points={{51.5,10},{70,10},{70,32},{-62,32},{-62,10},{-49,10}}));
      annotation(experiment(StopTime=5), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3086\">#3086</a>.
</p>
</html>"));
    end Issue3086_WithSignal;
  end StateGraph;

  package Electrical
    extends Modelica.Icons.ExamplesPackage;
    package Analog
      extends Modelica.Icons.ExamplesPackage;
      model Issue197 "Conversion test for #197"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Basic.EMF emf(
          k=1,
          phi(start=0, fixed=true));
        Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=1);
        Modelica.Electrical.Analog.Basic.Ground ground;
      equation
        connect(constantVoltage.n, emf.p);
        connect(constantVoltage.p, emf.n);
        connect(ground.p, emf.n);
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/197\">#197</a>.
</p>
</html>"));
      end Issue197;

      model Issue778 "Conversion test for #778"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation(Placement(transformation(extent={{-20,-100},{0,-80}})));
        Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,0})));
        Modelica.Electrical.Analog.Basic.Resistor r1(R=2)
          annotation(Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={20,20})));
        Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch twoWay annotation (Placement(transformation(extent={{-40,50},{-20,30}})));
        Modelica.Electrical.Analog.Ideal.ControlledIdealCommutingSwitch controlledTwoWay annotation (Placement(transformation(extent={{40,70},{60,50}})));
        Modelica.Electrical.Analog.Basic.Resistor r2(R=1)
          annotation(Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={20,-20})));
        Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.5) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.Electrical.Analog.Basic.Resistor r3(R=1)
          annotation(Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,20})));
        Modelica.Electrical.Analog.Basic.Resistor r4(R=2)
          annotation(Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,-20})));
      equation
        connect(ground.p, constantVoltage.n) annotation (Line(points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
        connect(r1.n, r2.p) annotation (Line(points={{20,10},{20,-10}}, color={0,0,255}));
        connect(r2.n, constantVoltage.n) annotation (Line(points={{20,-30},{20,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
        connect(constantVoltage.p, twoWay.p) annotation (Line(points={{-80,10},{-80,40},{-40,40}}, color={0,0,255}));
        connect(twoWay.n2, r1.p) annotation (Line(points={{-20,40},{20,40},{20,30}}, color={0,0,255}));
        connect(twoWay.n1, r2.p) annotation (Line(points={{-20,36},{-16,36},{-16,0},{20,0},{20,-10}}, color={0,0,255}));
        connect(booleanStep.y, twoWay.control) annotation (Line(points={{-39,0},{-30,0},{-30,28}}, color={255,0,255}));
        connect(controlledTwoWay.p, twoWay.p) annotation (Line(points={{40,60},{-80,60},{-80,40},{-40,40}}, color={0,0,255}));
        connect(controlledTwoWay.control, r2.p) annotation (Line(points={{50,50},{50,0},{20,0},{20,-10}}, color={0,0,255}));
        connect(controlledTwoWay.n2, r3.p) annotation (Line(points={{60,60},{80,60},{80,30}}, color={0,0,255}));
        connect(controlledTwoWay.n1, r4.p) annotation (Line(points={{60,56},{68,56},{68,0},{80,0},{80,-10}}, color={0,0,255}));
        connect(r3.n, r4.p) annotation (Line(points={{80,10},{80,-10}}, color={0,0,255}));
        connect(r4.n, constantVoltage.n) annotation (Line(points={{80,-30},{80,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/778\">#778</a>.
</p>
</html>"));
      end Issue778;

      model Issue2361 "Conversion test for #2361"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
          Vps=15,
          Vns=-15,
          out(i(start=0, fixed=false)))
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation(Placement(transformation(extent={{-20,-100},{0,-80}})));
        Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
          V=10,
          rising=0.2/10,
          width=0.3/10,
          falling=0.2/10,
          period=1/10,
          nperiod=-1,
          offset=-5,
          startTime=-(vIn.rising + vIn.width/2))
          annotation(Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={-80,0})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor vOut
          annotation(Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270, origin={50,-20})));
        Modelica.Electrical.Analog.Basic.Resistor r1(R=1000)
          annotation(Placement(transformation(extent={{-40,20},{-20,40}})));
        Modelica.Electrical.Analog.Basic.Resistor r2(R=2000)
          annotation(Placement(transformation(extent={{20,20},{0,40}})));
      equation
        connect(r1.n, r2.n) annotation(Line(points={{-20,30},{0,30}}, color={0,0,255}));
        connect(r2.n, opAmp.in_n) annotation(Line(points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
        connect(r2.p, opAmp.out) annotation(Line(points={{20,30},{30,30},{30,0},{20,0}}, color={0,0,255}));
        connect(ground.p, opAmp.in_p) annotation(Line(points={{-10,-80},{-10,-6},{0,-6}}, color={0,0,255}));
        connect(vIn.p, r1.p) annotation(Line(points={{-80,10},{-80,30},{-40,30}}, color={0,0,255}));
        connect(ground.p, vIn.n) annotation(Line(points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
        connect(ground.p, vOut.n) annotation(Line(points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
        connect(opAmp.out, vOut.p) annotation(Line(points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2361\">#2361</a>.
</p>
</html>"));
      end Issue2361;

      model Issue2786IdealGyrator "Conversion test for #2786"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(transformation(extent={{-40,-54},{-20,-34}})));
        Modelica.Electrical.Analog.Ideal.IdealGyrator gyrator(G=2) annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
        Modelica.Electrical.Analog.Sources.ConstantVoltage v1(V=1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-30,0})));
        Modelica.Electrical.Analog.Sources.ConstantVoltage v2(V=1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,0})));
        Modelica.Electrical.Analog.Basic.Ground ground2
          annotation (Placement(transformation(extent={{20,-54},{40,-34}})));
      equation
        connect(v1.p, gyrator.p1) annotation (Line(points={{-30,10},{-30,20},{-10,20},{-10,8}}, color={0,0,255}));
        connect(v1.n, gyrator.n1) annotation (Line(points={{-30,-10},{-30,-20},{-10,-20},{-10,-12}}, color={0,0,255}));
        connect(v1.n, ground1.p) annotation (Line(points={{-30,-10},{-30,-34}}, color={0,0,255}));
        connect(v2.p, gyrator.p2) annotation (Line(points={{30,10},{30,20},{10,20},{10,8}}, color={0,0,255}));
        connect(v2.n, gyrator.n2) annotation (Line(points={{30,-10},{30,-20},{10,-20},{10,-12}}, color={0,0,255}));
        connect(v2.n,ground2. p) annotation (Line(points={{30,-10},{30,-34}}, color={0,0,255}));
        annotation (experiment(StopTime=1),
          Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2786\">#2786</a>.
</p>
</html>"));
      end Issue2786IdealGyrator;

      model Issue2899Resistor "Conversion test for #2899"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation(Placement(transformation(extent={{-30,-20},{-10,0}})));
        Modelica.Electrical.Analog.Basic.HeatingResistor resistor(R_ref = 10,
            useHeatPort=false)
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      equation
        connect(ground.p, resistor.p)
          annotation (Line(points={{-20,0},{-10,0},{-10,0},{0,0}}, color={0,0,255}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2899\">#2899</a>.
</p>
</html>"));
      end Issue2899Resistor;

      model Issue2899Diode "Conversion test for #2899"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Semiconductors.HeatingDiode diode1(useHeatPort=false, N=1.5) annotation(Placement(transformation(extent={{-95,40},{-75,60}})));
        Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent={{-130,-5},{-110,15}})));
        Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(
          V=1, freqHz=1) annotation(Placement(transformation(origin={-120,35}, extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor1(
          v(start=0, fixed=true), C=1) annotation(Placement(transformation(extent={{-55,40},{-35,60}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor1(R=1) annotation(Placement(transformation(extent={{-55,70},{-35,90}})));
        Modelica.Electrical.Analog.Semiconductors.Diode diode2(useHeatPort=false, Vt=0.05) annotation(Placement(transformation(extent={{15,40},{35,60}})));
        Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(extent={{-20,-5},{0,15}})));
        Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage2(
          V=1, freqHz=1) annotation(Placement(transformation(origin={-10,35}, extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor2(
          v(start=0, fixed=true), C=1) annotation(Placement(transformation(extent={{55,40},{75,60}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor2(R=1) annotation(Placement(transformation(extent={{55,70},{75,90}})));
      equation
        connect(sineVoltage1.p,diode1.p) annotation(Line(points={{-120,45},{-120,50},{-100,50},{-95,50}}, color={0,0,255}));
        connect(sineVoltage1.n,ground1.p) annotation(Line(points={{-120,25},{-120,15}}, color={0,0,255}));
        connect(diode1.n,capacitor1.p) annotation(Line(points={{-75,50},{-70,50},{-60,50},{-55,50}}, color={0,0,255}));
        connect(resistor1.p,capacitor1.p) annotation(Line(points={{-55,80},{-60,80},{-60,50},{-55,50}}, color={0,0,255}));
        connect(resistor1.n,capacitor1.n) annotation(Line(points={{-35,80},{-30,80},{-30,50},{-35,50}}, color={0,0,255}));
        connect(sineVoltage1.n,capacitor1.n) annotation(Line(points={{-120,25},{-120,20},{-30,20},{-30,50},{-35,50}}, color={0,0,255}));
        connect(sineVoltage2.n,capacitor2.n) annotation(Line(points={{-10,25},{-10,20},{80,20},{80,50},{75,50}}, color={0,0,255}));
        connect(resistor2.n,capacitor2.n) annotation(Line(points={{75,80},{80,80},{80,50},{75,50}}, color={0,0,255}));
        connect(resistor2.p,capacitor2.p) annotation(Line(points={{55,80},{50,80},{50,50},{55,50}}, color={0,0,255}));
        connect(diode2.n,capacitor2.p) annotation(Line(points={{35,50},{40,50},{50,50},{55,50}}, color={0,0,255}));
        connect(sineVoltage2.n,ground2.p) annotation(Line(points={{-10,25},{-10,15}}, color={0,0,255}));
        connect(sineVoltage2.p,diode2.p) annotation(Line(points={{-10,45},{-10,50},{10,50},{15,50}}, color={0,0,255}));
        annotation(experiment(StopTime=5), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2899\">#2899</a>.
</p>
</html>"));
      end Issue2899Diode;

      model Issue2899MOS "Conversion test for #2899"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
        Modelica.Electrical.Analog.Sources.SineVoltage sinV(V=5, freqHz=1) annotation (Placement(transformation(origin={-70,0}, extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=0.00001, v(start=0, fixed=true)) annotation (Placement(transformation(origin={30,10}, extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=0.01) annotation (Placement(transformation(origin={70,-60}, extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor tc1(G=0.01) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
        Modelica.Electrical.Analog.Semiconductors.HeatingPMOS pMOS(useHeatPort=true) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
        Modelica.Electrical.Analog.Semiconductors.HeatingNMOS nMOS(useHeatPort=true) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
        Modelica.Electrical.Analog.Sources.RampVoltage rampV(V=5, duration=1e-2) annotation (Placement(transformation(origin={50,50}, extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor tc2(G=0.01) annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedT(T=300) annotation (Placement(transformation(origin={90,-30}, extent={{-10,-10},{10,10}}, rotation=180)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor tc3(G=0.01) annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
      initial equation
        heatCapacitor.T= 293.15;
      equation
        connect(sinV.n, ground.p) annotation (Line(points={{-70,-10},{-70,-20}}, color={0,0,255}));
        connect(capacitor.n, ground.p) annotation (Line(points={{30,0},{30,-20},{-70,-20}}, color={0,0,255}));
        connect(pMOS.S, nMOS.D) annotation (Line(points={{-20,44},{-20,16}}, color={0,0,255}));
        connect(nMOS.D, capacitor.p) annotation (Line(points={{-20,16},{-20,20},{30,20}}, color={0,0,255}));
        connect(nMOS.B, nMOS.S) annotation (Line(points={{-20,10},{-20,4}}, color={0,0,255}));
        connect(nMOS.S, ground.p) annotation (Line(points={{-20,4},{-20,-20},{-70,-20}}, color={0,0,255}));
        connect(pMOS.B, pMOS.D) annotation (Line(points={{-20,50},{-20,56}}, color={0,0,255}));
        connect(rampV.p, pMOS.D) annotation (Line(points={{50,60},{-20,60},{-20,56}}, color={0,0,255}));
        connect(rampV.n, ground.p) annotation (Line(points={{50,40},{50,-20},{-70,-20}}, color={0,0,255}));
        connect(tc1.port_b, heatCapacitor.port) annotation (Line(points={{20,-40},{40,-40},{40,-60},{60,-60}}, color={191,0,0}));
        connect(tc2.port_b, heatCapacitor.port) annotation (Line(points={{20,-80},{40,-80},{40,-60},{60,-60}}, color={191,0,0}));
        connect(tc1.port_a, pMOS.heatPort) annotation (Line(points={{0,-40},{-10,-40},{-10,40},{-30,40}}, color={191,0,0}));
        connect(tc2.port_a, nMOS.heatPort) annotation (Line(points={{0,-80},{-30,-80},{-30,0}}, color={191,0,0}));
        connect(tc3.port_b, fixedT.port) annotation (Line(points={{70,-30},{80,-30}}, color={191,0,0}));
        connect(tc3.port_a, heatCapacitor.port) annotation (Line(points={{50,-30},{40,-30},{40,-60},{60,-60}}, color={191,0,0}));
        connect(sinV.p, nMOS.G) annotation (Line(points={{-70,10},{-54,10},{-54,4},{-40,4}}, color={0,0,255}));
        connect(pMOS.G, sinV.p) annotation (Line(points={{-40,44},{-48,44},{-48,44},{-54,44},{-54,10},{-70,10}}, color={0,0,255}));
        annotation(experiment(StopTime=5), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2899\">#2899</a>.
</p>
</html>"));
      end Issue2899MOS;

      model Issue2899NPN "Conversion test for #2899"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Semiconductors.HeatingNPN npn(useHeatPort=true) annotation (Placement(transformation(extent={{-2,40},{18,60}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-42,12},{-22,32}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor tc(G=0.01) annotation (Placement(transformation(origin={8,22}, extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=0.1) annotation (Placement(transformation(origin={8,-6}, extent={{-10,-10},{10,10}}, rotation=180)));
      initial equation
        heatCapacitor.T= 293.15;
      equation
        connect(npn.B, ground.p) annotation (Line(points={{-2,50},{-26,50},{-26,32},{-32,32}}, color={0,0,255}));
        connect(npn.E, ground.p) annotation (Line(points={{18,44},{-14,44},{-14,32},{-32,32}}, color={0,0,255}));
        connect(npn.C, ground.p) annotation (Line(points={{18,56},{-16,56},{-16,32},{-32,32}}, color={0,0,255}));
        connect(npn.heatPort, tc.port_a) annotation (Line(points={{8,40},{8,32}}, color={191,0,0}));
        connect(tc.port_b, heatCapacitor.port) annotation (Line(points={{8,12},{8,4}}, color={191,0,0}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2899\">#2899</a>.
</p>
</html>"));
      end Issue2899NPN;

      model Issue2899PNP "Conversion test for #2899"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Semiconductors.HeatingPNP pnp annotation (Placement(transformation(extent={{-2,40},{18,60}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-42,12},{-22,32}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor tc(G=0.01) annotation (Placement(transformation(origin={8,22}, extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=0.1) annotation (Placement(transformation(origin={8,-6}, extent={{-10,-10},{10,10}}, rotation=180)));
      initial equation
        heatCapacitor.T= 293.15;
      equation
        connect(pnp.B, ground.p) annotation (Line(points={{-2,50},{-26,50},{-26,32},{-32,32}}, color={0,0,255}));
        connect(pnp.E, ground.p) annotation (Line(points={{18,44},{-14,44},{-14,32},{-32,32}}, color={0,0,255}));
        connect(pnp.C, ground.p) annotation (Line(points={{18,56},{-16,56},{-16,32},{-32,32}}, color={0,0,255}));
        connect(pnp.heatPort, tc.port_a) annotation (Line(points={{8,40},{8,32}}, color={191,0,0}));
        connect(tc.port_b, heatCapacitor.port) annotation (Line(points={{8,12},{8,4}}, color={191,0,0}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2899\">#2899</a>.
</p>
</html>"));
      end Issue2899PNP;

      model Issue3024 "Conversion test for #3024"
        extends Modelica.Icons.Example;
        import pi = Modelica.Electrical.Analog.Basic.OpAmpDetailed.Pi;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3024\">#3024</a>.
</p>
</html>"));
      end Issue3024;

      model Issue3035 "Conversion test for #3035"
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Clock clock(
          offset=-0.5,
          startTime=0.5);
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
        Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(
          V=1,
          phase=0,
          freqHz=1,
          offset=0,
          startTime=0.1) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={-40,30})));
        Modelica.Electrical.Analog.Sources.CosineVoltage cosineVoltage(
          V=1,
          phase=0,
          freqHz=1,
          offset=0,
          startTime=0.1) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={-40,0})));
        Modelica.Electrical.Analog.Sources.ExpSineVoltage expSineVoltage(
          V=1,
          freqHz=1,
          phase=0,
          damping=1,
          offset=0,
          startTime=0.1) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={-40,-30})));
        Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent(
          I=1,
          phase=0,
          freqHz=1,
          offset=0,
          startTime=0.2) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={20,0})));
        Modelica.Electrical.Analog.Sources.CosineCurrent cosineCurrent(
          I=1,
          phase=0,
          freqHz=1,
          offset=0,
          startTime=0.2) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={50,0})));
        Modelica.Electrical.Analog.Sources.ExpSineCurrent expSineCurrent(
          I=1,
          freqHz=1,
          phase=0,
          damping=1,
          offset=0,
          startTime=0.2) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={80,0})));
      equation
        connect(sineVoltage.p, sineCurrent.p) annotation (Line(points={{-40,40},{-40,50},{20,50},{20,10}}, color={0,0,255}));
        connect(cosineCurrent.p, sineCurrent.p) annotation (Line(points={{50,10},{50,50},{20,50},{20,10}}, color={0,0,255}));
        connect(expSineCurrent.p, sineCurrent.p) annotation (Line(points={{80,10},{80,50},{20,50},{20,10}}, color={0,0,255}));
        connect(sineVoltage.n, cosineVoltage.p) annotation (Line(points={{-40,20},{-40,10}}, color={0,0,255}));
        connect(cosineVoltage.n, expSineVoltage.p) annotation (Line(points={{-40,-10},{-40,-20}}, color={0,0,255}));
        connect(expSineVoltage.n, ground.p) annotation (Line(points={{-40,-40},{-40,-50},{0,-50},{0,-60}}, color={0,0,255}));
        connect(sineCurrent.n, ground.p) annotation (Line(points={{20,-10},{20,-50},{0,-50},{0,-60}}, color={0,0,255}));
        connect(cosineCurrent.n, ground.p) annotation (Line(points={{50,-10},{50,-50},{0,-50},{0,-60}}, color={0,0,255}));
        connect(expSineCurrent.n, ground.p) annotation (Line(points={{80,-10},{80,-50},{0,-50},{0,-60}}, color={0,0,255}));
      annotation(experiment(StopTime=1, Tolerance=1e-06), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3035\">#3035</a>.
</p>
</html>"));
      end Issue3035;
    end Analog;

    package Digital
      extends Modelica.Icons.ExamplesPackage;
      model Issue758 "Conversion test for #758"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Digital.Sources.Set set(
          x=Modelica.Electrical.Digital.Interfaces.Logic.'U');
        Modelica.Electrical.Digital.Converters.LogicToXO1 logicToXO1_1(n=1);
        Modelica.Electrical.Digital.Converters.LogicToXO1Z logicToXO1Z(n=1);
      equation
        connect(set.y, logicToXO1_1.x[1]);
        connect(set.y, logicToXO1Z.x[1]);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/758\">#758</a>.
</p>
</html>"));
      end Issue758;

      model Issue2945 "Conversion test for #2945"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Digital.Sources.Clock clock(
          startTime=0,
          period=1,
          width=50);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2945\">#2945</a>.
</p>
</html>"));
      end Issue2945;
    end Digital;

    package QuasiStatic
      extends Modelica.Icons.ExamplesPackage;
      model Issue1189 "Conversion test for #1189"
        extends Modelica.Icons.Example;
        import Modelica.Electrical.QuasiStationary.Types.Reference;
        parameter Reference r = Modelica.Electrical.QuasiStationary.Types.Reference(0);
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1189\">#1189</a>.
</p>
</html>"));
      end Issue1189;

      model Issue2693 "Conversion test for #2693"
        extends Modelica.Icons.Example;
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor variableConductor(variableResistor "Variable Conductor");
        Modelica.Blocks.Sources.RealExpression realExpression[3](each y=time + 1);
        Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource;
      equation
        connect(realExpression.y, variableConductor.G_ref);
        connect(variableConductor.plug_n, voltageSource.plug_p);
        connect(voltageSource.plug_n, variableConductor.plug_p);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2693\">#2693</a>.
</p>
</html>"));
      end Issue2693;

      model Issue2993 "Conversion test for #2993"
        extends Modelica.Icons.Example;
        import C1 = Modelica.Electrical.QuasiStationary.MultiPhase;
        import C2 = Modelica.Electrical.QuasiStationary.MultiPhase.Blocks.SingleToMultiPhase;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2993\">#2993</a>.
</p>
</html>"));
      end Issue2993;

      model Issue3022SinglePhase "Conversion test for #3022"
        extends Modelica.Icons.Example;
        import Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor;
        constant Integer m=3 "Number of phases";
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Voltage VRMS=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency f=50 "Frequency";
        parameter Modelica.SIunits.Resistance R=1/sqrt(2) "Load resistance";
        parameter Modelica.SIunits.Inductance L=1/sqrt(2)/(2*pi*f) "Load inductance";
        final parameter Modelica.SIunits.Impedance Z=sqrt(R^2 + (2*pi*f*L)^2) "Load impedance";
        final parameter Modelica.SIunits.Current IRMS=VRMS/Z "Steady state RMS current";
        final parameter Modelica.SIunits.ActivePower P=3*R*IRMS^2 "Total active power";
        final parameter Modelica.SIunits.ReactivePower Q=3*(2*pi*f*L)*IRMS^2 "Total reactive power";
        final parameter Modelica.SIunits.ApparentPower S=3*Z*IRMS^2 "Total apparent power";
        Modelica.SIunits.Angle reference = referenceSensor.y "Reference angle";
        Modelica.SIunits.AbsoluteActivity frequency = frequencySensor.y "Frequency";
        Modelica.SIunits.ComplexElectricPotential potential = potentialSensor.y "Potential";
        Modelica.SIunits.ComplexVoltage voltage = voltageSensor.y "Voltage";
        Modelica.SIunits.ComplexCurrent current = currentSensor.y "Current";
        Modelica.SIunits.ComplexPower power = powerSensor.y "Power";
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-20,-100},
              extent={{-10,-10},{10,10}})));

        Modelica.Blocks.Math.Gain gainReferenceSensor(k=1) annotation (Placement(transformation(extent={{-70,-20},{-90,0}})));
        Modelica.ComplexBlocks.ComplexMath.Gain gainVoltageSensor(k=Complex(1, 0)) annotation (Placement(transformation(extent={{-70,-60},{-90,-40}})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(
          gamma(start=0, fixed=true),
          f=50,
          V=100,
          phi=0) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-20,-50})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource currentSource(
          gamma(fixed=true, start=0),
          f=50,
          I=1,
          phi=0) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={20,-50})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={20,-20})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={20,10})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-40,-50})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor referenceSensor annotation (Placement(transformation(extent={{-40,-20},{-60,0}})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor potentialSensor annotation (Placement(transformation(extent={{-40,40},{-60,60}})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor frequencySensor annotation (Placement(transformation(extent={{-40,10},{-60,30}})));
        Modelica.Blocks.Math.Gain gainFrequencySensor(k=1) annotation (Placement(transformation(extent={{-70,10},{-90,30}})));
        Modelica.ComplexBlocks.ComplexMath.Gain gainCurrentSensor(k=Complex(1, 0)) annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
        Modelica.ComplexBlocks.ComplexMath.Gain gainPowerSensor(k=Complex(1, 0)) annotation (Placement(transformation(extent={{60,10},{80,30}})));
        Modelica.ComplexBlocks.ComplexMath.Gain gainPotentialSensor(k=Complex(1, 0)) annotation (Placement(transformation(extent={{-70,40},{-90,60}})));
      equation

        connect(voltageSource.pin_n, ground.pin) annotation (Line(points={{-20,-60},{-20,-90}}, color={85,170,255}));
        connect(voltageSource.pin_n, currentSource.pin_n) annotation (Line(points={{-20,-60},{-20,-70},{20,-70},{20,-60}}, color={85,170,255}));
        connect(voltageSource.pin_p, powerSensor.currentP) annotation (Line(points={{-20,-40},{-20,50},{20,50},{20,20}}, color={85,170,255}));
        connect(powerSensor.currentN, currentSensor.pin_p) annotation (Line(points={{20,0},{20,-10}}, color={85,170,255}));
        connect(currentSensor.pin_n, currentSource.pin_p) annotation (Line(points={{20,-30},{20,-40}}, color={85,170,255}));
        connect(powerSensor.voltageP, powerSensor.currentP) annotation (Line(points={{10,10},{10,20},{20,20}}, color={85,170,255}));
        connect(powerSensor.voltageN, currentSource.pin_n) annotation (Line(points={{30,10},{40,10},{40,-70},{20,-70},{20,-60}}, color={85,170,255}));
        connect(powerSensor.y, gainPowerSensor.u) annotation (Line(points={{31,20},{58,20}}, color={85,170,255}));
        connect(currentSensor.y, gainCurrentSensor.u) annotation (Line(points={{31,-20},{58,-20}}, color={85,170,255}));
        connect(referenceSensor.y, gainReferenceSensor.u) annotation (Line(points={{-61,-10},{-68,-10}}, color={0,0,127}));
        connect(frequencySensor.y, gainFrequencySensor.u) annotation (Line(points={{-61,20},{-68,20}}, color={0,0,127}));
        connect(frequencySensor.pin, powerSensor.currentP) annotation (Line(points={{-40,20},{-20,20},{-20,50},{20,50},{20,20}}, color={85,170,255}));
        connect(potentialSensor.pin, powerSensor.currentP) annotation (Line(points={{-40,50},{20,50},{20,20}}, color={85,170,255}));
        connect(referenceSensor.pin, powerSensor.currentP) annotation (Line(points={{-40,-10},{-20,-10},{-20,50},{20,50},{20,20}}, color={85,170,255}));
        connect(gainVoltageSensor.u, voltageSensor.y) annotation (Line(points={{-68,-50},{-51,-50}}, color={85,170,255}));
        connect(voltageSensor.pin_p, powerSensor.currentP) annotation (Line(points={{-40,-40},{-40,-28},{-20,-28},{-20,50},{20,50},{20,20}}, color={85,170,255}));
        connect(voltageSensor.pin_n, ground.pin) annotation (Line(points={{-40,-60},{-40,-70},{-20,-70},{-20,-90}}, color={85,170,255}));
        connect(gainPotentialSensor.u, potentialSensor.y) annotation (Line(points={{-68,50},{-61,50}}, color={85,170,255}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3022\">#3022</a>.
</p>
</html>"));
      end Issue3022SinglePhase;

      model Issue3022MultiPhase "Conversion test for #3022"
        extends Modelica.Icons.Example;
        import Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor;
        constant Integer m=3 "Number of phases";
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Voltage VRMS=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency f=50 "Frequency";
        parameter Modelica.SIunits.Resistance R=1/sqrt(2) "Load resistance";
        parameter Modelica.SIunits.Inductance L=1/sqrt(2)/(2*pi*f) "Load inductance";
        final parameter Modelica.SIunits.Impedance Z=sqrt(R^2 + (2*pi*f*L)^2) "Load impedance";
        final parameter Modelica.SIunits.Current IRMS=VRMS/Z "Steady state RMS current";
        final parameter Modelica.SIunits.ActivePower P=3*R*IRMS^2 "Total active power";
        final parameter Modelica.SIunits.ReactivePower Q=3*(2*pi*f*L)*IRMS^2 "Total reactive power";
        final parameter Modelica.SIunits.ApparentPower S=3*Z*IRMS^2 "Total apparent power";
        Modelica.SIunits.Angle reference = referenceSensor.y "Reference angle";
        Modelica.SIunits.AbsoluteActivity frequency = frequencySensor.y "Frequency";
        Modelica.SIunits.ComplexElectricPotential potential[m] = potentialSensor.y "Potential";
        Modelica.SIunits.ComplexVoltage voltage[m] = voltageSensor.y "Voltage";
        Modelica.SIunits.ComplexCurrent current[m] = currentSensor.y "Current";
        Modelica.SIunits.ComplexPower power = powerSensor.y "Power";
        Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource sineVoltage(
          final m=m,
          f=f,
          V=fill(VRMS, m),
          gamma(fixed=true, start=0))
                             annotation (Placement(transformation(
              origin={-20,-30},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-20,-70})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-20,-100},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistor(m=m, R_ref=fill(R, m))
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={20,-20})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor inductor(m=m, L=fill(L, m))
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={20,-50})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starLoad(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={20,-80})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor
          currentQuasiRMSSensor(m=m) annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={-20,40})));
        Modelica.Blocks.Math.Feedback feedbackI
          annotation (Placement(transformation(extent={{-70,30},{-90,50}})));
        Modelica.Blocks.Sources.Constant constI(k=IRMS) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={-80,10})));

        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,-30})));
        Modelica.Blocks.Math.Feedback feedbackV
          annotation (Placement(transformation(extent={{-70,-40},{-90,-20}})));
        Modelica.Blocks.Sources.Constant constV(k=VRMS) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={-80,-60})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor powerSensor(m=m)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={20,10})));
        Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal
          annotation (Placement(transformation(extent={{40,30},{60,10}})));
        Modelica.Blocks.Math.Feedback feedbackP
          annotation (Placement(transformation(extent={{80,-10},{100,10}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=
          Modelica.Electrical.QuasiStationary.MultiPhase.Functions.activePower(
              voltageQuasiRMSSensor.v, currentQuasiRMSSensor.i)) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={70,-20})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.AronSensor aronSensor annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={20,40})));
        Modelica.Blocks.Math.Feedback feedbackPAron
          annotation (Placement(transformation(extent={{80,30},{100,50}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReactivePowerSensor
          reactivePowerSensor annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={20,70})));
        Modelica.Blocks.Math.Feedback feedbackQ
          annotation (Placement(transformation(extent={{40,60},{60,80}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor referenceSensor annotation (Placement(transformation(extent={{-40,80},{-60,100}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor frequencySensor annotation (Placement(transformation(extent={{-40,50},{-60,70}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor potentialSensor annotation (Placement(transformation(extent={{20,80},{40,100}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor currentSensor annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={-20,0})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={50,-50})));
        Modelica.ComplexBlocks.ComplexMath.Gain gainCurrentSensor[m](k=fill(Complex(1, 0), m)) annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
        Modelica.ComplexBlocks.ComplexMath.Gain gainVoltageSensor[m](k=fill(Complex(1, 0), m)) annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
        Modelica.Blocks.Math.Gain gainFrequencySensor(k=1) annotation (Placement(transformation(extent={{-72,50},{-92,70}})));
        Modelica.Blocks.Math.Gain gainReferenceSensor(k=1) annotation (Placement(transformation(extent={{-72,80},{-92,100}})));
        Modelica.ComplexBlocks.ComplexMath.Gain gainPotentialSensor[m](k=fill(Complex(1, 0), m)) annotation (Placement(transformation(extent={{60,80},{80,100}})));
      equation

        connect(feedbackV.u1, voltageQuasiRMSSensor.V) annotation (Line(
            points={{-72,-30},{-61,-30}},
                                        color={0,0,127}));
        connect(constV.y, feedbackV.u2) annotation (Line(
            points={{-80,-49},{-80,-38}},
                                        color={0,0,127}));
        connect(realExpression.y, feedbackP.u2)
          annotation (Line(points={{81,-20},{90,-20},{90,-8}},
                                                    color={0,0,127}));
        connect(voltageQuasiRMSSensor.plug_p, sineVoltage.plug_p)
          annotation (Line(points={{-50,-20},{-20,-20}},
                                                       color={85,170,255}));
        connect(voltageQuasiRMSSensor.plug_n, sineVoltage.plug_n)
          annotation (Line(points={{-50,-40},{-20,-40}},
                                                       color={85,170,255}));
        connect(powerSensor.currentP, aronSensor.plug_n)
          annotation (Line(points={{20,20},{20,30}}, color={85,170,255}));
        connect(powerSensor.currentP, powerSensor.voltageP)
          annotation (Line(points={{20,20},{10,20},{10,10}},
                                                           color={85,170,255}));
        connect(powerSensor.currentN, resistor.plug_p)
          annotation (Line(points={{20,0},{20,-10}}, color={85,170,255}));
        connect(resistor.plug_n, inductor.plug_p)
          annotation (Line(points={{20,-30},{20,-40}}, color={85,170,255}));
        connect(inductor.plug_n, starLoad.plug_p)
          annotation (Line(points={{20,-60},{20,-70}}, color={85,170,255}));
        connect(starLoad.plug_p, powerSensor.voltageN)
          annotation (Line(points={{20,-70},{30,-70},{30,10}}, color={85,170,255}));
        connect(star.pin_n, ground.pin)
          annotation (Line(points={{-20,-80},{-20,-90}}, color={85,170,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-20,-40},{-20,-60}},color={85,170,255}));
        connect(powerSensor.y, complexToReal.u)
          annotation (Line(points={{31,20},{38,20}}, color={85,170,255}));
        connect(complexToReal.re, feedbackP.u1) annotation (Line(points={{62,14},{70,14},
                {70,0},{82,0}},   color={0,0,127}));
        connect(feedbackI.u2, constI.y)
          annotation (Line(points={{-80,32},{-80,21}}, color={0,0,127}));
        connect(feedbackI.u1, currentQuasiRMSSensor.I)
          annotation (Line(points={{-72,40},{-31,40}}, color={0,0,127}));
        connect(reactivePowerSensor.plug_n, aronSensor.plug_p)
          annotation (Line(points={{20,60},{20,50}}, color={85,170,255}));
        connect(currentQuasiRMSSensor.plug_n, reactivePowerSensor.plug_p)
          annotation (Line(points={{-20,50},{-20,80},{20,80}}, color={85,170,255}));
        connect(reactivePowerSensor.reactivePower, feedbackQ.u1)
          annotation (Line(points={{31,70},{42,70}}, color={0,0,127}));
        connect(aronSensor.power, feedbackPAron.u1)
          annotation (Line(points={{31,40},{82,40}}, color={0,0,127}));
        connect(complexToReal.re, feedbackPAron.u2)
          annotation (Line(points={{62,14},{90,14},{90,32}}, color={0,0,127}));
        connect(complexToReal.im, feedbackQ.u2) annotation (Line(points={{62,26},{70,26},
                {70,50},{50,50},{50,62}}, color={0,0,127}));
        connect(referenceSensor.plug_p, reactivePowerSensor.plug_p) annotation (Line(points={{-40,90},{-20,90},{-20,80},{20,80}}, color={85,170,255}));
        connect(frequencySensor.plug_p, reactivePowerSensor.plug_p) annotation (Line(points={{-40,60},{-20,60},{-20,80},{20,80}}, color={85,170,255}));
        connect(potentialSensor.plug_p, reactivePowerSensor.plug_p) annotation (Line(points={{20,90},{20,80}}, color={85,170,255}));
        connect(sineVoltage.plug_p, currentSensor.plug_p) annotation (Line(points={{-20,-20},{-20,-10}}, color={85,170,255}));
        connect(currentSensor.plug_n, currentQuasiRMSSensor.plug_p) annotation (Line(points={{-20,10},{-20,30},{-20,30}}, color={85,170,255}));
        connect(inductor.plug_p, voltageSensor.plug_p) annotation (Line(points={{20,-40},{50,-40}}, color={85,170,255}));
        connect(inductor.plug_n, voltageSensor.plug_n) annotation (Line(points={{20,-60},{50,-60}}, color={85,170,255}));
        connect(gainCurrentSensor.u, currentSensor.y) annotation (Line(points={{-38,0},{-31,0}}, color={85,170,255}));
        connect(voltageSensor.y, gainVoltageSensor.u) annotation (Line(points={{61,-50},{68,-50}}, color={85,170,255}));
        connect(gainFrequencySensor.u, frequencySensor.y) annotation (Line(points={{-70,60},{-61,60}}, color={0,0,127}));
        connect(gainReferenceSensor.u, referenceSensor.y) annotation (Line(points={{-70,90},{-61,90}}, color={0,0,127}));
        connect(potentialSensor.y, gainPotentialSensor.u) annotation (Line(points={{41,90},{58,90}}, color={85,170,255}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3022\">#3022</a>.
</p>
</html>"));
      end Issue3022MultiPhase;
    end QuasiStatic;

    package Machines
      extends Modelica.Icons.ExamplesPackage;
      model Issue289 "Conversion test for #289"
        extends Modelica.Icons.Example;
        model M1
          extends Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage;
          Integer numPhases = airGapS.m;
        end M1;

        model M2
          extends Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing;
          Integer numPhases = airGapS.m;
        end M2;

        model M3
          extends Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet;
          Integer numPhases = airGapR.m;
        end M3;

        model M4
          extends Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited;
          Integer numPhases = airGapR.m;
        end M4;

        model M5
          extends Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor;
          Integer numPhases = airGapR.m;
        end M5;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/289\">#289</a>.
</p>
</html>"));
      end Issue289;

      model Issue1189 "Conversion test for #1189"
        extends Modelica.Icons.Example;
        model M1
          extends Modelica.Electrical.Machines.Icons.QuasiStationaryTransformer;
        end M1;

        model M2
          extends Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet(quasiStationary=true);
          extends Modelica.Electrical.Machines.Icons.QuasiStationaryMachine;
        end M2;

        model M3
          extends Modelica.Electrical.Machines.BasicMachines.Components.InductorDC(final quasiStationary=true);
        end M3;

        model M4
          extends Modelica.Electrical.Machines.BasicMachines.Components.PartialAirGapDC(final quasiStationary=true);
        end M4;
        Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=100);
        Modelica.Electrical.Analog.Basic.Ground groundArmature;
        Modelica.Blocks.Sources.Pulse pulse(
          amplitude=-1.5*63.66,
          offset=0,
          period=1);
        Modelica.Electrical.Machines.BasicMachines.QuasiStationaryDCMachines.DC_PermanentMagnet
          dcpm2(
          VaNominal=dcpmData.VaNominal,
          IaNominal=dcpmData.IaNominal,
          wNominal=dcpmData.wNominal,
          TaNominal=dcpmData.TaNominal,
          Ra=dcpmData.Ra,
          TaRef=dcpmData.TaRef,
          La=dcpmData.La,
          Jr=dcpmData.Jr,
          useSupport=false,
          Js=dcpmData.Js,
          frictionParameters=dcpmData.frictionParameters,
          coreParameters=dcpmData.coreParameters,
          strayLoadParameters=dcpmData.strayLoadParameters,
          brushParameters=dcpmData.brushParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true, start=157),
          TaOperational=293.15,
          alpha20a=dcpmData.alpha20a);
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia2(J=0.15);
        Modelica.Mechanics.Rotational.Sources.Torque loadTorque2(useSupport=false);
        parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData dcpmData;
      equation
        connect(armatureVoltage.n, groundArmature.p);
        connect(loadInertia2.flange_b, loadTorque2.flange);
        connect(dcpm2.flange, loadInertia2.flange_a);
        connect(pulse.y, loadTorque2.tau);
        connect(armatureVoltage.p, dcpm2.pin_ap);
        connect(armatureVoltage.n, dcpm2.pin_an);
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1189\">#1189</a>.
</p>
</html>"));
      end Issue1189;

      model Issue2929 "Conversion test for #2929"
        extends Modelica.Icons.Example;
        model M =
            Modelica.Electrical.Machines.BasicMachines.Components.BasicTransformer;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2929\">#2929</a>.
</p>
</html>"));
      end Issue2929;

      model Issue2993 "Conversion test for #2993"
        extends Modelica.Icons.Example;
        import C1 = Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage;
        import C2 = Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing;
        import C3 = Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines;
        import C4 = Modelica.Electrical.Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMC;
        import C5 = Modelica.Electrical.Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMS;
        import C6 = Modelica.Electrical.Machines.Thermal.SynchronousInductionMachines;
        import C7 = Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMC;
        import C8 = Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceAIMC;
        import C9 = Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMS;
        import C0 = Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceAIMS;
        import CA = Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData;
        import CB = Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SlipRingData;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2993\">#2993</a>.
</p>
</html>"));
      end Issue2993;

      model Issue3058 "Conversion test for #3058"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Current Idq[2]={-53.5, 84.6}
          "Desired d- and q-current";
        Modelica.Blocks.Sources.Constant id(k=Idq[1])
          annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
        Modelica.Blocks.Sources.Constant iq(k=Idq[2])
          annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
        Modelica.Electrical.Machines.Utilities.CurrentController
                                    currentController(p=2)
          annotation (Placement(transformation(extent={{10,40},{30,60}})));
        Modelica.Blocks.Sources.Constant id1(k=Idq[1])
          annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
        Modelica.Blocks.Sources.Constant iq1(k=Idq[2])
          annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
        Modelica.Electrical.Machines.Utilities.VoltageController
                                             voltageController(
          p=2,
          Ld=0.4/(2*pi*50),
          Lq=0.4/(2*pi*50),
          Rs=0.03,
          fsNominal=50,
          VsOpenCircuit=100)
          annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
        Modelica.Blocks.Sources.Ramp ramp(duration=1)
          annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        Modelica.Blocks.Sources.Constant const[3](each k=0)
          annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
      equation
        connect(iq.y, currentController.iq_rms) annotation (Line(points={{-9,30},{0,30},
                {0,44},{8,44}},         color={0,0,127}));
        connect(id.y, currentController.id_rms) annotation (Line(points={{-9,70},{0,70},
                {0,56},{8,56}},         color={0,0,127}));
        connect(id1.y, voltageController.id_rms) annotation (Line(points={{-9,-30},{0,
                -30},{0,-44},{8,-44}},     color={0,0,127}));
        connect(iq1.y, voltageController.iq_rms) annotation (Line(points={{-9,-70},{0,
                -70},{0,-56},{8,-56}},     color={0,0,127}));
        connect(ramp.y, currentController.phi) annotation (Line(points={{59,0},{40,0},
                {40,20},{20,20},{20,38}}, color={0,0,127}));
        connect(ramp.y, voltageController.phi) annotation (Line(points={{59,0},{40,0},
                {40,-80},{26,-80},{26,-62}}, color={0,0,127}));
        connect(const.y, voltageController.iActual)
          annotation (Line(points={{-59,-90},{14,-90},{14,-62}}, color={0,0,127}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3058\">#3058</a>.
</p>
</html>"));
      end Issue3058;
    end Machines;

    package PowerConverters "Rectifiers, Inverters, DC/DC and AC/AC converters"
      extends Modelica.Icons.ExamplesPackage;
      model Issue2970 "Conversion test for #2970"
        extends Modelica.Icons.Example;
        Modelica.Electrical.PowerConverters.DCDC.Control.VoltageToDutyCycle
          adaptor(vMax=100)
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=200,
          duration=1,
          offset=-100)
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=50)
          annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
        Modelica.Blocks.Sources.Ramp rampAngle(
          height=Modelica.Constants.pi,
          duration=1,
          offset=0) annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
        Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse signal2mPulse(
          m=1,
          useConstantFiringAngle=false,
          useFilter=true,
          f=50,
          fCut=100,
          vStart={0})
          annotation (Placement(transformation(extent={{18,-60},{38,-40}})));
        Boolean toBeConverted;
      equation
        // The following line shall be converted by the conversion script
        toBeConverted = signal2mPulse.negativeEqual[1].y;
        connect(ramp.y, adaptor.v) annotation (Line(points={{-19,0},{18,0}},color={0,0,127}));
        connect(sine.y, signal2mPulse.v[1]) annotation (Line(points={{-19,-50},{16,-50}},color={0,0,127}));
        connect(rampAngle.y, signal2mPulse.firingAngle) annotation (Line(points={{-19,-90},{28,-90},{28,-62}},color={0,0,127}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2970\">#2970</a>.
</p>
</html>"));
      end Issue2970;

      model Issue2993 "Conversion test for #2993"
        extends Modelica.Icons.Example;
        import C = Modelica.Electrical.PowerConverters.DCAC.MultiPhase2Level;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2993\">#2993</a>.
</p>
</html>"));
      end Issue2993;
    end PowerConverters;

    package MultiPhase
      extends Modelica.Icons.ExamplesPackage;
      model Issue2993 "Conversion test for #2993"
        extends Modelica.Icons.Example;
        import C = Modelica.Electrical.MultiPhase;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2993\">#2993</a>.
</p>
</html>"));
      end Issue2993;

      model Issue3035 "Conversion test for #3035"
        extends Modelica.Icons.Example;
        parameter Integer m = 3 "Number of phases";
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          m=m,
          V=fill(1, m),
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
          freqHz=fill(1, m),
          offset=fill(0, m),
          startTime=fill(0.1, m)) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={-40,20})));
        Modelica.Electrical.MultiPhase.Sources.CosineVoltage cosineVoltage(
          m=m,
          V=fill(1, m),
          phase=fill(0, m),
          freqHz=fill(1, m),
          offset=fill(0, m),
          startTime=fill(0.1, m)) annotation (Placement(transformation( extent={{-10,-10},{10,10}}, rotation=270, origin={-40,-20})));
        Modelica.Electrical.MultiPhase.Sources.SineCurrent sineCurrent(
          m=m,
          I=fill(1, m),
          phase=fill(0, m),
          freqHz=fill(1, m),
          offset=fill(0, m),
          startTime=fill(0.2, m)) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={20,0})));
        Modelica.Electrical.MultiPhase.Sources.CosineCurrent cosineCurrent(
          m=m,
          I=fill(1, m),
          phase=fill(0, m),
          freqHz=fill(1, m),
          offset=fill(0, m),
          startTime=fill(0.2, m)) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={50,0})));
        Modelica.Electrical.MultiPhase.Basic.Star star(m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={0,-60})));
      equation
        connect(star.pin_n, ground.p) annotation (Line(points={{-1.77636e-15,-70},{0,-70},{0,-78},{0,-78},{0,-80}}, color={0,0,255}));
        connect(sineCurrent.plug_n, star.plug_p) annotation (Line(points={{20,-10},{20,-40},{0,-40},{0,-50}}, color={0,0,255}));
        connect(cosineCurrent.plug_n, star.plug_p) annotation (Line(points={{50,-10},{50,-40},{0,-40},{0,-50},{1.77636e-15,-50}}, color={0,0,255}));
        connect(cosineVoltage.plug_n, star.plug_p) annotation (Line(points={{-40,-30},{-40,-40},{0,-40},{0,-50},{1.77636e-15,-50}}, color={0,0,255}));
        connect(cosineVoltage.plug_p, sineVoltage.plug_n) annotation (Line(points={{-40,-10},{-40,10}}, color={0,0,255}));
        connect(sineVoltage.plug_p, sineCurrent.plug_p) annotation (Line(points={{-40,30},{-40,40},{20,40},{20,10}}, color={0,0,255}));
        connect(cosineCurrent.plug_p, sineCurrent.plug_p) annotation (Line(points={{50,10},{50,40},{20,40},{20,10}}, color={0,0,255}));
      annotation(experiment(StopTime=1, Tolerance=1e-06), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3035\">#3035</a>.
</p>
</html>"));
      end Issue3035;
    end MultiPhase;
  end Electrical;

  package Magnetic
    extends Modelica.Icons.ExamplesPackage;
    package FluxTubes
      extends Modelica.Icons.ExamplesPackage;
      model Issue496 "Conversion test for #496"
        extends Modelica.Icons.Example;
        partial model PartialTwoPort
          extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
        end PartialTwoPort;

        partial model PartialTwoPortExtended
          extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortExtended;
        end PartialTwoPortExtended;

        partial model PartialFixedShape
          extends Modelica.Magnetic.FluxTubes.Interfaces.PartialFixedShape;
        end PartialFixedShape;

        partial model PartialForce
          extends Modelica.Magnetic.FluxTubes.Interfaces.PartialForce;
        end PartialForce;

        partial model PartialLeakage
          extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;
        end PartialLeakage;

        partial model PartialGeneric
          extends Modelica.Magnetic.FluxTubes.Interfaces.PartialGeneric;
        end PartialGeneric;

        partial model PartialGenericHysteresis
          extends Modelica.Magnetic.FluxTubes.Interfaces.PartialGenericHysteresis;
        end PartialGenericHysteresis;

        partial model PartialGenericHysteresisTellinen
          extends Modelica.Magnetic.FluxTubes.Interfaces.PartialGenericHysteresisTellinen;
        end PartialGenericHysteresisTellinen;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/496\">#496</a>.
</p>
</html>"));
      end Issue496;

      model Issue3300 "Conversion test for #3300"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Reluctance R_m = 1 "Reluctance";

        Modelica.Magnetic.FluxTubes.Basic.Ground ground annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
        Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference magVoltageSource(V_m=1)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-40,10})));
        Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient leakage1(R_mUsefulTot=R_m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,10})));
        Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient leakage2(c_usefulFlux=0.5, R_mUsefulTot=R_m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,10})));
      equation
        assert(leakage1.c_usefulFlux <> leakage2.c_usefulFlux, "Parameter c_usefulFlux must not be equal to 0.7: conversion failed");
        connect(magVoltageSource.port_n, ground.port) annotation (Line(points={{-40,-3.55271e-15},{-40,-20}}, color={255,127,0}));
        connect(ground.port, leakage1.port_n) annotation (Line(points={{-40,-20},{-40,-10},{0,-10},{0,-3.55271e-15}}, color={255,127,0}));
        connect(ground.port, leakage2.port_n) annotation (Line(points={{-40,-20},{-40,-10},{30,-10},{30,0}}, color={255,127,0}));
        connect(magVoltageSource.port_p, leakage1.port_p) annotation (Line(points={{-40,20},{-40,30},{0,30},{0,20}}, color={255,127,0}));
        connect(magVoltageSource.port_p, leakage2.port_p) annotation (Line(points={{-40,20},{-40,30},{30,30},{30,20}}, color={255,127,0}));
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3300\">#3300</a>.
</p>
</html>"));
      end Issue3300;
    end FluxTubes;

    package FundamentalWave
      extends Modelica.Icons.ExamplesPackage;
      model Issue496 "Conversion test for #496"
        extends Modelica.Icons.Example;
        partial model PartialTwoPortsElementary "Two magnetic ports for graphical modeling"
          extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPortsElementary;
        end PartialTwoPortsElementary;

        partial model PartialTwoPorts "Two magnetic ports for graphical modeling with additional variables"
          extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPorts;
        end PartialTwoPorts;

        partial model PartialTwoPortElementary "Two magnetic ports for textual modeling"
          extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary;
        end PartialTwoPortElementary;

        partial model PartialBasicInductionMachine "Partial model for induction machine"
          extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine;
        end PartialBasicInductionMachine;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/496\">#496</a>.
</p>
</html>"));
      end Issue496;

      model Issue2993 "Conversion test for #2993"
        extends Modelica.Icons.Example;
        import C1 = Modelica.Magnetic.FundamentalWave.UsersGuide.MultiPhase;
        import C2 = Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter;
        import C3 = Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding;
        import C4 = Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding;
        import C5 = Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage;
        import C6 = Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing;
        import C7 = Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2993\">#2993</a>.
</p>
</html>"));
      end Issue2993;

      model Issue3030 "Conversion test for #3030"
        extends Modelica.Icons.Example;
        Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding_obsolete symmetricCage(RRef=1, Lsigma=1) annotation (Placement(transformation(extent={{0,0},{20,20}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding_obsolete saliencyCage(RRef(d(start=1), q(start=1)), Lsigma(d(start=1), q(start=1))) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        Modelica.Magnetic.FundamentalWave.Components.Ground ground annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-30,-10})));
      equation
        connect(ground.port_p, symmetricCage.port_p) annotation (Line(points={{-20,-10},{-10,-10},{-10,10},{0,10}}, color={255,128,0}));
        connect(ground.port_p, saliencyCage.port_p) annotation (Line(points={{-20,-10},{-10,-10},{-10,-30},{0,-30}}, color={255,128,0}));
        annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3030\">#3030</a>.
</p>
</html>"));
      end Issue3030;

      model Issue3075 "Conversion test for #3075"
        Modelica.SIunits.MagneticPotentialDifference V_m1 = smee.stator.strayReluctance.abs_V_m;
        Modelica.SIunits.MagneticPotentialDifference V_m2 = smee.excitation.reluctance.abs_V_m;
        Modelica.SIunits.MagneticPotentialDifference V_m3 = smeeQS.stator.strayReluctance.abs_V_m;
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        parameter Integer m=3 "Number of stator phases";
        parameter Modelica.SIunits.Voltage VsNominal=100 "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity w=Modelica.SIunits.Conversions.from_rpm(1499) "Nominal speed";
        parameter Modelica.SIunits.Current Ie=19 "Excitation current";
        parameter Modelica.SIunits.Current Ie0=10 "Initial excitation current";
        parameter Modelica.SIunits.Angle gamma0(displayUnit="deg")=0 "Initial rotor displacement angle";
        Modelica.SIunits.Angle thetaQS=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle, quasi static";
        Modelica.SIunits.Angle theta=rotorAngle.rotorDisplacementAngle "Rotor displacement angle, transient";

        output Modelica.SIunits.Power Ptr=powerSensor.power "Transient power";
        output Modelica.SIunits.Power Pqs=powerSensorQS.y.re "QS power";
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
          annotation (Placement(transformation(extent={{-50,-30},{-70,-10}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,-20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          final V=fill(VsNominal*sqrt(2), m),
          final freqHz=fill(fsNominal, m))
          annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));
        Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensor(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,-34})));
        Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBoxM(
            terminalConnection="Y", m=m)
          annotation (Placement(transformation(extent={{-10,-64},{10,-44}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee(
          phiMechanical(start=-(pi + gamma0)/smee.p, fixed=
                true),
          Jr=0.29,
          Js=0.29,
          p=2,
          fsNominal=smeeData.fsNominal,
          TsRef=smeeData.TsRef,
          alpha20s(displayUnit="1/K") = smeeData.alpha20s,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          alpha20r(displayUnit="1/K") = smeeData.alpha20r,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          alpha20e(displayUnit="1/K") = smeeData.alpha20e,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          ir(each fixed=true),
          useDamperCage=false,
          m=m,
          frictionParameters(PRef=0),
          Rs=smeeData.Rs*m/3,
          Lssigma=smeeData.Lssigma*m/3,
          Lmd=smeeData.Lmd*m/3,
          Lmq=smeeData.Lmq*m/3,
          effectiveStatorTurns=smeeData.effectiveStatorTurns,
          TsOperational=293.15,
          TrOperational=293.15,
          TeOperational=293.15,
          sigmae=smeeData.sigmae*m/3)
          annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
          smeeQS(
          p=2,
          fsNominal=smeeData.fsNominal,
          TsRef=smeeData.TsRef,
          alpha20s(displayUnit="1/K") = smeeData.alpha20s,
          Jr=0.29,
          Js=0.29,
          frictionParameters(PRef=0),
          statorCoreParameters(PRef=0, VRef=100),
          strayLoadParameters(PRef=0, IRef=100),
          Lrsigmad=smeeData.Lrsigmad,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          alpha20r(displayUnit="1/K") = smeeData.alpha20r,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          alpha20e(displayUnit="1/K") = smeeData.alpha20e,
          brushParameters(V=0, ILinear=0.01),
          Lrsigmaq=smeeData.Lrsigmaq,
          TrRef=smeeData.TrRef,
          useDamperCage=false,
          m=m,
          gammar(fixed=true, start=pi/2),
          gamma(fixed=true, start=-pi/2),
          Rs=smeeData.Rs*m/3,
          Lssigma=smeeData.Lssigma*m/3,
          Lmd=smeeData.Lmd*m/3,
          Lmq=smeeData.Lmq*m/3,
          TsOperational=293.15,
          effectiveStatorTurns=smeeData.effectiveStatorTurns,
          TrOperational=293.15,
          TeOperational=293.15)
          annotation (Placement(transformation(extent={{-10,20},{10,40}})));
        Modelica.Electrical.Analog.Basic.Ground groundr annotation (Placement(
              transformation(
              origin={-50,-88},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundrQS annotation (
            Placement(transformation(
              origin={-50,12},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
          duration=0.1,
          I=Ie - Ie0,
          offset=Ie0) annotation (Placement(transformation(
              origin={-30,-70},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentQS(
          duration=0.1,
          I=Ie - Ie0,
          offset=Ie0) annotation (Placement(transformation(
              origin={-28,30},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
          mechanicalPowerSensor annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
        Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
          mechanicalPowerSensorQS annotation (Placement(transformation(extent={{50,20},{70,40}})));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
            final w_fixed=w, useSupport=false) annotation (Placement(
              transformation(extent={{100,-80},{80,-60}})));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedQS(
            final w_fixed=w, useSupport=false) annotation (Placement(
              transformation(extent={{100,20},{80,40}})));
        parameter
          Modelica.Electrical.Machines.Utilities.SynchronousMachineData
          smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          xq=1.1,
          TsSpecification=293.15,
          TsRef=293.15,
          TrSpecification=293.15,
          TrRef=293.15,
          TeSpecification=293.15,
          TeRef=293.15) "Machine data"
          annotation (Placement(transformation(extent={{70,70},{90,90}})));

        Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
          voltageSourceQS(
          m=m,
          phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
          V=fill(VsNominal, m),
          f=fsNominal) annotation (Placement(transformation(
              origin={-30,80},
              extent={{-10,-10},{10,10}},
              rotation=180)));

        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
          annotation (Placement(transformation(
              origin={-60,80},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundeQS
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-90,80})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
          powerSensorQS(m=m) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,66})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(m=m,
            terminalConnection="Y")
          annotation (Placement(transformation(extent={{-10,36},{10,56}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starMachineQS(m=
              Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
              m)) annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={-20,50})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
          groundMachineQS annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,50})));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle(m=m, p=
              smee.p) annotation (Placement(transformation(
              origin={30,-70},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(m=m, p=
              smeeQS.p) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={30,30})));
        Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              origin={-50,-50},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starMachine(final m=
              Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
              m)) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                origin={-20,-50})));
      initial equation
        sum(smee.is) = 0;
        smee.is[1:2] = zeros(2);
      equation
        connect(star.pin_n, ground.p) annotation (Line(points={{-70,-20},{-80,-20}}, color={0,0,255}));
        connect(star.plug_p, sineVoltage.plug_n) annotation (Line(points={{-50,-20},{-40,-20}}, color={0,0,255}));
        connect(mechanicalPowerSensorQS.flange_b, constantSpeedQS.flange) annotation (Line(points={{70,30},{80,30}}));
        connect(rampCurrentQS.p, groundrQS.p) annotation (Line(points={{-28,20},{-34,20},{-34,12},{-40,12}}, color={0,0,255}));
        connect(rampCurrentQS.p, smeeQS.pin_en) annotation (Line(points={{-28,20},{-20,20},{-20,24},{-10,24}}, color={0,0,255}));
        connect(rampCurrentQS.n, smeeQS.pin_ep) annotation (Line(points={{-28,40},{-20,40},{-20,36},{-10,36}}, color={0,0,255}));
        connect(smee.flange, mechanicalPowerSensor.flange_a) annotation (Line(points={{10,-70},{50,-70}}));
        connect(mechanicalPowerSensor.flange_b, constantSpeed.flange) annotation (Line(points={{70,-70},{80,-70}}));
        connect(rampCurrent.p, groundr.p) annotation (Line(points={{-30,-80},{-36,-80},{-36,-88},{-38,-88},{-38,-88},{-40,-88},{-40,-88}}, color={0,0,255}));
        connect(rampCurrent.p, smee.pin_en) annotation (Line(points={{-30,-80},{-20,-80},{-20,-76},{-10,-76}}, color={0,0,255}));
        connect(rampCurrent.n, smee.pin_ep) annotation (Line(points={{-30,-60},{-20,-60},{-20,-64},{-10,-64}}, color={0,0,255}));
        connect(smee.plug_sn, terminalBoxM.plug_sn) annotation (Line(points={{-6,-60},{-6,-60}}, color={0,0,255}));
        connect(smee.plug_sp, terminalBoxM.plug_sp) annotation (Line(points={{6,-60},{6,-60}}, color={0,0,255}));
        connect(groundeQS.pin, starQS.pin_n) annotation (Line(points={{-80,80},{-80,80},{-70,80}}, color={85,170,255}));
        connect(starQS.plug_p, voltageSourceQS.plug_n) annotation (Line(points={{-50,80},{-50,80},{-40,80}}, color={85,170,255}));
        connect(voltageSourceQS.plug_p, powerSensorQS.currentP) annotation (Line(points={{-20,80},{-20,80},{0,80},{0,76}}, color={85,170,255}));
        connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (Line(points={{10,66},{10,76},{0,76}}, color={85,170,255}));
        connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(points={{-10,66},{-10,66},{-42,66},{-50,66},{-50,80}}, color={85,170,255}));
        connect(sineVoltage.plug_p, powerSensor.pc) annotation (Line(points={{-20,-20},{0,-20},{0,-24}}, color={0,0,255}));
        connect(powerSensor.pc, powerSensor.pv) annotation (Line(points={{0,-24},{10,-24},{10,-34}}, color={0,0,255}));
        connect(powerSensor.nv, star.plug_p) annotation (Line(points={{-10,-34},{-50,-34},{-50,-20}}, color={0,0,255}));
        connect(powerSensor.nc, terminalBoxM.plugSupply) annotation (Line(points={{0,-44},{0,-58}}, color={0,0,255}));
        connect(terminalBoxQS.plug_sn, smeeQS.plug_sn) annotation (Line(points={{-6,40},{-6,40}}, color={85,170,255}));
        connect(terminalBoxQS.plug_sp, smeeQS.plug_sp) annotation (Line(points={{6,40},{6,40}}, color={85,170,255}));
        connect(powerSensorQS.currentN, terminalBoxQS.plugSupply) annotation (Line(points={{0,56},{0,42}}, color={85,170,255}));
        connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(points={{-30,50},{-40,50}}, color={85,170,255}));
        connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (Line(points={{-10,50},{-10,42},{-10,42}}, color={85,170,255}));
        connect(smee.flange, rotorAngle.flange) annotation (Line(points={{10,-70},{20,-70}}));
        connect(rotorAngle.plug_p, smee.plug_sp) annotation (Line(points={{24,-60},{6,-60}}, color={0,0,255}));
        connect(smee.plug_sn, rotorAngle.plug_n) annotation (Line(points={{-6,-60},{-6,-54},{36,-54},{36,-60}}, color={0,0,255}));
        connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{6,40},{24,40}}, color={85,170,255}));
        connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{36,40},{36,46},{-6,46},{-6,40}}, color={85,170,255}));
        connect(smeeQS.flange, rotorAngleQS.flange) annotation (Line(points={{10,30},{20,30}}));
        connect(smeeQS.flange, mechanicalPowerSensorQS.flange_a) annotation (Line(points={{10,30},{50,30}}));
        connect(starMachine.pin_n,groundMachine. p) annotation (Line(points={{-30,-50},{-40,-50}}, color={0,0,255}));
        connect(starMachine.plug_p, terminalBoxM.starpoint) annotation (Line(points={{-10,-50},{-10,-54},{-10,-58},{-10,-58}},color={0,0,255}));
        annotation (experiment(StopTime=30,Interval=1E-3,Tolerance=1e-06));
      end Issue3075;
    end FundamentalWave;

    package QuasiStatic
      extends Modelica.Icons.ExamplesPackage;
      package FluxTubes "Library for modelling of quasi static electromagnetic devices with lumped magnetic networks"
        extends Modelica.Icons.ExamplesPackage;
        model Issue496 "Conversion test for #496"
          extends Modelica.Icons.Example;
          partial model PartialTwoPortsElementary "Partial component with two magnetic ports p and n for textual programming"
            extends Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PartialTwoPortsElementary;
          end PartialTwoPortsElementary;

          partial model PartialTwoPorts "Partial component with magnetic potential difference between two magnetic ports p and n and magnetic flux Phi from p to n"
            extends Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PartialTwoPorts;
          end PartialTwoPorts;

          partial model PartialFixedShape "Base class for flux tubes with fixed shape during simulation"
            extends Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PartialFixedShape;
          end PartialFixedShape;

          partial model PartialLeakage "Base class for leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"
            extends Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PartialLeakage;
          end PartialLeakage;
          annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/496\">#496</a>.
</p>
</html>"));
        end Issue496;
      end FluxTubes;

      package FundamentalWave "Library for magnetic fundamental wave effects in electric machines"
        extends Modelica.Icons.ExamplesPackage;
        model Issue496 "Conversion test for #496"
          extends Modelica.Icons.Example;
          partial model PartialTwoPort "Two magnetic ports for graphical modeling"
            extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPort;
          end PartialTwoPort;

          partial model PartialTwoPortExtended "Two magnetic ports for graphical modeling with additional variables"
            extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPortExtended;
          end PartialTwoPortExtended;

          partial model PartialTwoPortElementary "Two magnetic ports for textual modeling"
            extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPortElementary;
          end PartialTwoPortElementary;

          partial model BaseInductionMachine "Partial model for induction machine"
            extends Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.BaseClasses.PartialBasicMachine;
          end BaseInductionMachine;
          annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/496\">#496</a>.
</p>
</html>"));
        end Issue496;

        model Issue2993 "Conversion test for #2993"
          extends Modelica.Icons.Example;
          import C1 = Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter;
          import C2 = Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding;
          import C3 = Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding;
          annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2993\">#2993</a>.
</p>
</html>"));
        end Issue2993;
      end FundamentalWave;
    end QuasiStatic;
  end Magnetic;

  package Fluid
    extends Modelica.Icons.ExamplesPackage;
    model Issue813 "Conversion test for #813"
      extends Modelica.Icons.Example;
      package P1
        extends Modelica.Fluid.Icons.VariantLibrary;
      end P1;

      package P2
        extends Modelica.Fluid.Icons.BaseClassLibrary;
      end P2;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/813\">#813</a>.
</p>
</html>"));
    end Issue813;

    package Dissipation
      extends Modelica.Icons.ExamplesPackage;
      model Issue940 "Conversion test for #940"
        extends Modelica.Icons.Example;
        parameter Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Tjunction r1 = Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Tjunction(united_converging_crossection=false);
        record R
          extends Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Tjunction(united_converging_crossection=false);
        end R;
        parameter R r2;
        Boolean y[:] = {r1.united_converging_crossection, r2.united_converging_crossection};
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/940\">#940</a>.
</p>
</html>"));
      end Issue940;

      model Issue2780 "Conversion test for #2780"
        extends Modelica.Icons.Example;
        import Modelica.SIunits.ReynoldsNumber;
        parameter Real Re_check=2320 "Ideal transition point";
        parameter Real Re_lam_min=1000 "Start of transition";
        parameter Real Re_turb_leave=4000 "End of transition";
        parameter Real k=1e-5 "Relative roughness";
        parameter Real lambda_fric=0.4 "Darcy friction factor";

        parameter ReynoldsNumber Re_trans=
          Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_DP(
          Re_check,
          Re_lam_min,
          Re_turb_leave,
          k,
          lambda_fric);

        parameter Real lambda = Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_MFLOW(
          Re_check,
          Re_lam_min,
          Re_turb_leave,
          k)/Re_check^2 "Darcy friction factor";
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2780\">#2780</a>.
</p>
</html>"));
      end Issue2780;
    end Dissipation;
  end Fluid;

  package Mechanics
    extends Modelica.Icons.ExamplesPackage;

    package MultiBody
      extends Modelica.Icons.ExamplesPackage;
      model Issue194 "Conversion test for #194"
        extends Modelica.Icons.Example;
        inner Modelica.Mechanics.MultiBody.World world(
          gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity,
          mue=3.986004418e14);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end Issue194;

      function gravityAccelerationIssue194
        import Modelica.Mechanics.MultiBody.Types.GravityTypes;
        extends Modelica.Mechanics.MultiBody.Forces.Internal.standardGravityAcceleration(
          gravityType=GravityTypes.PointGravity,
          mue=3);
      annotation(Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end gravityAccelerationIssue194;

      model Issue813 "Conversion test for #813"
        extends Modelica.Icons.Example;
        inner Modelica.Mechanics.MultiBody.World world;
        model AbsoluteVelocity
          extends Modelica.Mechanics.MultiBody.Sensors.AbsoluteVelocity(tansformAbsoluteVector(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a));
        end AbsoluteVelocity;

        model RelativeVelocity
          extends Modelica.Mechanics.MultiBody.Sensors.RelativeVelocity(tansformRelativeVector(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a));
        end RelativeVelocity;
        AbsoluteVelocity absoluteVelocity;
        Modelica.Mechanics.MultiBody.Sensors.TansformAbsoluteVector transformAbsoluteVector;
        RelativeVelocity relativeVelocity;
        Modelica.Mechanics.MultiBody.Sensors.TansformRelativeVector transformRelativeVector;
        Modelica.Blocks.Sources.RealExpression realExpression(y=time);
      equation
        connect(world.frame_b,absoluteVelocity.frame_a);
        connect(transformAbsoluteVector.frame_a,world.frame_b);
        connect(relativeVelocity.frame_a,world.frame_b);
        connect(relativeVelocity.frame_b,world.frame_b);
        connect(transformRelativeVector.frame_a,world.frame_b);
        connect(transformRelativeVector.frame_b,world.frame_b);
        connect(realExpression.y,transformAbsoluteVector.r_in[1]);
        connect(realExpression.y,transformAbsoluteVector.r_in[2]);
        connect(realExpression.y,transformAbsoluteVector.r_in[3]);
        connect(realExpression.y,transformRelativeVector.r_in[1]);
        connect(realExpression.y,transformRelativeVector.r_in[2]);
        connect(realExpression.y,transformRelativeVector.r_in[3]);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/813\">#813</a>.
</p>
</html>"));
      end Issue813;

      model Issue2425 "Conversion test for #2425"
        extends Modelica.Icons.Example;
        inner Modelica.Mechanics.MultiBody.World world;
        Modelica.Mechanics.MultiBody.Sensors.Internal.ZeroForceAndTorque zeroForceAndTorque;
      equation
        connect(world.frame_b, zeroForceAndTorque.frame_a);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2425\">#2425</a>.
</p>
</html>"));
      end Issue2425;

      model Issue2653wheel "Conversion test for #2653 - Parts.RollingWheel"
        extends Modelica.Icons.Example;

        Modelica.Mechanics.MultiBody.Parts.RollingWheel wheel1(
          wheelRadius=0.3,
          wheelMass=2,
          wheel_I_axis=0.06,
          wheel_I_long=0.12,
          wheelColor={0,0,0});
        inner Modelica.Mechanics.MultiBody.World world;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2653\">#2653</a>.
</p>
</html>"));
      end Issue2653wheel;

      model Issue2653wheelSet "Conversion test for #2653 - Parts.RollingWheelSet"
        extends Modelica.Icons.Example;

        Modelica.Mechanics.MultiBody.Parts.RollingWheelSet wheelSet(
          wheelRadius=0.1,
          wheelMass=0.5,
          wheel_I_axis=0.01,
          wheel_I_long=0.02,
          wheelDistance=0.5,
          wheelWidth=0.01,
          wheelColor={0,0,0});
        Modelica.Mechanics.MultiBody.Parts.Body body(
          m=1,r_CM={0,0,0});
        inner Modelica.Mechanics.MultiBody.World world;
      equation
        connect(wheelSet.frameMiddle, body.frame_a);
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2653\">#2653</a>.
</p>
</html>"));
      end Issue2653wheelSet;

      model Issue2653joint "Conversion test for #2653 - Joints.RollingWheel"
        extends Modelica.Icons.Example;

        Modelica.Mechanics.MultiBody.Joints.RollingWheel rollingWheel(
          wheelRadius=0.5);
        Modelica.Mechanics.MultiBody.Parts.Body body(
          final r_CM={0,0,0}, final m=1);
      equation
        connect(rollingWheel.frame_a, body.frame_a);
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2653\">#2653</a>.
</p>
</html>"));
      end Issue2653joint;

      model Issue2653jointSet "Conversion test for #2653 - Joints.RollingWheelSet"
        extends Modelica.Icons.Example;

        Modelica.Mechanics.MultiBody.Joints.RollingWheelSet wheelSetJoint(
          wheelRadius=0.3,
          wheelDistance=0.7);
        Modelica.Mechanics.MultiBody.Parts.Body body2(
          final r_CM={0,0,0}, final m=1);
        Modelica.Mechanics.MultiBody.Parts.Body body1(
          final r_CM={0,0,0}, final m=1);
      equation
        connect(body1.frame_a, wheelSetJoint.frame1);
        connect(body2.frame_a, wheelSetJoint.frame2);
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2653\">#2653</a>.
</p>
</html>"));
      end Issue2653jointSet;

      package Issue2501Vector "Conversion tests for #2501 New vector visualization"
        extends Modelica.Icons.ExamplesPackage;
        model DoublePendulum "Simple double pendulum with two revolute joints and two bodies"

          extends Modelica.Icons.Example;
          inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
                transformation(extent={{-100,-96},{-80,-76}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange=true,phi(fixed=true),
              w(fixed=true)) annotation (Placement(transformation(extent={{-54,-70},{-34,-50}})));
          Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1)
            annotation (Placement(transformation(extent={{-54,-30},{-34,-10}})));
          Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06)
            annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(phi(fixed=true), w(
                fixed=true)) annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
          Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody2(r={0.5,0,0}, width=0.06)
            annotation (Placement(transformation(extent={{66,-70},{86,-50}})));
          Modelica.Mechanics.MultiBody.Sensors.CutForceAndTorque cutForceAndTorque(
              Nm_to_m=1)
            annotation (Placement(transformation(extent={{-28,-70},{-8,-50}})));
          Modelica.Mechanics.MultiBody.Sensors.Distance distance
            annotation (Placement(transformation(extent={{28,-100},{48,-80}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute3(
            useAxisFlange=true,
            phi(fixed=true),
            w(fixed=true)) annotation (Placement(transformation(extent={{-54,32},{-34,52}})));
          Modelica.Mechanics.Rotational.Components.Damper damper1(d=0.1)
            annotation (Placement(transformation(extent={{-54,72},{-34,92}})));
          Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody3(r={0.5,0,0}, width=0.06)
            annotation (Placement(transformation(extent={{0,32},{20,52}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute4(phi(fixed=true), w(
                fixed=true)) annotation (Placement(transformation(extent={{26,32},{46,52}})));
          Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody4(r={0.5,0,0}, width=0.06)
            annotation (Placement(transformation(extent={{66,32},{86,52}})));
          Modelica.Mechanics.MultiBody.Sensors.Distance distance1
            annotation (Placement(transformation(extent={{28,2},{48,22}})));
          Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce
            annotation (Placement(transformation(extent={{-14,66},{6,86}})));
          Modelica.Mechanics.MultiBody.Sensors.CutTorque cutTorque(Nm_to_m=1)
            annotation (Placement(transformation(extent={{16,66},{36,86}})));
          Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={0,1,0}) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-72,-32})));
        equation

          connect(damper.flange_b, revolute1.axis) annotation (Line(points={{-34,-20},
                  {-34,-40},{-44,-40},{-44,-50}}));
          connect(revolute1.support, damper.flange_a) annotation (Line(points={{-50,-50},
                  {-50,-40},{-54,-40},{-54,-20}}));
          connect(revolute2.frame_b, boxBody2.frame_a)
            annotation (Line(
              points={{46,-60},{66,-60}},
              color={95,95,95},
              thickness=0.5));
          connect(boxBody1.frame_b, revolute2.frame_a)
            annotation (Line(
              points={{20,-60},{26,-60}},
              color={95,95,95},
              thickness=0.5));
          connect(world.frame_b, revolute1.frame_a)
            annotation (Line(
              points={{-80,-86},{-64,-86},{-64,-60},{-54,-60}},
              color={95,95,95},
              thickness=0.5));
          connect(cutForceAndTorque.frame_a, revolute1.frame_b) annotation (Line(
              points={{-28,-60},{-34,-60}},
              color={95,95,95},
              thickness=0.5));
          connect(cutForceAndTorque.frame_b, boxBody1.frame_a) annotation (Line(
              points={{-8,-60},{0,-60}},
              color={95,95,95},
              thickness=0.5));
          connect(revolute1.frame_a, distance.frame_a) annotation (Line(
              points={{-54,-60},{-60,-60},{-60,-90},{28,-90}},
              color={95,95,95},
              thickness=0.5));
          connect(distance.frame_b, boxBody2.frame_b) annotation (Line(
              points={{48,-90},{96,-90},{96,-60},{86,-60}},
              color={95,95,95},
              thickness=0.5));
          connect(damper1.flange_b, revolute3.axis)
            annotation (Line(points={{-34,82},{-34,62},{-44,62},{-44,52}}));
          connect(revolute3.support, damper1.flange_a)
            annotation (Line(points={{-50,52},{-50,62},{-54,62},{-54,82}}));
          connect(revolute4.frame_b,boxBody4. frame_a)
            annotation (Line(
              points={{46,42},{66,42}},
              color={95,95,95},
              thickness=0.5));
          connect(boxBody3.frame_b,revolute4. frame_a)
            annotation (Line(
              points={{20,42},{26,42}},
              color={95,95,95},
              thickness=0.5));
          connect(revolute3.frame_a, distance1.frame_a) annotation (Line(
              points={{-54,42},{-60,42},{-60,12},{28,12}},
              color={95,95,95},
              thickness=0.5));
          connect(distance1.frame_b, boxBody4.frame_b) annotation (Line(
              points={{48,12},{96,12},{96,42},{86,42}},
              color={95,95,95},
              thickness=0.5));
          connect(revolute3.frame_b, cutForce.frame_a) annotation (Line(
              points={{-34,42},{-24,42},{-24,76},{-14,76}},
              color={95,95,95},
              thickness=0.5));
          connect(cutForce.frame_b, cutTorque.frame_a) annotation (Line(
              points={{6,76},{16,76}},
              color={95,95,95},
              thickness=0.5));
          connect(cutTorque.frame_b, boxBody3.frame_a) annotation (Line(
              points={{36,76},{38,76},{38,58},{-4,58},{-4,42},{0,42}},
              color={95,95,95},
              thickness=0.5));
          connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
              points={{-80,-86},{-76,-86},{-76,-42},{-72,-42}},
              color={95,95,95},
              thickness=0.5));
          connect(fixedTranslation.frame_b, distance1.frame_a) annotation (Line(
              points={{-72,-22},{-72,12},{28,12}},
              color={95,95,95},
              thickness=0.5));
          annotation (
            experiment(StopTime=3),
            Documentation(info="<html>
Demonstrates sensors visualization in vectors -
based on <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum\">DoublePendulum</a>.
</html>"));
        end DoublePendulum;

        model ForceAndTorque "Demonstrate usage of ForceAndTorque element with visualizations"
          extends Modelica.Icons.Example;
          inner Modelica.Mechanics.MultiBody.World world(animateGravity=false, defaultNm_to_m=120, defaultN_to_m=1200)
            annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
          Modelica.Mechanics.MultiBody.Parts.BodyCylinder body(r={1,0,0}, density=
                77000)
            annotation (Placement(transformation(extent={{0,-28},{20,-8}})));
          Modelica.Mechanics.MultiBody.Parts.Fixed fixed1(r={0,-0.5,0}, width=0.03)
            annotation (Placement(transformation(extent={{-100,-68},{-80,-48}})));
          Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(n={0,0,1},
              angle=30)
            annotation (Placement(transformation(extent={{-20,-98},{0,-78}})));
          Modelica.Mechanics.MultiBody.Forces.ForceAndTorque forceAndTorque(
            Nm_to_m=120,
            N_to_m=1200,
            forceDiameter=0.07,
            connectionLineDiameter=0.05,
            resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
            annotation (Placement(transformation(extent={{60,-8},{40,-28}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(
            n={0,1,0},
            phi(fixed=true),
            w(fixed=true)) annotation (Placement(transformation(
                origin={-20,-38},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Blocks.Sources.Constant torque[3](k={-100,100,0})
            annotation (Placement(transformation(
                origin={40,-68},
                extent={{10,-10},{-10,10}},
                rotation=270)));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(phi(fixed=true), w(
                fixed=true))
            annotation (Placement(transformation(extent={{-60,-68},{-40,-48}})));
          Modelica.Mechanics.MultiBody.Parts.Fixed fixed2(width=0.03, r={1.5,0.25,0})
            annotation (Placement(transformation(extent={{100,-28},{80,-8}})));
          Modelica.Blocks.Sources.Constant force[3](k={0,1000,0})
            annotation (Placement(transformation(
                origin={80,-68},
                extent={{10,-10},{-10,10}},
                rotation=270)));
          Modelica.Mechanics.MultiBody.Parts.BodyCylinder body1(r={1,0,0}, density=
                77000) annotation (Placement(transformation(extent={{2,72},{22,92}})));
          Modelica.Mechanics.MultiBody.Parts.Fixed fixed3(r={0,0.5,0}, width=0.03)
            annotation (Placement(transformation(extent={{-98,32},{-78,52}})));
          Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation1(n={0,0,1},
              angle=30)
            annotation (Placement(transformation(extent={{-18,2},{2,22}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute3(
            n={0,1,0},
            phi(fixed=true),
            w(fixed=true)) annotation (Placement(transformation(
                origin={-18,62},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Blocks.Sources.Constant torque1
                                                 [3](k={-100,100,0})
            annotation (Placement(transformation(
                origin={42,32},
                extent={{10,-10},{-10,10}},
                rotation=270)));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute4(phi(fixed=true), w(
                fixed=true))
            annotation (Placement(transformation(extent={{-58,32},{-38,52}})));
          Modelica.Mechanics.MultiBody.Parts.Fixed fixed4(width=0.03, r={1.5,1.25,1})
            annotation (Placement(transformation(extent={{102,72},{82,92}})));
          Modelica.Blocks.Sources.Constant force1
                                                [3](k={0,1000,0})
            annotation (Placement(transformation(
                origin={82,32},
                extent={{10,-10},{-10,10}},
                rotation=270)));
          Modelica.Mechanics.MultiBody.Forces.Torque torque2(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve,
              Nm_to_m=120) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={44,80})));
          Modelica.Mechanics.MultiBody.Forces.Force force2(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve,
              forceDiameter=0.05,
              N_to_m=1200) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={68,100})));
        equation
          connect(revolute2.frame_b, body.frame_a) annotation (Line(
              points={{-20,-28},{-20,-18},{0,-18}},
              color={95,95,95},
              thickness=0.5));
          connect(forceAndTorque.frame_b, body.frame_b)
            annotation (Line(
              points={{40,-18},{20,-18}},
              color={95,95,95},
              thickness=0.5));
          connect(fixed1.frame_b, revolute1.frame_a)
            annotation (Line(
              points={{-80,-58},{-60,-58}},
              color={95,95,95},
              thickness=0.5));
          connect(revolute1.frame_b, revolute2.frame_a)
            annotation (Line(
              points={{-40,-58},{-20,-58},{-20,-48}},
              color={95,95,95},
              thickness=0.5));
          connect(fixed2.frame_b, forceAndTorque.frame_a)
            annotation (Line(
              points={{80,-18},{60,-18}},
              color={95,95,95},
              thickness=0.5));
          connect(fixedRotation.frame_a, fixed1.frame_b) annotation (Line(
              points={{-20,-88},{-71,-88},{-71,-58},{-80,-58}},
              color={95,95,95},
              thickness=0.5));
          connect(forceAndTorque.frame_resolve, fixedRotation.frame_b) annotation (Line(
              points={{42,-28},{20,-28},{20,-88},{0,-88}},
              color={95,95,95},
              pattern=LinePattern.Dot,
              thickness=0.5));
          connect(force.y, forceAndTorque.force) annotation (Line(
              points={{80,-57},{80,-48},{58,-48},{58,-30}},
                                                       color={0,0,127}));
          connect(torque.y, forceAndTorque.torque) annotation (Line(
              points={{40,-57},{40,-48},{50,-48},{50,-30}},
                                                       color={0,0,127}));
          connect(revolute3.frame_b, body1.frame_a) annotation (Line(
              points={{-18,72},{-18,82},{2,82}},
              color={95,95,95},
              thickness=0.5));
          connect(fixed3.frame_b,revolute4. frame_a)
            annotation (Line(
              points={{-78,42},{-58,42}},
              color={95,95,95},
              thickness=0.5));
          connect(revolute4.frame_b,revolute3. frame_a)
            annotation (Line(
              points={{-38,42},{-18,42},{-18,52}},
              color={95,95,95},
              thickness=0.5));
          connect(fixedRotation1.frame_a, fixed3.frame_b) annotation (Line(
              points={{-18,12},{-69,12},{-69,42},{-78,42}},
              color={95,95,95},
              thickness=0.5));
          connect(body1.frame_b, torque2.frame_b) annotation (Line(
              points={{22,82},{26,82},{26,80},{34,80}},
              color={95,95,95},
              thickness=0.5));
          connect(torque2.torque, torque1.y) annotation (Line(points={{50,68},{50,56},
                  {42,56},{42,43}}, color={0,0,127}));
          connect(force2.frame_a, fixed4.frame_b) annotation (Line(
              points={{78,100},{80,100},{80,82},{82,82}},
              color={95,95,95},
              thickness=0.5));
          connect(force2.frame_b, torque2.frame_b) annotation (Line(
              points={{58,100},{32,100},{32,80},{34,80}},
              color={95,95,95},
              thickness=0.5));
          connect(force2.force, force1.y) annotation (Line(points={{74,88},{78,88},{
                  78,44},{82,44},{82,43}}, color={0,0,127}));
          connect(torque2.frame_resolve, force2.frame_resolve) annotation (Line(
              points={{40,70},{64,70},{64,90}},
              color={95,95,95},
              pattern=LinePattern.Dot));
          connect(torque2.frame_resolve, fixedRotation1.frame_b) annotation (Line(
              points={{40,70},{2,70},{2,12}},
              color={95,95,95},
              pattern=LinePattern.Dot));
          connect(torque2.frame_a, fixed4.frame_b) annotation (Line(
              points={{54,80},{68,80},{68,82},{82,82}},
              color={95,95,95},
              thickness=0.5));
          annotation (
            Documentation(info="<html>
Demonstrates conversion of visualization for ForceAndTorque elements, as well as for Force and Torque elements.
Based on <a href=\"modelica:/Modelica.Mechanics.MultiBody.Examples.Elementary.ForceAndTorque\">ForceAndTorque</a>,
but with denser material to slow down the visualization to human speed.
</html>"),   experiment(StopTime=1.01));
        end ForceAndTorque;

        model WorldForceAndTorque "Demonstrate usage of ForceAndTorque element"
          extends Modelica.Icons.Example;
          inner Modelica.Mechanics.MultiBody.World world(animateGravity=false, defaultNm_to_m=120, defaultN_to_m=1200)
            annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
          Modelica.Mechanics.MultiBody.Parts.BodyCylinder body(r={1,0,0}, density=
              77000)
            annotation (Placement(transformation(extent={{0,-28},{20,-8}})));
          Modelica.Mechanics.MultiBody.Parts.Fixed fixed1(r={0,-0.5,0}, width=0.03)
            annotation (Placement(transformation(extent={{-100,-68},{-80,-48}})));
          Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(n={0,0,1},
            angle=30)
            annotation (Placement(transformation(extent={{-20,-98},{0,-78}})));
          Modelica.Mechanics.MultiBody.Forces.WorldForceAndTorque forceAndTorque(
            Nm_to_m=120,
            N_to_m=1200,
            resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
            annotation (Placement(transformation(extent={{60,-8},{40,-28}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(
            n={0,1,0},
            phi(fixed=true),
            w(fixed=true)) annotation (Placement(transformation(
              origin={-20,-38},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Blocks.Sources.Constant torque[3](k={-100,100,0})
            annotation (Placement(transformation(
              origin={40,-68},
              extent={{10,-10},{-10,10}},
              rotation=270)));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(phi(fixed=true), w(
              fixed=true))
            annotation (Placement(transformation(extent={{-60,-68},{-40,-48}})));
          Modelica.Blocks.Sources.Constant force[3](k={0,1000,0})
            annotation (Placement(transformation(
              origin={80,-68},
              extent={{10,-10},{-10,10}},
              rotation=270)));
          Modelica.Mechanics.MultiBody.Parts.BodyCylinder body1(r={1,0,0}, density=
              77000) annotation (Placement(transformation(extent={{2,72},{22,92}})));
          Modelica.Mechanics.MultiBody.Parts.Fixed fixed3(r={0,0.5,0}, width=0.03)
            annotation (Placement(transformation(extent={{-98,32},{-78,52}})));
          Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation1(n={0,0,1},
            angle=30)
            annotation (Placement(transformation(extent={{-18,2},{2,22}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute3(
            n={0,1,0},
            phi(fixed=true),
            w(fixed=true)) annotation (Placement(transformation(
              origin={-18,62},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Blocks.Sources.Constant torque1
                               [3](k={-100,100,0})
            annotation (Placement(transformation(
              origin={42,32},
              extent={{10,-10},{-10,10}},
              rotation=270)));
          Modelica.Mechanics.MultiBody.Joints.Revolute revolute4(phi(fixed=true), w(
              fixed=true))
            annotation (Placement(transformation(extent={{-58,32},{-38,52}})));
          Modelica.Blocks.Sources.Constant force1
                              [3](k={0,1000,0})
            annotation (Placement(transformation(
              origin={82,32},
              extent={{10,-10},{-10,10}},
              rotation=270)));
          Modelica.Mechanics.MultiBody.Forces.WorldTorque torque2(resolveInFrame=
              Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve,
            Nm_to_m=120) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={44,80})));
          Modelica.Mechanics.MultiBody.Forces.WorldForce force2(resolveInFrame=
              Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve,
            N_to_m=1200) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={68,100})));
        equation
          connect(revolute2.frame_b, body.frame_a) annotation (Line(
            points={{-20,-28},{-20,-18},{0,-18}},
            color={95,95,95},
            thickness=0.5));
          connect(forceAndTorque.frame_b, body.frame_b)
            annotation (Line(
            points={{40,-18},{20,-18}},
            color={95,95,95},
            thickness=0.5));
          connect(fixed1.frame_b, revolute1.frame_a)
            annotation (Line(
            points={{-80,-58},{-60,-58}},
            color={95,95,95},
            thickness=0.5));
          connect(revolute1.frame_b, revolute2.frame_a)
            annotation (Line(
            points={{-40,-58},{-20,-58},{-20,-48}},
            color={95,95,95},
            thickness=0.5));
          connect(fixedRotation.frame_a, fixed1.frame_b) annotation (Line(
            points={{-20,-88},{-71,-88},{-71,-58},{-80,-58}},
            color={95,95,95},
            thickness=0.5));
          connect(forceAndTorque.frame_resolve, fixedRotation.frame_b) annotation (Line(
            points={{50,-28},{20,-28},{20,-88},{0,-88}},
            color={95,95,95},
            pattern=LinePattern.Dot,
            thickness=0.5));
          connect(force.y, forceAndTorque.force) annotation (Line(
            points={{80,-57},{80,-10},{62,-10},{62,-12}},
                                 color={0,0,127}));
          connect(torque.y, forceAndTorque.torque) annotation (Line(
            points={{40,-57},{40,-46},{62,-46},{62,-24}},
                                 color={0,0,127}));
          connect(revolute3.frame_b, body1.frame_a) annotation (Line(
            points={{-18,72},{-18,82},{2,82}},
            color={95,95,95},
            thickness=0.5));
          connect(fixed3.frame_b,revolute4. frame_a)
            annotation (Line(
            points={{-78,42},{-58,42}},
            color={95,95,95},
            thickness=0.5));
          connect(revolute4.frame_b,revolute3. frame_a)
            annotation (Line(
            points={{-38,42},{-18,42},{-18,52}},
            color={95,95,95},
            thickness=0.5));
          connect(fixedRotation1.frame_a, fixed3.frame_b) annotation (Line(
            points={{-18,12},{-69,12},{-69,42},{-78,42}},
            color={95,95,95},
            thickness=0.5));
          connect(body1.frame_b, torque2.frame_b) annotation (Line(
            points={{22,82},{26,82},{26,80},{34,80}},
            color={95,95,95},
            thickness=0.5));
          connect(torque2.torque, torque1.y) annotation (Line(points={{56,80},{56,56},
              {42,56},{42,43}}, color={0,0,127}));
          connect(force2.frame_b, torque2.frame_b) annotation (Line(
            points={{58,100},{32,100},{32,80},{34,80}},
            color={95,95,95},
            thickness=0.5));
          connect(force2.force, force1.y) annotation (Line(points={{80,100},{78,100},
              {78,44},{82,44},{82,43}}, color={0,0,127}));
          connect(torque2.frame_resolve, force2.frame_resolve) annotation (Line(
            points={{44,70},{68,70},{68,110}},
            color={95,95,95},
            pattern=LinePattern.Dot));
          connect(torque2.frame_resolve, fixedRotation1.frame_b) annotation (Line(
            points={{44,70},{2,70},{2,12}},
            color={95,95,95},
            pattern=LinePattern.Dot));
          annotation (
          Documentation(info="<html>
Demonstrates conversion of visualization for WorldForceAndTorque elements, as well as for WorldForce and WorldTorque elements.
Based on <a href=\"modelica:/Modelica.Mechanics.MultiBody.Examples.Elementary.ForceAndTorque\">ForceAndTorque</a>,
but using World-variants and with denser material to slow down the visualization to human speed.
</html>"),   experiment(StopTime=1.01));
        end WorldForceAndTorque;
      end Issue2501Vector;

      model Issue3177torus "Conversion test for #3177 - Visualizers.Torus"
        extends Modelica.Icons.Example;

        inner Modelica.Mechanics.MultiBody.World world;
        Modelica.Mechanics.MultiBody.Visualizers.Torus torus(
          ri=0.5,
          ro=0.1,
          n_ri=40,
          n_ro=20);
      equation
        connect(world.frame_b, torus.frame_a);

        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3177\">#3177</a>.
</p>
</html>"));
      end Issue3177torus;

      model Issue3177torusSurface "Conversion test for #3177 - Visualizers.Advanced.SurfaceCharacteristics.torus"
        extends Modelica.Icons.Example;

        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface surface(
          redeclare function surfaceCharacteristic =
            Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus (
              ri=0.6,
              ro=0.2,
              opening=0),
              nu=10,
              nv=10);

        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3177\">#3177</a>.
</p>
</html>"));

      end Issue3177torusSurface;

      model Issue3382 "Conversion test for #3382 - Visualizers.Ground"
        extends Modelica.Icons.Example;
        inner Modelica.Mechanics.MultiBody.World world;
        Modelica.Mechanics.MultiBody.Visualizers.Ground ground;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3382\">#3382</a>.
</p>
</html>"));
      end Issue3382;

      model Issue3534 "Conversion test for #3534"
        extends Modelica.Icons.Example;
        import Modelica.Mechanics.MultiBody.Types;
        parameter Types.Init initType = Types.Init.PositionVelocityAcceleration;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3534\">#3534</a>.
</p>
</html>"));
      end Issue3534;
    end MultiBody;

    package Rotational
      extends Modelica.Icons.ExamplesPackage;
      model Issue194 "Conversion test for #194"
        extends Modelica.Icons.Example;
        Modelica.Mechanics.Rotational.Components.Brake brake(mue_pos=[0,0.5], fn_max=1);
        Modelica.Mechanics.Rotational.Components.Clutch clutch(mue_pos=[0,0.5], fn_max=1);
        Modelica.Mechanics.Rotational.Components.OneWayClutch oneWayClutch(mue_pos=[0,0.5], fn_max=1);
        Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1);
        Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1);
        Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1);
        Modelica.Blocks.Sources.Constant const(k=1);
      equation
        connect(brake.flange_b, inertia.flange_a);
        connect(inertia.flange_b, clutch.flange_a);
        connect(clutch.flange_b, inertia1.flange_a);
        connect(inertia.flange_b, oneWayClutch.flange_a);
        connect(oneWayClutch.flange_b, inertia2.flange_a);
        connect(const.y, brake.f_normalized);
        connect(const.y, clutch.f_normalized);
        connect(const.y, oneWayClutch.f_normalized);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end Issue194;

      model Issue2863 "Conversion test for #2863"
        extends Modelica.Icons.Example;
        Modelica.Mechanics.Rotational.Sources.SignTorque signTorque(tau_constant=123, w0=0.1);
        Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1, phi(fixed=true, start=0), w(fixed=true, start=1));
      equation
        connect(signTorque.flange, inertia.flange_a);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2863\">#2863</a>.
</p>
</html>"));
      end Issue2863;

      model Issue3040 "Conversion test for #3040"
        extends Modelica.Icons.Example;
        import C1 = Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport;
        import C2 = Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3040\">#3040</a>.
</p>
</html>"));
      end Issue3040;
    end Rotational;

    package Translational
      extends Modelica.Icons.ExamplesPackage;
      model Issue194 "Conversion test for #194"
        extends Modelica.Icons.Example;
        Modelica.Mechanics.Translational.Components.Brake brake(
          mue_pos=[0,0.5], fn_max=1);
        Modelica.Mechanics.Translational.Components.Mass mass(m=1);
        Modelica.Blocks.Sources.Constant const(k=1);
      equation
        connect(brake.flange_b, mass.flange_a);
        connect(const.y, brake.f_normalized);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end Issue194;

      model Issue3040 "Conversion test for #3040"
        extends Modelica.Icons.Example;
        import C1 = Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport;
        import C2 = Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3040\">#3040</a>.
</p>
</html>"));
      end Issue3040;
    end Translational;
  end Mechanics;

  package Math
    extends Modelica.Icons.ExamplesPackage;
    model Issue813 "Conversion test for #813"
      extends Modelica.Icons.Example;
      constant Real table[:,:] = [0,0,0;1,2,4];
      Real y1 = Modelica.Math.tempInterpol1(0.5, table, 2);
      Real y2[1,2] = Modelica.Math.tempInterpol2(0.5, table, {2,3});
      function f1
        extends Modelica.Math.baseIcon1;
        input Real x1;
        output Real y;
      algorithm
          y := x1;
      end f1;

      function f2
        extends Modelica.Math.baseIcon2;
        input Real x2[1,2];
        output Real y;
      algorithm
          y := sum(x2[1,:]);
      end f2;
      Real y = f1(y1) + f2(y2);
    annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/813\">#813</a>.
</p>
</html>"));
    end Issue813;

    model Issue978 "Conversion test for #978"
      extends Modelica.Icons.Example;
      import Polynomials = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
      parameter Real p1[:] = {-2, -3, -4, -1};
      Real p2[size(p1, 1) + 1] = Polynomials.integral(p1);
      Real p3[size(p1, 1)] = Polynomials.derivative(p2);
      Real r;
    algorithm
      r := Polynomials.evaluate(p1, -3);
      r := Polynomials.derivativeValue(p2, r);
      r := Polynomials.evaluate(p3, r);
      r := Polynomials.integralValue(p1, 2, 1);
    annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/978\">#978</a>.
</p>
</html>"));
    end Issue978;

    model Issue2857 "Conversion test for #2857"
      extends Modelica.Icons.Example;
      Real A[3,3] = [1,2,3; 3,4,5; 2,1,4];
      Real R[3,3] = Modelica.Math.Matrices.LAPACK.dgeqpf(A);
      Real X[3,3];
      Real r[3];
      Real i[3];
      Real b[3];
      Real x[3];
    algorithm
      (r, i, b) := Modelica.Math.Matrices.LAPACK.dgegv(A, identity(3));
      X := Modelica.Math.Matrices.LAPACK.dgelsx(A, identity(3));
      x := Modelica.Math.Matrices.LAPACK.dgelsx_vec(A, {1,0,0});
    annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2857\">#2857</a>.
</p>
</html>"));
    end Issue2857;

    model Issue3002_roots "Conversion test for #3002"
      extends Modelica.Icons.Example;
      Real r[2,2];
    algorithm
      r := Modelica.Math.Vectors.Utilities.roots({1,0,-1});
    annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3002\">#3002</a>.
</p>
</html>"));
    end Issue3002_roots;

    model Issue3002_householder "Conversion test for #3002"
      extends Modelica.Icons.Example;
      function f1 = Modelica.Math.Matrices.Utilities.householderReflection;
      function f2 = Modelica.Math.Matrices.Utilities.householderSimilarityTransformation;
      function f3 = Modelica.Math.Vectors.Utilities.householderReflection;
      function f4 = Modelica.Math.Vectors.Utilities.householderVector;
    annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3002\">#3002</a>.
</p>
</html>"));
    end Issue3002_householder;
  end Math;

  package ComplexMath
    extends Modelica.Icons.ExamplesPackage;
    model Issue883 "Conversion test for #883"
      extends Modelica.Icons.Example;
      import Modelica.ComplexMath.'abs';
      parameter Complex c1 = Complex(sqrt(2)/2, sqrt(2)/2);
      parameter Complex c2 = Complex(-sqrt(2)/2, -sqrt(2)/2);
      Real r = 'abs'(c1);
      Complex c3 = Modelica.ComplexMath.'sqrt'(c1);
      Complex c4 = Modelica.ComplexMath.'max'({c1, c2});
      Complex c5 = Modelica.ComplexMath.'min'({c1, c2});
      Complex c6 = Modelica.ComplexMath.'sum'({c1, c2});
      Complex c7 = Modelica.ComplexMath.'product'({c1, c2});
      Real n = Modelica.ComplexMath.Vectors.norm({c1, c2});
    annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/883\">#883</a>.
</p>
</html>"));
    end Issue883;
  end ComplexMath;

  package Media
    extends Modelica.Icons.ExamplesPackage;
    model Issue2491 "Conversion test for #2491"
      extends Modelica.Icons.Example;
      package Medium = Modelica.Media.IdealGases.MixtureGases.simpleMoistAir "Medium model";
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2491\">#2491</a>.
</p>
</html>"));
    end Issue2491;

    model Issue3037 "Conversion test for #3037"
      extends Modelica.Icons.Example;
      Modelica.Media.Interfaces.PartialMedium.Choices.IndependentVariables c1 = Modelica.Media.Interfaces.PartialMedium.Choices.IndependentVariables.T;
      Modelica.Media.Interfaces.PartialMedium.Choices.Init c2 = Modelica.Media.Interfaces.PartialMedium.Choices.Init.NoInit;
      Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEnthalpy c3 = Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEnthalpy.UserDefined;
      Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEntropy c4 = Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEntropy.UserDefined;
      Modelica.Media.Interfaces.PartialMedium.Choices.pd c5 = Modelica.Media.Interfaces.PartialMedium.Choices.pd.default;
      Modelica.Media.Interfaces.PartialMedium.Choices.Th c6 = Modelica.Media.Interfaces.PartialMedium.Choices.Th.default;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3037\">#3037</a>.
</p>
</html>"));
    end Issue3037;

    model Issue3205 "Conversion test for #3205"
      extends Modelica.Icons.Example;

      parameter Real y_zero=0.5 "Desired value of A*sin(w*x)";
      parameter Real x_min=-1.7 "Minimum value of x_zero";
      parameter Real x_max=1.7 "Maximum value of x_zero";
      parameter Real A=1 "Amplitude of sine";
      parameter Real w=1 "Angular frequency of sine";
      parameter Inverse_sine_definition.f_nonlinear_Data data=
        Inverse_sine_definition.f_nonlinear_Data(A=A, w=w) "Data record";
      Real x_zero "y_zero = A*sin(w*x_zero)";

      package Inverse_sine_definition "Define sine as non-linear equation to be solved"
        extends Modelica.Media.Common.OneNonLinearEquation;

        redeclare record extends f_nonlinear_Data "Data for non-linear equation"
          Real A "Amplitude";
          Real w "Angular frequency";
        end f_nonlinear_Data;

        redeclare function extends f_nonlinear "Non-linear equation to be solved"
        algorithm
          y := f_nonlinear_data.A*Modelica.Math.sin(f_nonlinear_data.w*x);
        end f_nonlinear;

        // Dummy definition had to be added for older Dymola
        redeclare function extends solve "Solution algorithm of non-linear equation"
        end solve;
      end Inverse_sine_definition;

    equation
      x_zero = Inverse_sine_definition.solve(y_zero, x_min, x_max, f_nonlinear_data=data);

      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3205\">#3205</a>.
</p>
</html>"));
    end Issue3205;
  end Media;

  package Thermal
    extends Modelica.Icons.ExamplesPackage;
    package HeatTransfer
      extends Modelica.Icons.ExamplesPackage;
      model Issue1202 "Conversion test for #1202"
        extends Modelica.Icons.Example;
        Modelica.Thermal.HeatTransfer.Rankine.ToKelvin toKelvin(n=1);
        Modelica.Thermal.HeatTransfer.Rankine.FromKelvin fromKelvin1(n=2);
        Modelica.Thermal.HeatTransfer.Fahrenheit.FromKelvin fromKelvin2(n=-3);
        Modelica.Blocks.Sources.Constant const(k=10);
      equation
        connect(const.y, fromKelvin1.Kelvin);
        connect(const.y, toKelvin.Rankine);
        connect(const.y, fromKelvin2.Kelvin);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1202\">#1202</a>.
</p>
</html>"));
      end Issue1202;
    end HeatTransfer;

    package FluidHeatFlow
      extends Modelica.Icons.ExamplesPackage;
      model Issue194 "Conversion test for #194"
        extends Modelica.Icons.Example;
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium r1 = Modelica.Thermal.FluidHeatFlow.Media.Medium(nue=2);
        record R
          extends Modelica.Thermal.FluidHeatFlow.Media.Medium(nue=3);
        end R;
        parameter R r2;
        Real y[:] = {r1.nue, r2.nue};
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end Issue194;

      model Issue194_Derived "Conversion test for #194 for derived classes"
        extends Modelica.Icons.Example;
        parameter Modelica.Thermal.FluidHeatFlow.Media.Air_30degC r1 = Modelica.Thermal.FluidHeatFlow.Media.Air_30degC(nue=2);
        record R
          extends Modelica.Thermal.FluidHeatFlow.Media.Air_30degC(nue=3);
        end R;
        parameter R r2(nue=4); // This tests that user-defined inheritance works
        Real y[:] = {r1.nue, r2.nue};
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end Issue194_Derived;

      model Issue813 "Conversion test for #813"
        extends Modelica.Icons.Example;
        model Ambient "Ambient with constant properties"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.Ambient(final T0fixed=false);
          parameter Modelica.SIunits.Pressure pAmbient(start=0) "Ambient pressure";
          parameter Modelica.SIunits.Temperature TAmbient(start=293.15, displayUnit="degC") "Ambient temperature";
        equation
          flowPort.p = pAmbient;
          T = TAmbient;
        end Ambient;
        Modelica.Thermal.FluidHeatFlow.Components.IsolatedPipe isolatedPipe(
          m=1,
          T0=293.15,
          V_flowLaminar=0.1,
          dpLaminar=10000,
          V_flowNominal=1,
          dpNominal=100000,
          h_g=1) annotation(Placement(transformation(extent={{-36,34},{-16,54}})));
        Ambient ambient(
          pAmbient=100000,
          TAmbient=293.15) annotation(Placement(transformation(extent={{6,34},{26,54}})));
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(
          m=1,
          T0=293.15,
          V_flowLaminar=0.1,
          dpLaminar=10000,
          V_flowNominal=1,
          dpNominal=100000,
          h_g=1) annotation(Placement(transformation(extent={{-38,2},{-18,22}})));
      equation
        connect(ambient.flowPort, isolatedPipe.flowPort_b) annotation(Line(points={{6,44},{-16,44}}, color={255,0,0}));
        connect(heatedPipe.flowPort_b, ambient.flowPort) annotation(Line(points={{-18,12},{-8,12},{-8,44},{6,44}}, color={255,0,0}));
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/813\">#813</a>.
</p>
</html>"));
      end Issue813;

      model Issue940 "Conversion test for #940"
        extends Modelica.Icons.Example;
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium r1 = Modelica.Thermal.FluidHeatFlow.Media.Medium(lamda=2);
        record R
          extends Modelica.Thermal.FluidHeatFlow.Media.Medium(lamda=3);
        end R;
        parameter R r2;
        Real y[:] = {r1.lamda, r2.lamda};
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/940\">#940</a>.
</p>
</html>"));
      end Issue940;

      package Issue2479 "Conversion test for #2479"
        extends Modelica.Icons.ExamplesPackage;
        partial model SinglePortLeft "Partial model of a single port at the left"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortLeft;
          annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
        end SinglePortLeft;

        partial model SinglePortBottom "Partial model of a single port at the bottom"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortBottom;
          annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
        end SinglePortBottom;

        partial model TwoPort "Partial model of two port"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort;
          annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
        end TwoPort;

        partial model SimpleFriction "Simple friction model"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SimpleFriction;
          annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
        end SimpleFriction;

        partial model Ambient "Partial model of ambient"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.Ambient;
          annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
        end Ambient;

        partial model AbsoluteSensor "Partial model of absolute sensor"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.AbsoluteSensor;
          annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
        end AbsoluteSensor;

        partial model RelativeSensor "Partial model of relative sensor"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.RelativeSensor;
          annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
        end RelativeSensor;

        partial model FlowSensor "Partial model of flow sensor"
          extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.FlowSensor;
          annotation (Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
        end FlowSensor;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a>.
</p>
</html>"));
      end Issue2479;
    end FluidHeatFlow;
  end Thermal;

  package Icons
    extends Modelica.Icons.ExamplesPackage;
    model Issue340 "Conversion test for #340"
      extends Modelica.Icons.Example;
      package P1
        extends Modelica.Icons.Library;
      end P1;

      package P2
        extends Modelica.Icons.Library2;
      end P2;

      package P3
        extends Modelica.Icons.GearIcon;
      end P3;

      package P4
        extends Modelica.Icons.MotorIcon;
      end P4;

      package P5
        extends Modelica.Icons.Info;
      end P5;

      package P6
        extends Modelica.Mechanics.MultiBody.Icons.MotorIcon;
      end P6;

      package P7
        extends Modelica.Icons.RotationalSensor;
      end P7;

      package P8
        extends Modelica.Icons.TranslationalSensor;
      end P8;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/340\">#340</a>.
</p>
</html>"));
    end Issue340;

    model Issue3036 "Conversion test for #3036"
      extends Modelica.Icons.Example;
      Modelica.Icons.TypeComplex c = Modelica.Icons.TypeComplex(0, 1);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3036\">#3036</a>.
</p>
</html>"));
    end Issue3036;
  end Icons;

  package SIunits
    extends Modelica.Icons.ExamplesPackage;
    model Issue147 "Conversion test for #147"
      extends Modelica.Icons.Example;
      Modelica.SIunits.RadiantExtiance x(displayUnit="W/cm2") = 1;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/147\">#147</a>.
</p>
</html>"));
    end Issue147;

    model Issue385 "Conversion test for #385"
      extends Modelica.Icons.Example;
      Modelica.SIunits.FluxiodQuantum x(displayUnit="Wb") = 1;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/385\">#385</a>.
</p>
</html>"));
    end Issue385;

    model Issue415 "Conversion test for #415"
      extends Modelica.Icons.Example;
      function f
        extends Modelica.SIunits.Conversions.ConversionIcon;
        input Real x;
        output Real y;
      algorithm
          y := x;
      end f;
      Real y = f(time);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/415\">#415</a>.
</p>
</html>"));
    end Issue415;

    model Issue712 "Conversion test for #712"
      extends Modelica.Icons.Example;
      Modelica.SIunits.Temp_C x = 1;
      Modelica.SIunits.Temp_K y = 2;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/712\">#712</a>.
</p>
</html>"));
    end Issue712;

    model Issue1159 "Conversion test for #1159"
      extends Modelica.Icons.Example;
      Modelica.SIunits.LoundnessLevel x(displayUnit="phon") = 1;
      Modelica.SIunits.Loundness y(displayUnit="sone") = 1;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1159\">#1159</a>.
</p>
</html>"));
    end Issue1159;

    model Issue2944 "Conversion test for #2944"
      extends Modelica.Icons.Example;
      Modelica.SIunits.Conversions.NonSIunits.FirstOrderTemperaturCoefficient x = 1;
      Modelica.SIunits.Conversions.NonSIunits.SecondOrderTemperaturCoefficient y = 2;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2944\">#2944</a>.
</p>
</html>"));
    end Issue2944;

    model Issue3517 "Conversion test for #3517"
      extends Modelica.Icons.Example;
      import SI = Modelica.SIunits;
      parameter SI.Conversions.NonSIunits.Time_minute p = SI.Conversions.to_minute(42);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3517\">#3517</a>.
</p>
</html>"));
    end Issue3517;
  end SIunits;
  annotation(uses(Modelica(version="3.2.3"), Complex(version="3.2.3")), Documentation(info="<html>
<p>
This library provides models and functions to test the MSL v4.0.0 conversion script \"ConvertModelica_from_3.2.3_to_4.0.0.mos\"
for conversion of Modelica libraries using MSL v3.x.y to MSL v4.0.0. These models are not meant to be meaningful otherwise.
</p>

<p>
Copyright &copy; 2019-2020, Modelica Association and contributors
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"));
end ModelicaTestConversion4;
