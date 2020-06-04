within ;
package ModelicaTestOverdetermined
  extends Modelica.Icons.Package;
  package ConsistentInitialization
    "Test cases of systems with overdetermined initialization problems due to index reduction"
    extends Modelica.Icons.ExamplesPackage;

    package Fluid "Test cases with Fluid systems"
    extends Modelica.Icons.ExamplesPackage;
      model DynamicPipeLumpedPressureInitialization
        "Steady-state initialization of a dynamic pipe using lumped pressure states"
        extends Modelica.Icons.Example;

        Modelica.Fluid.Sources.FixedBoundary source(nPorts=1,
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T=false,
          h=2.5e6,
          p=system.p_start)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Fluid.Pipes.DynamicPipe pipe(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          diameter=0.05,
          length=200,
          use_T_start=false,
          useLumpedPressure=true,
          nNodes=5,
          modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
          h_start=2.5e6)
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Modelica.Fluid.Valves.ValveCompressible valve(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          m_flow_nominal=10,
          rho_nominal=60,
          CvData=Modelica.Fluid.Types.CvTypes.Av,
          Av=0.05^2/4*Modelica.Constants.pi,
          dp_nominal=100000,
          p_nominal=10000000)
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Fluid.Sources.FixedBoundary sink(nPorts=1,redeclare package
            Medium =
              Modelica.Media.Water.StandardWaterOnePhase, p=9500000)
                    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
        Modelica.Blocks.Sources.Ramp ramp(
          offset=1,
          startTime=2,
          duration=0,
          height=-0.8)
                    annotation (Placement(transformation(extent={{46,30},{26,50}})));
        inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
          use_eps_Re=true,
          p_start=10000000)
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
        discrete Modelica.Units.SI.MassFlowRate m_flow_initial;
      equation
        when time > 0.1 then
          m_flow_initial = valve.port_a.m_flow;
        end when;
        if pipe.energyDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial and
           pipe.massDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
          when time > 1 then
            assert(abs(valve.port_a.m_flow - m_flow_initial) < 1e-3, "!!!THE SIMULATION DID NOT START IN STEADY-STATE!!!");
          end when;
        end if;
        connect(source.ports[1], pipe.port_a)         annotation (Line(
            points={{-60,0},{-55,0},{-55,0},{-50,
                0},{-50,0},{-40,0}}, color={0,127,255}));
        connect(pipe.port_b, valve.port_a)               annotation (Line(
            points={{-20,0},{-15,0},{-15,0},{-10,
                0},{-10,0},{0,0}}, color={0,127,255}));
        connect(valve.port_b, sink.ports[1])                          annotation (Line(
            points={{20,0},{25,0},{25,0},{30,
                0},{30,0},{40,0}}, color={0,127,255}));
        connect(ramp.y, valve.opening)               annotation (Line(
            points={{25,40},{10,40},{10,8}}, color={0,0,127}));

        annotation (Documentation(info="<html>
All pressure states of the pipe are lumped into one.
The steady-state initial conditions become overdetermined as they are now specified nNodes times for the same pressure state.
The initial equations are consistent however and a tool shall reduce them appropriately.
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,
                extent={{-100,-100},{100,100}}), graphics={Text(
                extent={{-100,-20},{100,-40}},
                textColor={0,0,255},
                textString=
                    "Problem: pipe.medium.p[1:5] are equal and have initial equations der(medium.p)=zeros(5);"),
                Text(
                extent={{-76,-40},{80,-58}},
                textColor={0,0,255},
                textString=
                    "A translator should remove consistently overdetermined initial equations.")}),
          experiment(StopTime=4));
      end DynamicPipeLumpedPressureInitialization;

      model DynamicPipeInitialValues
        "Initialization of a dynamic pipe with fixed initial values and without adaptation of modelStructure to boundaries"
        extends Modelica.Icons.Example;

        Modelica.Fluid.Sources.FixedBoundary source(nPorts=1,
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T=false,
          h=2.5e6,
          p=system.p_start)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Fluid.Pipes.DynamicPipe pipe(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          diameter=0.05,
          length=200,
          use_T_start=false,
          nNodes=5,
          modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
          h_start=2.5e6)
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Modelica.Fluid.Valves.ValveCompressible valve(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          m_flow_nominal=10,
          rho_nominal=60,
          CvData=Modelica.Fluid.Types.CvTypes.Av,
          Av=0.05^2/4*Modelica.Constants.pi,
          dp_nominal=100000,
          p_nominal=10000000)
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Fluid.Sources.FixedBoundary sink(nPorts=1,redeclare package
            Medium =
              Modelica.Media.Water.StandardWaterOnePhase, p=9500000)
                    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
        Modelica.Blocks.Sources.Ramp ramp(
          offset=1,
          startTime=2,
          duration=0,
          height=-0.8)
                    annotation (Placement(transformation(extent={{46,30},{26,50}})));
        inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
          p_start=10000000,
          use_eps_Re=true)
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
        discrete Modelica.Units.SI.MassFlowRate m_flow_initial;
      equation
        when time > 0.1 then
          m_flow_initial = valve.port_a.m_flow;
        end when;
        if pipe.energyDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial and
           pipe.massDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
          when time > 1 then
            assert(abs(valve.port_a.m_flow - m_flow_initial) < 1e-3, "!!!THE SIMULATION DID NOT START IN STEADY-STATE!!!");
          end when;
        end if;
        connect(source.ports[1], pipe.port_a)         annotation (Line(
            points={{-60,0},{-55,0},{-55,0},{-50,
                0},{-50,0},{-40,0}}, color={0,127,255}));
        connect(pipe.port_b, valve.port_a)               annotation (Line(
            points={{-20,0},{-15,0},{-15,0},{-10,
                0},{-10,0},{0,0}}, color={0,127,255}));
        connect(valve.port_b, sink.ports[1])                          annotation (Line(
            points={{20,0},{25,0},{25,0},{30,
                0},{30,0},{40,0}}, color={0,127,255}));
        connect(ramp.y, valve.opening)               annotation (Line(
            points={{25,40},{10,40},{10,8}}, color={0,0,127}));
        annotation (Documentation(info="<html>
The initial values are overdetermined as the first pipe segment is directly connected to a source with fixed pressure.
The initial equations are consistent however and a tool shall reduce them appropriately.
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false,
                extent={{-100,-100},{100,100}}), graphics={
              Text(
                extent={{-100,-20},{100,-40}},
                textColor={0,0,255},
                textString=
                    "Problem: pipe.medium[1].p is equal to source.p and  has a consistent initial value  of system.p_start = 100 bar;"),
              Text(
                extent={{-76,-36},{76,-54}},
                textColor={0,0,255},
                textString=
                    "A translator should remove consistently overdetermined initial equations."),
              Text(
                extent={{-100,-64},{90,-84}},
                textColor={0,0,255},
                textString=
                    "Work-around 2: change system.energyDynamics from FixedInitial to DynamicFreeInitial"),
              Text(
                extent={{-100,-54},{42,-74}},
                textColor={0,0,255},
                textString=
                    "Work-around 1: change pipe.modelStructure from av_vb to a_vb")}),
          experiment(StopTime=4));
      end DynamicPipeInitialValues;

      model DynamicPipesSeriesSteadyStateInitial
        "Two series-connected pipes with steady-state initial condition, overedetermined initialization due to pressure states at the ports"
        extends Modelica.Icons.Example;

        Modelica.Fluid.Sources.FixedBoundary source(nPorts=1,
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T=false,
          h=2.5e6,
          p=system.p_start)
          annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
        Modelica.Fluid.Pipes.DynamicPipe pipe1(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          length=200,
          use_T_start=false,
          nNodes=5,
          modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
          h_start=2.5e6,
          diameter=0.01)
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
        Modelica.Fluid.Valves.ValveCompressible valve(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          m_flow_nominal=10,
          rho_nominal=60,
          CvData=Modelica.Fluid.Types.CvTypes.Av,
          Av=0.05^2/4*Modelica.Constants.pi,
          dp_nominal=100000,
          p_nominal=10000000)
          annotation (Placement(transformation(extent={{26,-10},{46,10}})));
        Modelica.Fluid.Sources.FixedBoundary sink(nPorts=1,redeclare package
            Medium =
              Modelica.Media.Water.StandardWaterOnePhase, p=9500000)
                    annotation (Placement(transformation(extent={{86,-10},{66,10}})));
        Modelica.Blocks.Sources.Ramp ramp(
          offset=1,
          startTime=2,
          duration=0,
          height=-0.8)
                    annotation (Placement(transformation(extent={{72,30},{52,50}})));
        inner Modelica.Fluid.System system(
          use_eps_Re=true,
          energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
          p_start=10000000)
          annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
        Modelica.Fluid.Pipes.DynamicPipe pipe2(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          length=200,
          use_T_start=false,
          nNodes=5,
          modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
          h_start=2.5e6,
          diameter=0.01)
          annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
      equation
        connect(source.ports[1], pipe1.port_a) annotation (Line(
            points={{-70,0},{-50,0}}, color={0,127,255}));
        connect(valve.port_b,sink. ports[1])                          annotation (Line(
            points={{46,0},{66,0}}, color={0,127,255}));
        connect(ramp.y,valve. opening)               annotation (Line(
            points={{51,40},{36,40},{36,8}}, color={0,0,127}));
        connect(pipe1.port_b, pipe2.port_a) annotation (Line(
            points={{-30,0},{-14,0}}, color={0,127,255}));
        connect(pipe2.port_b, valve.port_a) annotation (Line(
            points={{6,0},{26,0}}, color={0,127,255}));
      end DynamicPipesSeriesSteadyStateInitial;

      model DynamicPipesSeriesLargeNSteadyStateInitial
        "Same as DynamicPipesSeriesSteadyStateInitial but with larger number of nodes"
         extends DynamicPipesSeriesSteadyStateInitial(
           pipe1(nNodes = 50),
           pipe2(nNodes = 50));
      equation

      end DynamicPipesSeriesLargeNSteadyStateInitial;

      model TwoVolumesEquationsReducedInitial
        "Initial values only for state variables after index reduction"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoVolumesEquations;
      initial equation
        T1 = 300;
        p2 = 1e5;
        T2 = 300;
        annotation(experiment(StopTime=1.0));
      end TwoVolumesEquationsReducedInitial;

      model TwoVolumesEquationsFullInitial
        "Fully specified initial values for all dynamic variables, consistent values"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoVolumesEquations;
      initial equation
          p1 = 1e5;
          T1 = 300;
          p2 = 1e5;
          T2 = 350;
        annotation(experiment(StopTime=1.0));
      end TwoVolumesEquationsFullInitial;

      model TwoVolumesEquationsReducedSteadyStatePressureAndTemperature
        "Steady-state equations only for state variables after index reduction"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoVolumesEquations;
      initial equation
        der(p1) = 0;
        der(T1) = 0;
        der(T2) = 0;
        annotation(experiment(StopTime=1.0));
      end TwoVolumesEquationsReducedSteadyStatePressureAndTemperature;

      model TwoVolumesEquationsFullSteadyStatePressureAndTemperature
        "Steady-state equations only for all dynamic variables after state variable change"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoVolumesEquations;
      initial equation
        der(p1) = 0;
        der(T1) = 0;
        der(p2) = 0;
        der(T2) = 0;
        annotation(experiment(StopTime=1.0));
      end TwoVolumesEquationsFullSteadyStatePressureAndTemperature;

      model TwoVolumesEquationsFullSteadyStateMassAndEnergy
        "Steady-state equations for all original dynamic variables"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoVolumesEquations;
      initial equation
        der(M1) = 0;
        der(E1) = 0;
        der(M2) = 0;
        der(E2) = 0;
        annotation(experiment(StopTime=1.0));
      end TwoVolumesEquationsFullSteadyStateMassAndEnergy;

      model TwoVolumesFullInitial
        "Fully specified initial values for all dynamic variables, consistent values"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoVolumes(
          system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial),
          V1(p_start=100000, T_start(displayUnit="K") = 300),
          V2(p_start=100000, T_start=623.15));
        annotation(experiment(StopTime=1.0));
      end TwoVolumesFullInitial;

      model TwoVolumesFullSteadyStatePressureAndTemperature
        "Fully specified steady-state conditions for all dynamic variables"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoVolumes(
          system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial),
          V1(p_start=100000, T_start(displayUnit="K") = 300),
          V2(p_start=100000, T_start=623.15));
        annotation(experiment(StopTime=1.0));
      end TwoVolumesFullSteadyStatePressureAndTemperature;

      package BaseClasses "Base classes for test models"
        extends Modelica.Icons.BasesPackage;
        model TwoVolumes
          "Two volumes containing an ideal gas with a zero dp connection, MSL-based"

          Modelica.Fluid.Vessels.ClosedVolume V1(
            use_portsData=false,
            V=1,
            nPorts=2,
            redeclare package Medium = Modelica.Media.Air.DryAirNasa)
            annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
          Modelica.Fluid.Vessels.ClosedVolume V2(
            use_portsData=false,
            V=1,
            nPorts=2,
            redeclare package Medium = Modelica.Media.Air.DryAirNasa)
            annotation (Placement(transformation(extent={{-12,0},{8,20}})));
          Modelica.Fluid.Sources.MassFlowSource_T source(
            nPorts=1,
            redeclare package Medium = Modelica.Media.Air.DryAirNasa,
            m_flow=0.01)
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          Modelica.Fluid.Sources.FixedBoundary sink(
            redeclare package Medium = Modelica.Media.Air.DryAirNasa,
            T(displayUnit="K") = 300,
            nPorts=1,
            p=1000) annotation (Placement(transformation(extent={{80,-20},{60,0}})));
          inner Modelica.Fluid.System system
            annotation (Placement(transformation(extent={{60,60},{80,80}})));
          Modelica.Fluid.Valves.ValveLinear valveLinear(
            redeclare package Medium = Modelica.Media.Air.DryAirNasa,
            dp_nominal=100000,
            m_flow_nominal=0.01)
            annotation (Placement(transformation(extent={{20,-20},{40,0}})));
          Modelica.Blocks.Sources.RealExpression one(y=1)
            annotation (Placement(transformation(extent={{2,24},{22,44}})));
        equation
          connect(source.ports[1], V1.ports[1]) annotation (Line(
              points={{-60,-10},{-40,-10},{-40,0}}, color={0,127,255}));
          connect(V1.ports[2], V2.ports[1]) annotation (Line(
              points={{-36,0},{-36,-10},{-4,-10},{-4,0}}, color={0,127,255}));
          connect(V2.ports[2], valveLinear.port_a) annotation (Line(
              points={{0,0},{0,-10},{20,-10}}, color={0,127,255}));
          connect(valveLinear.port_b, sink.ports[1]) annotation (Line(
              points={{40,-10},{60,-10}}, color={0,127,255}));
          connect(one.y, valveLinear.opening) annotation (Line(
              points={{23,34},{30,34},{30,-2}}, color={0,0,127}));
        end TwoVolumes;

        model TwoVolumesEquations
          "Two volumes containing an ideal gas with a zero dp connection, equation-based"
          Real M1(stateSelect = StateSelect.avoid),
               M2(stateSelect = StateSelect.avoid),
               E1(stateSelect = StateSelect.avoid),
               E2(stateSelect = StateSelect.avoid),
               p1(stateSelect = StateSelect.prefer),
               p2(stateSelect = StateSelect.prefer),
               T1(stateSelect = StateSelect.prefer),
               T2(stateSelect = StateSelect.prefer),
               w0, w1, w2, h1, h2;
          parameter Real V = 1;
          parameter Real R = 400;
          parameter Real cp = 1000;
          parameter Real cv = cp-R;
          parameter Real h0 = cp*300;
          parameter Real Kv = 1e-7;
        equation
          der(M1) = w0 - w1;
          der(E1) = w0*h0 - w1*h1;
          der(M2) = w1 - w2;
          der(E2) = w1*h1 - w2*h2;
          M1 = V*p1/(R*T1);
          M2 = V*p2/(R*T2);
          E1 = M1*cv*T1;
          E2 = M2*cv*T2;
          h1 = cp*T1;
          h2 = cp*T2;
          w0 = 0.01;
          w2 = Kv*p2;
          p1 = p2;
        end TwoVolumesEquations;
      end BaseClasses;
    end Fluid;

    package Mechanical "Test cases with Mechanical systems"
      extends Modelica.Icons.ExamplesPackage;

      model TwoMassesEquationsFullInitial
        "Fully specified initial values for dynamic variables"
        extends BaseClasses.TwoMassesEquations;
        extends Modelica.Icons.Example;
      initial equation
        x1 = 0;
        v1 = 0;
        x2 = 0;
        v2 = 0;
        annotation(experiment(StopTime=1.0));
      end TwoMassesEquationsFullInitial;

      model TwoMassesEquationsReducedInitial
        "Initial values for state variables after index reduction"
        extends BaseClasses.TwoMassesEquations;
        extends Modelica.Icons.Example;
      initial equation
        x1 = 0;
        v1 = 0;
        annotation(experiment(StopTime=1.0));
      end TwoMassesEquationsReducedInitial;

      model TwoMassesEquationsFullSteadyState
        "Fully specified initial values for dynamic variables"
        extends BaseClasses.TwoMassesEquations;
        extends Modelica.Icons.Example;
      initial equation
        der(x1) = 0;
        der(v1) = 0;
        der(x2) = 0;
        der(v2) = 0;
        annotation(experiment(StopTime=1.0));
      end TwoMassesEquationsFullSteadyState;

      model TwoMassesEquationsReducedSteadyState
        "Fully specified initial values for states after index reduction"
        extends BaseClasses.TwoMassesEquations;
        extends Modelica.Icons.Example;
      initial equation
        der(x1) = 0;
        der(v1) = 0;
        annotation(experiment(StopTime=1.0));
      end TwoMassesEquationsReducedSteadyState;

      model TwoMassesFullInitial
        "Fully specified initial values for dynamic variables"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoMasses(
          mass1(s(fixed=true), v(fixed=true)),
          mass2(s(fixed=true), v(fixed=true)));
        annotation (experiment(StopTime=10));
      end TwoMassesFullInitial;

      model TwoMassesReducedInitial
        "Initial values for state variables after index reduction"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoMasses(
                          mass1(s(fixed=true), v(fixed=true)));
        annotation (experiment(StopTime=10));
      end TwoMassesReducedInitial;

      model TwoMassesFullSteadyState
        "Fully specified steady state conditions for dynamic variables"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoMasses(
           mass1(v(fixed=true, start=0), a(fixed=true, start=0)),
           mass2(v(fixed=true, start=0), a(fixed=true, start=0)));
        annotation (experiment(StopTime=10));
      end TwoMassesFullSteadyState;

      model TwoMassesReducedSteadyState
        "Steady-state initial conditions for states after index reduction"
        extends Modelica.Icons.Example;
        extends BaseClasses.TwoMasses(
          mass1(v(fixed=true, start=0), a(fixed=true, start=0)));
        annotation (experiment(StopTime=10));
      end TwoMassesReducedSteadyState;

      package BaseClasses "Base classes for test cases"
        extends Modelica.Icons.BasesPackage;
        model TwoMasses
          "Two rigidly connected masses, connected to ground via a spring"

          Modelica.Mechanics.Translational.Components.Mass mass1(
             m=1, s(fixed=false,start=1))
            annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
          Modelica.Mechanics.Translational.Components.Mass mass2(
             m=1, s(fixed=false, start=1))
            annotation (Placement(transformation(extent={{26,-10},{46,10}})));
          Modelica.Mechanics.Translational.Components.Fixed fixed
            annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
          Modelica.Mechanics.Translational.Components.Spring spring(c=1, s_rel0=0.5)
            annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
        equation
          connect(fixed.flange, spring.flange_a) annotation (Line(
              points={{-60,0},{-42,0}}, color={0,127,0}));
          connect(spring.flange_b, mass1.flange_a) annotation (Line(
              points={{-22,0},{-12,0}}, color={0,127,0}));
          connect(mass1.flange_b, mass2.flange_a) annotation (Line(
              points={{8,0},{26,0}}, color={0,127,0}));
        end TwoMasses;

        model TwoMassesEquations
          "Two rigidly connected masses, connected to ground via a spring, equation-based"
          Real x1, v1, x2, v2, F1, F2;
          parameter Real M = 1;
          parameter Real K = 1;
          parameter Real F0 = 1;
        equation
          der(x1) = v1;
          M*der(v1) = F1+F2;
          der(x2) = v2;
          M*der(v2) = -F2;
          F1 = -K*x1;
          x1 = x2;
        end TwoMassesEquations;
      end BaseClasses;
    end Mechanical;

  end ConsistentInitialization;

  package InconsistentInitialization
      "Test cases of systems with overdetermined initialization problems due to index reduction that are inconsistent (should give an error during initialization)"
    extends Modelica.Icons.ExamplesPackage;
    package Fluid
      "Test cases with Fluid systems"
    extends Modelica.Icons.ExamplesPackage;
      model TwoVolumesEquationsFullInitialInconsistent
        "Fully specified initial values for all dynamic variables, inconsistent values. An error should be reported"
        extends Modelica.Icons.Example;
        extends ConsistentInitialization.Fluid.BaseClasses.TwoVolumesEquations;
      initial equation
        p1 = 1e5;
        T1 = 300;
        p2 = 2e5;
        T2 = 350;
        annotation(experiment(StopTime=1.0));
      end TwoVolumesEquationsFullInitialInconsistent;

      model TwoVolumesFullInitialInconsistent
        "Fully specified initial values for all dynamic variables, inconsistent values. An error should be reported"
        extends Modelica.Icons.Example;
        extends ConsistentInitialization.Fluid.BaseClasses.TwoVolumes(
          system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial),
          V1(p_start=100000, T_start(displayUnit="K") = 300),
          V2(p_start=200000, T_start=623.15));
        annotation(experiment(StopTime=1.0));
      end TwoVolumesFullInitialInconsistent;
    end Fluid;

    package Mechanical
      "Test cases with mechanical systems"
    extends Modelica.Icons.ExamplesPackage;

      model TwoMassesEquationsFullInitialInconsistent
        "Fully specified initial values for dynamic variables, inconsistent values"
        extends
          ConsistentInitialization.Mechanical.BaseClasses.TwoMassesEquations;
        extends Modelica.Icons.Example;
      initial equation
        x1 = 0;
        v1 = 0;
        x2 = 1;
        v2 = 0;
        annotation(experiment(StopTime=1.0));
      end TwoMassesEquationsFullInitialInconsistent;

      model TwoMassesFullInitialInconsistent
        "Fully specified initial values for dynamic variables, inconsistent values"
        extends Modelica.Icons.Example;
        extends ConsistentInitialization.Mechanical.BaseClasses.TwoMasses(mass1(
             s(fixed=true), v(fixed=true)), mass2(s(fixed=true, start=2), v(
                fixed=true)));
        annotation (experiment(StopTime=10));
      end TwoMassesFullInitialInconsistent;
    end Mechanical;
  end InconsistentInitialization;
  annotation (Icon(graphics={
                   Polygon(
          points={{-70,0},{-44,0},{-24,-34},{50,56},{78,56},{-24,-74},{-70,0}},
          lineColor={75,138,73},
          fillColor={75,138,73},
          fillPattern=FillPattern.Solid)}),
       preferredView="info",
       version="4.0.0",
       versionDate="2020-06-04",
       dateModified = "2020-06-04 11:00:00Z",
       revisionId="$Id::                                       $",
       uses(Modelica(version="4.0.0")),
    Documentation(info="<html>
<p>
This library provides models and functions to test components of
<strong>package Modelica</strong> (the Modelica Standard Library).
All test models in this package define more equations during initialization,
as necessary. These test models are especially provided for tool vendors
to improve their tools so that models with consistently overdetermined initialization
(= models in subpackage <a href=\"modelica://ModelicaTestOverdetermined.ConsistentInitialization\">ConsistentInitialization</a>)
can be handled automatically and models with inconsistently overdetermined initialization
(= models in subpackage <a href=\"modelica://ModelicaTestOverdetermined.InconsistentInitialization\">InconsistentInitialization</a>)
fail during translation but give useful error messages.
</p>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"));
end ModelicaTestOverdetermined;
