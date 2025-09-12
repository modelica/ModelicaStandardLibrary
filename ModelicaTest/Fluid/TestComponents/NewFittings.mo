within ModelicaTest.Fluid.TestComponents;
package NewFittings "New Fitting components and functions"
extends Modelica.Icons.ExamplesPackage;
  partial model PartialFittingTest "Partial model for fitting component test"

    replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    replaceable model FittingComponent =
        Modelica.Fluid.Interfaces.PartialTwoPortTransport;

    inner Modelica.Fluid.System system(p_ambient(displayUnit="Pa") = 100000,
        m_flow_small=0.01,
      T_ambient(displayUnit="K"))
                           annotation (Placement(
          transformation(extent={{80,-100},{100,-80}})));

    Modelica.Fluid.Sources.Boundary_pT source_left(
      redeclare package Medium = Medium,
      p(displayUnit="Pa") = 1.01*system.p_ambient,
      use_T_in=false,
      T(displayUnit="degC") = 303.15,
      use_p_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-62,30},{-42,50}})));

    Modelica.Fluid.Sources.Boundary_pT source_right(
      redeclare package Medium = Medium,
      use_p_in=false,
      T(displayUnit="degC") = 293.15,
      p(displayUnit="Pa") = 3*system.p_ambient,
      nPorts=2)
      annotation (Placement(transformation(extent={{78,28},{58,48}})));
    Modelica.Blocks.Sources.Ramp ramp(
      duration=1,
      offset=system.p_ambient,
      height=4*system.p_ambient)
      annotation (Placement(transformation(extent={{-94,40},{-74,60}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary(
       redeclare package Medium = Medium,           use_m_flow_in=true,
      T=303.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-44,-40},{-24,-20}})));
    Modelica.Fluid.Sensors.MassFlowRate sensor(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-32,50},{-12,30}})));
    FittingComponent fitting1(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{12,50},{32,30}})));
    FittingComponent fitting2(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{12,-20},{32,-40}})));
  equation
    connect(ramp.y, source_left.p_in) annotation (Line(
        points={{-73,50},{-68,50},{-68,48},{-64,48}}, color={0,0,127}));
    connect(sensor.port_a, source_left.ports[1]) annotation (Line(
        points={{-32,40},{-42,40}}, color={0,127,255}));
    connect(sensor.m_flow, boundary.m_flow_in) annotation (Line(
        points={{-22,29},{-22,-4},{-60,-4},{-60,-22},{-44,-22}}, color={0,0,127}));
    connect(sensor.port_b, fitting1.port_a) annotation (Line(
        points={{-12,40},{12,40}}, color={0,127,255}));
    connect(fitting1.port_b, source_right.ports[1]) annotation (Line(
        points={{32,40},{45,40},{45,40},{58,40}}, color={0,127,255}));
    connect(fitting2.port_a, boundary.ports[1]) annotation (Line(
        points={{12,-30},{-24,-30}}, color={0,127,255}));
    connect(fitting2.port_b, source_right.ports[2]) annotation (Line(
        points={{32,-30},{48,-30},{48,36},{58,36}}, color={0,127,255}));
    annotation (
      Documentation(info="<html>
<p>
Switch to the diagram or equation layer to see the model of a <strong> Modelica.Fluid bend </strong> using <strong> Fluid.Dissipation pressure loss calculations </strong>.
</p>

<p>
This model executes pressure loss calculations out of the <strong> Fluid.Dissipation </strong> library for a bend of an incompressible and single-phase fluid flow considering surface roughness. Both the <strong> compressible </strong> case, where the mass flow rate (M_FLOW) is calculated in dependence of a known pressure loss (dp) and the <strong> incompressible </strong> case, where the pressure loss (DP) is calculated in dependence of a known mass flow rate (m_flow) are modelled.
</p>
</html>"));
  end PartialFittingTest;

  package Bends
  extends Modelica.Icons.ExamplesPackage;
    model CurvedBend
      extends Modelica.Icons.Example;
      parameter Modelica.Fluid.Fittings.BaseClasses.Bends.CurvedBend.Geometry geometry(d_hyd=0.1, R_0=0.2) annotation (Placement(transformation(extent={{12,72},{32,92}})));
      extends ModelicaTest.Fluid.TestComponents.NewFittings.PartialFittingTest(
                                 redeclare model FittingComponent =
            Modelica.Fluid.Fittings.Bends.CurvedBend(geometry=geometry));
      annotation (experiment(StopTime=1.01));
    end CurvedBend;

    model EdgedBend
      extends Modelica.Icons.Example;
      parameter Modelica.Fluid.Fittings.BaseClasses.Bends.EdgedBend.Geometry geometry(d_hyd=0.1, delta=
            1.5707963267949)                                                           annotation (Placement(transformation(extent={{12,72},{32,92}})));
      extends ModelicaTest.Fluid.TestComponents.NewFittings.PartialFittingTest(
                                 redeclare model FittingComponent =
            Modelica.Fluid.Fittings.Bends.EdgedBend(geometry=geometry));
      annotation (experiment(StopTime=1.01));
    end EdgedBend;
  end Bends;

  package Orifices
  extends Modelica.Icons.ExamplesPackage;
    model ThickEdgedOrifice
      extends Modelica.Icons.Example;
      parameter
        Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Geometry geometry=
    Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Choices.circular(diameter=0.1, venaDiameter=0.01, venaLength=0.001) annotation (Placement(transformation(extent={{12,72},{32,92}})));
      extends ModelicaTest.Fluid.TestComponents.NewFittings.PartialFittingTest(
                                 redeclare model FittingComponent =
            Modelica.Fluid.Fittings.Orifices.ThickEdgedOrifice(geometry=geometry));
      annotation (experiment(StopTime=1.01));
    end ThickEdgedOrifice;
  end Orifices;

  package GenericResistances
  extends Modelica.Icons.ExamplesPackage;
    model VolumeFlowRate
      extends Modelica.Icons.Example;
      parameter Real a=1;
      parameter Real b=2;
      extends ModelicaTest.Fluid.TestComponents.NewFittings.PartialFittingTest(
                                 redeclare model FittingComponent =
            Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate(a=a,b=b));
      annotation (experiment(StopTime=1.01));
    end VolumeFlowRate;
  end GenericResistances;
end NewFittings;
