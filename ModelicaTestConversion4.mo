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

    model Issue2441 "Conversion test for #2441"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Tables.CombiTable1D table1(table=[0,0;0,1]);
      Modelica.Blocks.Tables.CombiTable2D table2(table=[0,0;0,1]);
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
      Modelica.Blocks.Continuous.PID pid4(initType=Modelica.Blocks.Types.InitPID(3), Td=0.5, Ti=0.5);
      Modelica.Blocks.Continuous.PID pid5(initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState, Td=0.5, Ti=0.5);
      Modelica.Blocks.Continuous.PID pid6(initType=Modelica.Blocks.Types.InitPID.NoInit, Td=0.5, Ti=0.5);
      Modelica.Blocks.Sources.Clock clock;
    equation
      connect(clock.y, pid1.u_s);
      connect(clock.y, pid1.u_m);
      connect(clock.y, pid2.u_s);
      connect(clock.y, pid2.u_m);
      connect(clock.y, pid3.u_s);
      connect(clock.y, pid3.u_m);
      connect(clock.y, pid4.u);
      connect(clock.y, pid5.u);
      connect(clock.y, pid6.u);
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
  end Blocks;

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

      model Issue2899 "Conversion test for #2899"
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
      end Issue2899;
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
    end QuasiStatic;

    package Machines
      extends Modelica.Icons.ExamplesPackage;
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
        model M = Modelica.Electrical.Machines.BasicMachines.Components.BasicTransformer;
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2929\">#2929</a>.
</p>
</html>"));
      end Issue2929;
    end Machines;

    package Spice3
      extends Modelica.Icons.ExamplesPackage;
      model Issue940 "Conversion test for #940"
        function f
          extends Modelica.Electrical.Spice3.Internal.Functions.junctionParamDepTempSPICE3;
          output Real dummy = jucntioncap*2;
        end f;
        Real y;
        parameter Modelica.Electrical.Spice3.Internal.Mosfet.Mosfet r1 = Modelica.Electrical.Spice3.Internal.Mosfet.Mosfet(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, true);
        parameter Modelica.Electrical.Spice3.Internal.Mosfet.Mosfet r2 = Modelica.Electrical.Spice3.Internal.Mosfet.Mosfet(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, m_drainPerimiter=19, m_sourcePerimiter=20, m_uic=true);
      equation
        (, y) = f(1, 2, 3, 4, 5);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/940\">#940</a>.
</p>
</html>"));
      end Issue940;
    end Spice3;
  end Electrical;

  package Fluid
    extends Modelica.Icons.ExamplesPackage;
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
  end Math;

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
    end FluidHeatFlow;
  end Thermal;

  package Icons
    extends Modelica.Icons.ExamplesPackage;
    model Issue813 "Conversion test for #813"
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
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/813\">#813</a>.
</p>
</html>"));
    end Issue813;
  end Icons;

  package SIunits
    extends Modelica.Icons.ExamplesPackage;
    model Issue385 "Conversion test for #385"
      extends Modelica.Icons.Example;
      Modelica.SIunits.FluxiodQuantum x(displayUnit="Wb") = 1;
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/385\">#385</a>.
</p>
</html>"));
    end Issue385;

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
  end SIunits;
  annotation(uses(Modelica(version="3.2.3")));
end ModelicaTestConversion4;
