package ModelicaTestConversion4
  extends Modelica.Icons.ExamplesPackage;
  package Blocks
    extends Modelica.Icons.ExamplesPackage;
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
    end Machines;
  end Electrical;

  package Fluid
    extends Modelica.Icons.ExamplesPackage;
    package Dissipation
      extends Modelica.Icons.ExamplesPackage;
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
  end Math;

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
  end Thermal;

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
  end SIunits;
  annotation(uses(Modelica(version="3.2.3")));
end ModelicaTestConversion4;
