within Modelica.Electrical.QuasiStationary;
package Machines "Quasistationary machine models"
  extends Modelica.Icons.Package;

  package Examples "Test examples"
    extends Modelica.Icons.ExamplesPackage;

    model TransformerTestbench "Transformer test bench"
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Resistance RL[m]=fill(1/3, m)
        "Load resistance";
      output Modelica.SIunits.Voltage VS=polarVS.len "Grid voltage";
      output Modelica.SIunits.Angle phiS=polarVS.phi "Grid phase";
      output Modelica.SIunits.Voltage VL=polarVL.len "Load voltage";
      output Modelica.SIunits.Angle phiL=polarVL.phi "Load phase";
      QuasiStationary.MultiPhase.Sources.VoltageSource source(
        f=50,
        V=fill(100/sqrt(3), 3),
        m=m,
        gamma(fixed=true, start=0))
             annotation (Placement(transformation(
            origin={-90,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.MultiPhase.Basic.Star starS(m=m) annotation (Placement(
            transformation(
            origin={-90,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground groundS annotation (Placement(
            transformation(extent={{-100,-70},{-80,-50}})));
      QuasiStationary.MultiPhase.Sensors.PowerSensor electricalPowerSensorS(m=m)
        annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
      QuasiStationary.MultiPhase.Sensors.CurrentSensor currentSensorS(m=m)
        annotation (Placement(transformation(extent={{-60,30},{-40,10}})));
      ComplexBlocks.ComplexMath.ComplexToPolar polarIS annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,80})));
      QuasiStationary.MultiPhase.Sensors.VoltageSensor voltageSensorS(m=m)
        annotation (Placement(transformation(
            origin={-50,-20},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      ComplexBlocks.ComplexMath.ComplexToPolar polarVS annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,-80})));
      QuasiStationary.MultiPhase.Basic.Delta deltaS(m=m) annotation (Placement(
            transformation(
            origin={-50,0},
            extent={{-10,-10},{10,10}})));
      QuasiStationary.SinglePhase.Basic.Resistor earth(R_ref=1e6) annotation (
          Placement(transformation(
            origin={0,-30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground groundT annotation (Placement(
            transformation(extent={{-10,-70},{10,-50}})));
      QuasiStationary.MultiPhase.Sensors.VoltageSensor voltageSensorL(m=m)
        annotation (Placement(transformation(
            origin={50,-20},
            extent={{-10,-10},{10,10}})));
      ComplexBlocks.ComplexMath.ComplexToPolar polarVL annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,-80})));
      QuasiStationary.MultiPhase.Basic.Delta deltaL(m=m) annotation (Placement(
            transformation(
            origin={50,0},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      QuasiStationary.MultiPhase.Sensors.CurrentSensor currentSensorL(m=m)
        annotation (Placement(transformation(extent={{40,30},{60,10}})));
      ComplexBlocks.ComplexMath.ComplexToPolar polarIL annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,80})));
      QuasiStationary.MultiPhase.Sensors.PowerSensor electricalPowerSensorL(m=m)
        annotation (Placement(transformation(extent={{60,10},{80,30}})));
      QuasiStationary.MultiPhase.Basic.Resistor load(R_ref=RL, m=m) annotation (
         Placement(transformation(
            origin={90,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.MultiPhase.Basic.Star starL(m=m) annotation (Placement(
            transformation(
            origin={90,-30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground groundL annotation (Placement(
            transformation(extent={{80,-70},{100,-50}})));
      Modelica.Electrical.Machines.Utilities.TransformerData transformerData(
        C1=Modelica.Utilities.Strings.substring(
                transformer.VectorGroup,
                1,
                1),
        C2=Modelica.Utilities.Strings.substring(
                transformer.VectorGroup,
                2,
                2),
        f=50,
        V1=100,
        V2=100,
        SNominal=30E3,
        v_sc=0.05,
        P_sc=300) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
      QuasiStationary.Machines.BasicMachines.Transformers.Yd.Yd01 transformer(
        n=transformerData.n,
        R1=transformerData.R1,
        L1sigma=transformerData.L1sigma,
        R2=transformerData.R2,
        L2sigma=transformerData.L2sigma,
        T1Ref=293.15,
        alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
        T2Ref=293.15,
        alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
        T1Operational=293.15,
        T2Operational=293.15) annotation (Placement(transformation(extent={{-20,0},{
                20,40}})));
      MultiPhase.Blocks.SymmetricalComponents symmetricalComponentsIS(final m=m)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,50})));
      MultiPhase.Blocks.SymmetricalComponents symmetricalComponentsIL(final m=m)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,50})));
      MultiPhase.Blocks.SymmetricalComponents symmetricalComponentsVS(final m=m)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,-50})));
      MultiPhase.Blocks.SymmetricalComponents symmetricalComponentsVL(final m=m)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,-50})));
    equation
      connect(starS.pin_n, groundS.pin) annotation (Line(
          points={{-90,-40},{-90,-50}}, color={85,170,255}));
      connect(source.plug_n, starS.plug_p) annotation (Line(
          points={{-90,-10},{-90,-20}}, color={85,170,255}));
      connect(starL.pin_n, groundL.pin) annotation (Line(
          points={{90,-40},{90,-50}}, color={85,170,255}));
      connect(load.plug_n, starL.plug_p) annotation (Line(
          points={{90,-10},{90,-20}}, color={85,170,255}));
      connect(electricalPowerSensorS.currentP, electricalPowerSensorS.voltageP)
        annotation (Line(
          points={{-80,20},{-80,30},{-70,30}}, color={85,170,255}));
      connect(electricalPowerSensorS.currentN, currentSensorS.plug_p)
        annotation (Line(
          points={{-60,20},{-60,20}}, color={85,170,255}));
      connect(currentSensorS.plug_n, transformer.plug1) annotation (Line(
          points={{-40,20},{-20,20}}, color={85,170,255}));
      connect(transformer.plug2, currentSensorL.plug_p) annotation (Line(
          points={{20,20},{40,20}}, color={85,170,255}));
      connect(currentSensorL.plug_n, electricalPowerSensorL.currentP)
        annotation (Line(
          points={{60,20},{60,20}}, color={85,170,255}));
      connect(electricalPowerSensorL.currentP, electricalPowerSensorL.voltageP)
        annotation (Line(
          points={{60,20},{60,30},{70,30}}, color={85,170,255}));
      connect(electricalPowerSensorL.currentN, load.plug_p) annotation (Line(
          points={{80,20},{80,20},{90,20},{90,10}},
                                    color={85,170,255}));
      connect(electricalPowerSensorL.voltageN, starL.plug_p) annotation (Line(
          points={{70,10},{70,-20},{90,-20}}, color={85,170,255}));
      connect(electricalPowerSensorS.voltageN, starS.plug_p) annotation (Line(
          points={{-70,10},{-70,-20},{-90,-20}}, color={85,170,255}));
      connect(earth.pin_n, groundT.pin) annotation (Line(
          points={{0,-40},{0,-50}}, color={85,170,255}));
      connect(deltaS.plug_p, voltageSensorS.plug_n) annotation (Line(
          points={{-60,0},{-60,-20}}, color={85,170,255}));
      connect(deltaS.plug_n, voltageSensorS.plug_p) annotation (Line(
          points={{-40,0},{-40,-20}}, color={85,170,255}));
      connect(currentSensorS.plug_n, deltaS.plug_n) annotation (Line(
          points={{-40,20},{-40,0}}, color={85,170,255}));
      connect(deltaL.plug_p, voltageSensorL.plug_n) annotation (Line(
          points={{60,0},{60,-20}}, color={85,170,255}));
      connect(deltaL.plug_n, voltageSensorL.plug_p) annotation (Line(
          points={{40,0},{40,-20}}, color={85,170,255}));
      connect(currentSensorL.plug_p, deltaL.plug_n) annotation (Line(
          points={{40,20},{40,0}}, color={85,170,255}));
      connect(symmetricalComponentsIS.u, currentSensorS.y)
        annotation (Line(points={{-50,38},{-50,31}}, color={85,170,255}));
      connect(symmetricalComponentsIL.u, currentSensorL.y)
        annotation (Line(points={{50,38},{50,31}}, color={85,170,255}));
      connect(symmetricalComponentsIS.y[1], polarIS.u) annotation (Line(points={{-50,
              61},{-50,64.5},{-50,68}}, color={85,170,255}));
      connect(symmetricalComponentsIL.y[1], polarIL.u)
        annotation (Line(points={{50,61},{50,68}}, color={85,170,255}));
      connect(voltageSensorS.y, symmetricalComponentsVS.u)
        annotation (Line(points={{-50,-31},{-50,-38}}, color={85,170,255}));
      connect(symmetricalComponentsVS.y[1], polarVS.u)
        annotation (Line(points={{-50,-61},{-50,-68}}, color={85,170,255}));
      connect(voltageSensorL.y, symmetricalComponentsVL.u) annotation (Line(points={
              {50,-31},{50,-34.5},{50,-38}}, color={85,170,255}));
      connect(symmetricalComponentsVL.y[1], polarVL.u) annotation (Line(points={{50,
              -61},{50,-64.5},{50,-68}}, color={85,170,255}));
      connect(electricalPowerSensorS.currentP, source.plug_p) annotation (Line(
            points={{-80,20},{-90,20},{-90,10}}, color={85,170,255}));
      annotation (Documentation(info="<html>
Transformer test bench:<br>
You may choose different connections as well as vary the load (even not symmetrical).<br>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
In some cases it may be necessary to ground the transformer's starpoint
even though the source's or load's starpoint are grounded; you may use a reasonable high earthing resistance.
</html>"), experiment(StopTime=0.1, Interval=0.001));
    end TransformerTestbench;
    annotation (Documentation(info="<html>
Examples to demonstrate the usage of quasistationary electric components.
</html>"));
  end Examples;

  package BasicMachines "Basic machine models"
    extends Modelica.Icons.Package;

    package Transformers "Library for technical 3phase transformers"
      extends Modelica.Icons.Package;

      package Yy "Transformers: primary Y / secondary y"
        extends Modelica.Icons.VariantsPackage;

        model Yy00 "Transformer Yy0"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yy00");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,10}},
                                              color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-10},{-10,-10},{-10,-70},{-10,-70}},
                                                    color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, l2sigma.plug_p) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy0
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy00;

        model Yy02 "Transformer Yy2"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yy02");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3) annotation (Line(points={{10,4},{
                  10,-4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n3, Rot2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy2
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy02;

        model Yy04 "Transformer Yy4"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yy04");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{30,10},{50,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(Rot2.plug_n, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, Rot2.plug_p) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy4
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy04;

        model Yy06 "Transformer Yy6"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yy06");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,10}},
                                              color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-10},{-10,-10},{-10,-70},{-10,-70}},
                                                    color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(l2sigma.plug_p, core.plug_n3) annotation (Line(points={{50,0},
                  {50,-20},{10,-20},{10,-10}}, color={85,170,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy6
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy06;

        model Yy08 "Transformer Yy8"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yy08");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(Rot2.plug_p, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy8
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy08;

        model Yy10 "Transformer Yy10"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yy10");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot2.plug_n)
            annotation (Line(points={{50,0},{50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, Rot2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy10
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy10;
        annotation (Documentation(info="<html>
This package contains transformers primary Y connected / secondary y connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Yy;

      package Yd "Transformers: primary Y / secondary d"
        extends Modelica.Icons.VariantsPackage;

        model Yd01 "Transformer Yd1"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yd01");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(Delta2.plug_p, r2.plug_n) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,10}},color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-10},
                  {-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, Delta2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          connect(core.plug_p2, l2sigma.plug_p) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd1
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd01;

        model Yd03 "Transformer Yd3"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yd03");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{30,10},{50,30}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={85,170,255}));
          connect(core.plug_n3, Rot2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd3
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd03;

        model Yd05 "Transformer Yd5"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yd05");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{30,10},{50,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, l2sigma.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{50,-20},{50,0}}, color={85,170,255}));
          connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd5
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd05;

        model Yd07 "Transformer Yd7"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yd07");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(Delta2.plug_p, r2.plug_n) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, Delta2.plug_n) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={85,170,255}));
          connect(l2sigma.plug_p, core.plug_n3) annotation (Line(points={{50,0},
                  {50,-20},{10,-20},{10,-10}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd7
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd07;

        model Yd09 "Transformer Yd9"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yd09");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{30,-30},{50,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(Rot2.plug_p, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={85,170,255}));
          connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={85,170,255}));
          connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd9
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd09;

        model Yd11 "Transformer Yd11"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yd11");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          connect(core.plug_p2, l2sigma.plug_p) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd11
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd11;
        annotation (Documentation(info="<html>
This package contains transformers primary Y connected / secondary d connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Yd;

      package Yz "Transformers: primary Y / secondary zig-zag"
        extends Modelica.Icons.VariantsPackage;

        model Yz01 "Transformer Yz1"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yz01");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Rot22(final m=m) annotation (
              Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={85,170,255}));
          connect(Rot22.plug_n, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz1
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz01;

        model Yz03 "Transformer Yz3"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yz03");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Rot22(final m=m) annotation (
              Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={85,170,255}));
          connect(Rot22.plug_n, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz3
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz03;

        model Yz05 "Transformer Yz5"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yz05");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={85,170,255}));
          connect(l2sigma.plug_p, core.plug_n2) annotation (Line(points={{50,0},
                  {50,20},{20,20},{20,4},{10,4}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz5
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz05;

        model Yz07 "Transformer Yz7"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yz07");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(l2sigma.plug_p, core.plug_n2) annotation (Line(points={{50,0},
                  {50,20},{20,20},{20,4},{10,4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz7
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz07;

        model Yz09 "Transformer Yz9"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yz09");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Rot22(final m=m) annotation (
              Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot22.plug_n) annotation (Line(points={{50,0},
                  {50,20},{50,20}}, color={85,170,255}));
          connect(Rot22.plug_p, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz9
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz09;

        model Yz11 "Transformer Yz11"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Yz11");
          QuasiStationary.MultiPhase.Basic.Star star1(final m=m) annotation (
              Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Rot22(final m=m) annotation (
              Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={85,170,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot22.plug_n)
            annotation (Line(points={{50,0},{50,20}}, color={85,170,255}));
          connect(Rot22.plug_p, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz11
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz11;
        annotation (Documentation(info="<html>
This package contains transformers primary Y connected / secondary zig-zag connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Yz;

      package Dy "Transformers: primary D / secondary y"
        extends Modelica.Icons.VariantsPackage;

        model Dy01 "Transformer Dy1"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dy01");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={85,170,255}));
          connect(Delta1.plug_p, r1.plug_p) annotation (Line(points={{-50,-20},
                  {-90,-20},{-90,0}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, Rot2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy1
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy01;

        model Dy03 "Transformer Dy3"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dy03");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{30,10},{50,30}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(Rot2.plug_n, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={85,170,255}));
          connect(Delta1.plug_p, r1.plug_p) annotation (Line(points={{-50,-20},
                  {-90,-20},{-90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_p2, Rot2.plug_p) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy3
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy03;

        model Dy05 "Transformer Dy5"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dy05");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(Delta1.plug_p, r1.plug_p) annotation (Line(points={{-50,-20},
                  {-90,-20},{-90,0}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(l2sigma.plug_p, core.plug_n3) annotation (Line(points={{50,0},
                  {50,-20},{10,-20},{10,-10}}, color={85,170,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy5
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy05;

        model Dy07 "Transformer Dy7"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dy07");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(Rot2.plug_p, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={85,170,255}));
          connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy7
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy07;

        model Dy09 "Transformer Dy9"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dy09");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot2.plug_n)
            annotation (Line(points={{50,0},{50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, Rot2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy9
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy09;

        model Dy11 "Transformer Dy11"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dy11");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={85,170,255}));
          connect(core.plug_p2, l2sigma.plug_p) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy11
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy11;
        annotation (Documentation(info="<html>
This package contains transformers primary D connected / secondary y connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Dy;

      package Dd "Transformers: primary D / secondary d"
        extends Modelica.Icons.VariantsPackage;

        model Dd00 "Transformer Dd0"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dd00");
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(Delta2.plug_p, r2.plug_n) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, l2sigma.plug_p) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={85,170,255}));
          connect(core.plug_n3, Delta2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd0
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd00;

        model Dd02 "Transformer Dd2"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dd02");
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{30,10},{50,30}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={85,170,255}));
          connect(core.plug_n3, Rot2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,25}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd2
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd02;

        model Dd04 "Transformer Dd4"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dd04");
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{30,10},{50,30}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,25}));
          connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,25}));
          connect(core.plug_n2, core.plug_p3) annotation (Line(points={{10,4},{
                  10,1},{10,1},{10,-4}}, color={85,170,25}));
          connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={85,170,255}));
          connect(core.plug_n3, l2sigma.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{50,-20},{50,0}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd4
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd04;

        model Dd06 "Transformer Dd6"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dd06");
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(Delta2.plug_p, r2.plug_n) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={85,170,255}));
          connect(Delta1.plug_p, r1.plug_p) annotation (Line(points={{-50,-20},
                  {-90,-20},{-90,0}}, color={85,170,25}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,25}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(Delta2.plug_n, core.plug_p2) annotation (Line(points={{30,20},
                  {10,20},{10,10}}, color={85,170,255}));
          connect(core.plug_n3, l2sigma.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{50,-20},{50,0}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd6
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd06;

        model Dd08 "Transformer Dd8"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dd08");
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot2(final m=m) annotation (
              Placement(transformation(extent={{50,10},{30,30}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,25}));
          connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={85,170,255}));
          connect(Rot2.plug_p, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(core.plug_n1, Delta1.plug_n) annotation (Line(points={{-10,-5},
                  {-10,-20},{-30,-20}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={85,170,255}));
          connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd8
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd08;

        model Dd10 "Transformer Dd10"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dd10");
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
          QuasiStationary.MultiPhase.Basic.Delta Delta2(final m=m) annotation (
              Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
          connect(core.plug_p2, l2sigma.plug_p) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={85,170,255}));
          connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd10
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd10;
        annotation (Documentation(info="<html>
This package contains transformers primary D connected / secondary d connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Dd;

      package Dz "Transformers: primary D / secondary zig-zag"
        extends Modelica.Icons.VariantsPackage;

        model Dz00 "Transformer Dz0"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dz00");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Rot22(final m=m) annotation (
              Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,10},{-10,10}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},{-10,-20},{-10,-10}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={85,170,255}));
          connect(Rot22.plug_n, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz0
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz00;

        model Dz02 "Transformer Dz2"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dz02");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Rot22(final m=m) annotation (
              Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={85,170,255}));
          connect(Rot22.plug_n, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz2
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz02;

        model Dz04 "Transformer Dz4"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dz04");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,10}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},{-10,-20},{-10,-10}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(l2sigma.plug_p, core.plug_n2) annotation (Line(points={{50,0},
                  {50,20},{20,20},{20,4},{10,4}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz4
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz04;

        model Dz06 "Transformer Dz6"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dz06");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={85,170,255}));
          connect(l2sigma.plug_p, core.plug_n2) annotation (Line(points={{50,0},
                  {50,20},{20,20},{20,4},{10,4}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz6
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz06;

        model Dz08 "Transformer Dz8"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dz08");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Rot22(final m=m) annotation (
              Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot22.plug_n) annotation (Line(points={{50,0},
                  {50,20},{50,20}}, color={85,170,255}));
          connect(Rot22.plug_p, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz8
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz08;

        model Dz10 "Transformer Dz10"

          extends QuasiStationary.Machines.Interfaces.PartialBasicTransformer(
              final VectorGroup="Dz10");
          QuasiStationary.MultiPhase.Basic.Star star2(final m=m) annotation (
              Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          QuasiStationary.MultiPhase.Basic.Delta Rot21(final m=m) annotation (
              Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          QuasiStationary.MultiPhase.Basic.Delta Rot22(final m=m) annotation (
              Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
          QuasiStationary.MultiPhase.Basic.Delta Delta1(final m=m) annotation (
              Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={85,170,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={85,170,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={85,170,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={85,170,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={85,170,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={85,170,255}));
          connect(l2sigma.plug_p, Rot22.plug_n)
            annotation (Line(points={{50,0},{50,20}}, color={85,170,255}));
          connect(Rot22.plug_p, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={85,170,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz10
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz10;
        annotation (Documentation(info="<html>
This package contains transformers primary D connected / secondary d connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Dz;

      annotation (Documentation(info="<html>
This package contains components to model technical three-phase transformers:
<ul>
<li>Transformer: transformer model to choose connection / vector group</li>
<li>Yy: Transformers with primary Y / secondary y</li>
<li>Yd: Transformers with primary Y / secondary d</li>
<li>Yz: Transformers with primary Y / secondary zig-zag</li>
<li>Dy: Transformers with primary D / secondary y</li>
<li>Dd: Transformers with primary D / secondary d</li>
<li>Dz: Transformers with primary D / secondary zig-zag</li>
</ul>
<p>
Transformers are modeled by an ideal transformer, adding primary and secondary winding resistances and stray inductances.<br>
All transformers extend from the base model <em>PartialTransformer</em>, adding the primary and secondary connection.<br>
<strong>VectorGroup</strong> defines the phase shift between primary and secondary voltages, expressed by a number phase shift/30 degree
(i.e., the hour on a clock face). Therefore each transformer is identified by two characters and a two-digit number,
e.g., Yd11 ... primary connection Y (star), secondary connection d (delta), vector group 11 (phase shift 330 degree)<br>
With the \"supermodel\" <em>Transformer</em> the user may choose primary and secondary connection as well as the vector group.<br>
It calculates winding ratio as well as primary and secondary winding resistances and stray inductances,
distributing them equally to primary and secondary winding, from the following parameters:
</p>
<ul>
<li>nominal frequency</li>
<li>primary voltage (RMS line-to-line)</li>
<li>secondary voltage (RMS line-to-line)</li>
<li>nominal apparent power</li>
<li>impedance voltage drop</li>
<li>short-circuit copper losses</li>
</ul>
The <strong>impedance voltage drop</strong> indicates the (absolute value of the) voltage drop at nominal load (current) as well as
the voltage we have to apply to the primary winding to achieve nominal current in the short-circuited secondary winding.
<p>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
<strong>In some cases (Yy or Yz) it may be necessary to ground one of the transformer's starpoints
even though the source's and/or load's starpoint are grounded; you may use a reasonable high earthing resistance.</strong>
</p>
<strong>Limitations and assumptions:</strong><br>
<ul>
<li>number of phases is limited to 3, therefore definition as a constant m=3</li>
<li>symmetry of the 3 phases resp. limbs</li>
<li>saturation is neglected, i.e., inductances are constant</li>
<li>magnetizing current is neglected</li>
<li>magnetizing losses are neglected</li>
<li>additional (stray) losses are neglected</li>
</ul>
<strong>Further development:</strong>
<ul>
<li>modeling magnetizing current, including saturation</li>
<li>temperature dependency of winding resistances</li>
</ul>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>", revisions="<html>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer<br>
       first stable release</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{-80,50},{-60,30},{-60,-50},{-80,-70},{-80,50}}),
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{60,50},{40,30},{40,-50},{60,-70},{60,50}}),
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{-10,40},{-20,30},{-20,-50},{-10,-60},{0,-50},{0,30},{-10,
                  40}}),
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{-80,50},{60,50},{40,30},{0,30},{-10,40},{-20,30},{-60,30},
                  {-80,50}}),
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{-80,-70},{60,-70},{40,-50},{0,-50},{-10,-60},{-20,-50},{
                  -60,-50},{-80,-70}}),
            Rectangle(
              origin={10,10},
              lineColor={213,170,255},
              fillColor={213,170,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{-88,-46},{-52,26}}),
            Rectangle(
              origin={10,10},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{-94,-38},{-46,18}}),
            Rectangle(
              origin={10,10},
              lineColor={213,170,255},
              fillColor={213,170,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{-28,-46},{8,26}}),
            Rectangle(
              origin={10,10},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{-34,-38},{14,18}}),
            Rectangle(
              origin={10,10},
              lineColor={213,170,255},
              fillColor={213,170,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{32,-46},{68,26}}),
            Rectangle(
              origin={10,10},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{26,-38},{74,18}})}));
    end Transformers;

    package Components "Machine components like AirGaps"
      extends Modelica.Icons.Package;

      partial model PartialCore
        "Partial model of transformer core with 3 windings"
        parameter Integer m(final min=1) = 3 "Number of phases";
        parameter Real n12(start=1) "Turns ratio 1:2";
        parameter Real n13(start=1) "Turns ratio 1:3";
        Modelica.SIunits.ComplexVoltage v1[m];
        Modelica.SIunits.ComplexCurrent i1[m];
        Modelica.SIunits.ComplexVoltage v2[m];
        Modelica.SIunits.ComplexCurrent i2[m];
        Modelica.SIunits.ComplexVoltage v3[m];
        Modelica.SIunits.ComplexCurrent i3[m];
        Modelica.SIunits.ComplexCurrent im[m] "Magnetizing current";
        QuasiStationary.MultiPhase.Interfaces.PositivePlug plug_p1(final m=m)
          annotation (Placement(transformation(extent={{-110,90},{-90,110}}), iconTransformation(extent={{-110,90},{-90,110}})));
        QuasiStationary.MultiPhase.Interfaces.NegativePlug plug_n1(final m=m)
          annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
        QuasiStationary.MultiPhase.Interfaces.PositivePlug plug_p2(final m=m)
          annotation (Placement(transformation(extent={{90,90},{110,110}})));
        QuasiStationary.MultiPhase.Interfaces.NegativePlug plug_n2(final m=m)
          annotation (Placement(transformation(extent={{90,30},{110,50}})));
        QuasiStationary.MultiPhase.Interfaces.PositivePlug plug_p3(final m=m)
          annotation (Placement(transformation(extent={{90,-30},{110,-50}})));
        QuasiStationary.MultiPhase.Interfaces.NegativePlug plug_n3(final m=m)
          annotation (Placement(transformation(extent={{90,-90},{110,-110}})));
      equation
        v1 = plug_p1.pin.v - plug_n1.pin.v;
        i1 = plug_p1.pin.i;
        v2 = plug_p2.pin.v - plug_n2.pin.v;
        i2 = plug_p2.pin.i;
        v3 = plug_p3.pin.v - plug_n3.pin.v;
        i3 = plug_p3.pin.i;
        im = i1 + i2/n12 + i3/n13;
        //branches p1-n1, p2-n2, p3-n3
        Connections.branch(plug_p1.reference, plug_n1.reference);
        plug_p1.reference.gamma = plug_n1.reference.gamma;
        Connections.branch(plug_p2.reference, plug_n2.reference);
        plug_p2.reference.gamma = plug_n2.reference.gamma;
        Connections.branch(plug_p3.reference, plug_n3.reference);
        plug_p3.reference.gamma = plug_n3.reference.gamma;
        //Define p1.reference.gamme = p2.reference.gamma = p3.reference.gamma
        Connections.branch(plug_p1.reference, plug_p2.reference);
        plug_p1.reference.gamma = plug_p2.reference.gamma;
        Connections.branch(plug_p1.reference, plug_p3.reference);
        plug_p1.reference.gamma = plug_p3.reference.gamma;
        //Note: transformer could be fed from primary or secondary side
        //Define p1, p2 and p3 as potential roots
        //Not necessary since there exist non-breakable branches between primary and secondary side
        //Connections.potentialRoot(plug_p1.reference);
        //Connections.potentialRoot(plug_p2.reference);
        //Connections.potentialRoot(plug_p3.reference);
        //Current balances
        plug_p1.pin.i + plug_n1.pin.i = fill(Complex(0), m);
        plug_p2.pin.i + plug_n2.pin.i = fill(Complex(0), m);
        plug_p3.pin.i + plug_n3.pin.i = fill(Complex(0), m);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                      extent={{-150,150},{150,110}},
                      textString="%name",
                      lineColor={0,0,255}), Line(points={{-90,100},{-30,100}},
                      color={85,170,255}),
                                       Line(points={{-90,-100},{-30,-100}},
                                                                          color={85,170,255}),
                                                     Line(points={{30,100},{90,100}},
                      color={85,170,255}),
                                       Line(points={{30,40},{92,40}}, color={85,170,255}),
                                                     Line(points={{30,-40},{90,-40}},
                       color={85,170,255}),
                                        Line(points={{30,-100},{90,-100}},
                                                                         color={85,170,255}),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={25,90},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={25,70},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={25,50},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={25,-50},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={25,-70},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={25,-90},
                rotation=90),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,90},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,70},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,50},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,30},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,10},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,-10},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,-30},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,-50},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,-70},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={85,170,255},
                smooth=Smooth.Bezier,
                origin={-25,-90},
                rotation=360),
              Text(
                extent={{-150,-110},{150,-150}},
                textString="m=%m")}),
            Documentation(info="<html>
Partial model of transformer core with 3 windings; saturation function flux versus magnetizing current has to be defined.
</html>"));
      end PartialCore;

      model IdealCore "Ideal transformer with 3 windings"
        extends PartialCore;
      equation
        im = fill(Complex(0), m);
        v1 = n12*v2;
        v1 = n13*v3;
        annotation (defaultComponentName="core", Documentation(info="<html>
Ideal transformer with 3 windings: no magnetizing current.
</html>"));
      end IdealCore;
      annotation (Documentation(info="<html>
<p>
This package contains components for modeling electrical machines, specially three-phase induction machines, based on space phasor theory.
</p>
</html>"));
    end Components;
    annotation (Icon(graphics={
          Rectangle(
            origin={0,14.817},
            fillColor={170,213,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-54.179,-59.817},{65.821,60.183}}),
          Rectangle(
            origin={5.821,15},
            fillColor={128,128,128},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-80,-60},{-60,60}}),
          Rectangle(
            origin={5.821,15},
            fillColor={95,95,95},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{60,-10},{80,10}}),
          Rectangle(
            origin={5.821,15},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid,
            extent={{-60,50},{20,70}}),
          Polygon(
            origin={5.821,15},
            fillPattern=FillPattern.Solid,
            points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{
                60,-100},{-70,-100},{-70,-90}})}), Documentation(info="<html>
This package contains components for modeling quasi stationary electrical induction machines, based on space phasor theory:
<ul>
<li>package AsynchronousInductionMachines: quasi stationary models of three phase asynchronous induction machines</li>
<li>package SynchronousInductionMachines: quasi stationary models of three phase synchronous induction machines</li>
<li>package Transformers: quasi stationary three-phase transformers (see detailed documentation in subpackage)</li>
<li>package Components: components for quasi stationary modeling machines and transformers</li>
</ul>
</html>"));
  end BasicMachines;

  package Interfaces "SpacePhasor connector and PartialMachines"
    extends Modelica.Icons.InterfacesPackage;

    partial model PartialBasicTransformer
      "Partial model of three-phase transformer"
      extends Modelica.Electrical.Machines.Icons.QuasiStationaryTransformer;
      constant Integer m(min=1) = 3 "Number of phases";
      constant String VectorGroup="Yy00";
      parameter Real n(start=1)
        "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)";
      parameter Modelica.SIunits.Resistance R1(start=5E-3/(if C1 == "D" then 1
             else 3)) "Primary resistance per phase at TRef"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature T1Ref(start=293.15)
        "Reference temperature of primary resistance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter
        Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
        alpha20_1(start=0)
        "Temperature coefficient of primary resistance at 20 degC"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance L1sigma(start=78E-6/(if C1 == "D"
             then 1 else 3)) "Primary stray inductance per phase"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Resistance R2(start=5E-3/(if C2 == "d" then 1
             else 3)) "Secondary resistance per phase at TRef"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature T2Ref(start=293.15)
        "Reference temperature of secondary resistance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter
        Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
        alpha20_2(start=0)
        "Temperature coefficient of secondary resistance at 20 degC"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance L2sigma(start=78E-6/(if C2 == "d"
             then 1 else 3)) "Secondary stray inductance per phase"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Boolean useThermalPort=false
        "Enable / disable (=fixed temperatures) thermal port"
        annotation (Evaluate=true);
      parameter Modelica.SIunits.Temperature T1Operational(start=293.15)
        "Operational temperature of primary resistance" annotation (Dialog(
            group="Operational temperatures", enable=not useThermalPort));
      parameter Modelica.SIunits.Temperature T2Operational(start=293.15)
        "Operational temperature of secondary resistance" annotation (Dialog(
            group="Operational temperatures", enable=not useThermalPort));
      output Modelica.Electrical.Machines.Interfaces.PowerBalanceTransformer
        powerBalance(
        final power1=sum({Modelica.ComplexMath.real(v1[j]*
            Modelica.ComplexMath.conj(i1[j])) for j in 1:m}),
        final power2=sum({Modelica.ComplexMath.real(v2[j]*
            Modelica.ComplexMath.conj(-i2[j])) for j in 1:m}),
        final lossPower1=-sum(r1.resistor.LossPower),
        final lossPower2=-sum(r2.resistor.LossPower),
        final lossPowerCore=0) "Power balance";
      output Modelica.SIunits.ComplexVoltage v1[m]=plug1.pin.v
        "Primary voltage";
      output Modelica.SIunits.ComplexCurrent i1[m]=plug1.pin.i
        "Primary current";
      output Modelica.SIunits.ComplexVoltage v2[m]=plug2.pin.v
        "Secondary voltage";
      output Modelica.SIunits.ComplexCurrent i2[m]=plug2.pin.i
        "Secondary current";
    protected
      constant String C1=Modelica.Utilities.Strings.substring(
              VectorGroup,
              1,
              1);
      constant String C2=Modelica.Utilities.Strings.substring(
              VectorGroup,
              2,
              2);
      parameter Real ni=n*(if C2 == "z" then sqrt(3) else 2)*(if C2 == "d"
           then 1 else sqrt(3))/(if C1 == "D" then 1 else sqrt(3));
    public
      QuasiStationary.MultiPhase.Interfaces.PositivePlug plug1(final m=m)
        "Primary plug" annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      QuasiStationary.MultiPhase.Interfaces.NegativePlug plug2(final m=m)
        "Secondary plug" annotation (Placement(transformation(extent={{90,-10},
                {110,10}})));
      QuasiStationary.MultiPhase.Basic.Resistor r1(
        final m=m,
        final R_ref=fill(R1, m),
        final T_ref=fill(T1Ref, m),
        final alpha_ref=fill(Modelica.Electrical.Machines.Thermal.convertAlpha(
            alpha20_1, T1Ref), m),
        final useHeatPort=true,
        final T=fill(T1Ref, m)) annotation (Placement(transformation(extent={{-90,
                10},{-70,-10}})));
      QuasiStationary.MultiPhase.Basic.Inductor l1sigma(final m=m, final L=fill(
            L1sigma, m)) annotation (Placement(transformation(extent={{-70,-10},
                {-50,10}})));
      QuasiStationary.MultiPhase.Basic.Resistor r2(
        final m=m,
        final R_ref=fill(R2, m),
        final T_ref=fill(T2Ref, m),
        final alpha_ref=fill(Modelica.Electrical.Machines.Thermal.convertAlpha(
            alpha20_2, T2Ref), m),
        final useHeatPort=true,
        final T=fill(T2Ref, m)) annotation (Placement(transformation(extent={{
                70,10},{90,-10}})));
      QuasiStationary.MultiPhase.Basic.Inductor l2sigma(final m=m, final L=fill(
            L2sigma, m)) annotation (Placement(transformation(extent={{50,-10},
                {70,10}})));
      QuasiStationary.Machines.BasicMachines.Components.IdealCore core(
        final m=m,
        final n12=ni,
        final n13=ni) annotation (Placement(transformation(extent={{-10,-10},{
                10,10}})));
      Modelica.Electrical.Machines.Interfaces.ThermalPortTransformer
        thermalPort if useThermalPort
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Electrical.Machines.Thermal.ThermalAmbientTransformer
        thermalAmbient(
        final useTemperatureInputs=false,
        final T1=T1Operational,
        final T2=T2Operational) if not useThermalPort annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,80})));
    protected
      Modelica.Electrical.Machines.Interfaces.ThermalPortTransformer
        internalThermalPort
        annotation (Placement(transformation(extent={{-4,76},{4,84}})));
    equation
      connect(r1.plug_n, l1sigma.plug_p)
        annotation (Line(points={{-70,0},{-70,0}}, color={85,170,255}));
      connect(l2sigma.plug_n, r2.plug_p)
        annotation (Line(points={{70,0},{70,0}}, color={85,170,255}));
      connect(plug1, r1.plug_p)
        annotation (Line(points={{-100,0},{-90,0}}, color={85,170,255}));
      connect(r2.plug_n, plug2)
        annotation (Line(points={{90,0},{100,0}}, color={85,170,255}));
      connect(thermalPort, internalThermalPort) annotation (Line(
          points={{0,100},{0,80}}, color={191,0,0}));
      connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
          points={{-20,80},{0,80}}, color={191,0,0}));
      connect(r1.heatPort, internalThermalPort.heatPort1) annotation (Line(
          points={{-80,10},{-80,60},{-0.4,60},{-0.4,80.8}}, color={191,0,0}));
      connect(r2.heatPort, internalThermalPort.heatPort2) annotation (Line(
          points={{80,10},{80,60},{-0.4,60},{-0.4,79.2}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{150,-60},{-150,-100}},
              textString="%VectorGroup"), Text(
              extent={{150,100},{-150,60}},
              lineColor={0,0,255},
              textString="%name")}), Documentation(info="<html>
Partial model of a three-phase transformer, containing primary and secondary resistances and stray inductances, as well as the iron core.
Circuit layout (vector group) of primary and secondary windings have to be defined.
<br><strong>Default values for transformer's parameters (a realistic example) are:</strong><br>
<table>
<tr>
<td>turns ratio n</td>
<td>1</td><td> </td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal apparent power</td>
<td>30</td><td>kVA</td>
</tr>
<tr>
<td>primary resistance R1</td>
<td>0.005</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature T1Ref</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20_1 </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>primary stray inductance L1sigma</td>
<td>78E-6</td><td>H per phase</td>
</tr>
<tr>
<td>secondary resistance R2</td>
<td>0.005</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature T2Ref</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20_2 </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>secondary stray inductance L2sigma</td>
<td>78E-6</td><td>H per phase</td>
</tr>
<tr>
<td>operational temperature T1Operational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>operational temperature T2Operational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the operational parameters:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>nominal voltage drop</td>
<td>0.05</td><td>p.u.</td>
</tr>
<tr>
<td>nominal copper losses</td>
<td>300</td><td>W</td>
</tr>
</table>
</html>"));
    end PartialBasicTransformer;
    annotation (Documentation(info="<html>
<p>
This package contains the quasi stationary space phasor connector and partial models for quasi stationary machine models.
</p>
</html>"));
  end Interfaces;

  package SpacePhasors
    "Space phasor components for quasi stationary electric machines"
    extends Modelica.Icons.Package;
    package Blocks
      extends Modelica.Icons.Package;
      block ToSpacePhasor "Conversion: three phase -> space phasor"
        extends Modelica.Blocks.Icons.Block;
        import Modelica.ComplexMath.j;
        import Modelica.ComplexMath.exp;
        import Modelica.ComplexMath.'sum';
        parameter Integer m(min=1) = 3 "Number of phases";
        Modelica.ComplexBlocks.Interfaces.ComplexInput u[m]
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y[2]
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      protected
        parameter Modelica.SIunits.Angle phi[m]=
            Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
        Complex c;
      equation
        c = sqrt(2)/m*'sum'({u[k]*exp(j*phi[k]) for k in 1:m});
        y = {c.re,c.im};
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={85,170,255}),
              Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={
                    85,170,255}),
              Line(
                points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33,
                    17.32},{-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20,
                    -20},{-13.33,-17.32},{-6.67,-10},{0,0}},
                color={85,170,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33,
                    17.32},{-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30,
                    -20},{-23.33,-17.32},{-16.67,-10},{-10,0}},
                color={85,170,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33,
                    17.32},{-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10,
                    -20},{-3.33,-17.32},{3.33,-10},{10,0}},
                color={85,170,255},
                smooth=Smooth.Bezier),
              Text(
                extent={{-12,-74},{64,-86}},
                textString="zero")}),
          Documentation(info="<html>
Transformation of quasi stationary multi phase values (voltages or currents) to space phasor and zero sequence value.
</html>"));
      end ToSpacePhasor;

      block FromSpacePhasor "Conversion: space phasor -> three phase"
        extends Modelica.Blocks.Icons.Block;
        import Modelica.ComplexMath.j;
        import Modelica.ComplexMath.exp;
        parameter Integer m(min=1) = 3 "Number of phases";
        Modelica.Blocks.Interfaces.RealInput u[2]
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m]
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      protected
        parameter Modelica.SIunits.Angle phi[m]=
            Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
      equation
        y = {Complex(u[1], u[2])*exp(-j*phi[k])/sqrt(2) for k in 1:m};
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{0,0},{-80,80},{-60,72},{-72,60},{-80,80}}, color={
                    85,170,255}),
              Line(points={{0,0},{-80,-80},{-72,-60},{-60,-72},{-80,-80}},
                  color={85,170,255}),
              Line(
                points={{0,0},{6.67,10},{13.33,17.32},{20,20},{26.67,17.32},{
                    33.33,10},{40,0},{46.67,-10},{53.33,-17.32},{60,-20},{66.67,
                    -17.32},{73.33,-10},{80,0}},
                color={85,170,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-10,0},{-3.33,10},{3.33,17.32},{10,20},{16.67,17.32},{
                    23.33,10},{30,0},{36.67,-10},{43.33,-17.32},{50,-20},{56.67,
                    -17.32},{63.33,-10},{70,0}},
                color={85,170,255},
                smooth=Smooth.Bezier),
              Line(
                points={{10,0},{16.67,10},{23.33,17.32},{30,20},{36.67,17.32},{
                    43.33,10},{50,0},{56.67,-10},{63.33,-17.32},{70,-20},{76.67,
                    -17.32},{83.33,-10},{90,0}},
                color={85,170,255},
                smooth=Smooth.Bezier),
              Text(
                extent={{-62,-74},{14,-86}},
                textString="zero")}), Documentation(info="<html>
Transformation of space phasor and zero sequence value to quasi stationary multi phase values (voltages or currents).
</html>"));
      end FromSpacePhasor;
    end Blocks;
  end SpacePhasors;
  annotation (Icon(graphics={
        Rectangle(
          origin={0,14.817},
          fillColor={170,213,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-54.179,-59.817},{65.821,60.183}}),
        Rectangle(
          origin={5.821,15},
          fillColor={128,128,128},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-80,-60},{-60,60}}),
        Rectangle(
          origin={5.821,15},
          fillColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{60,-10},{80,10}}),
        Rectangle(
          origin={5.821,15},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{-60,50},{20,70}}),
        Polygon(
          origin={5.821,15},
          fillPattern=FillPattern.Solid,
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{60,
              -100},{-70,-100},{-70,-90}})}), preferredView="info", Documentation(info="<html>
<p><strong>For a discrimination of various machine models, see <a href=\"modelica://Modelica.Electrical.Machines.UsersGuide.Discrimination\">discrimination</a></strong>.</p>
<p>This package hosts models for quasi stationary induction machines and transformers.
</p>
<h4>Please note</h4>
<p>
Quasi stationary DC machines are still operated with Dc voltage and current, whereas the quasi stationary induction machines and transformers
are operated with sinusoidal voltages and currents represented by time phasors. Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
Quasi stationary DC machine models therefore are part of the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.QuasiStationaryDCMachines\">machines library</a>.
</p>

</html>"));
end Machines;
