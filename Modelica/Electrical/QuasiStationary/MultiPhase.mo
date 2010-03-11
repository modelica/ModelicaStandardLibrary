within Modelica.Electrical.QuasiStationary;
package MultiPhase "Multiphase AC components"
  extends Modelica.Icons.Library2;

  package Basic "Basic components for AC multiphase models"
    extends Modelica.Icons.Library2;

    model Star "Star connection"
      parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
        pin_n
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
      PlugToPins_p plugToPins_p annotation (Placement(transformation(extent={{-80,
                -10},{-60,10}}, rotation=0)));
    equation
      for j in 1:m loop
        connect(plugToPins_p.pin_p[j], pin_n);
      end for;
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-93,0},{-93,1.16573e-015},{-86,1.16573e-015},
              {-86,0},{-72,0}},                                  color={85,170,255}));
      annotation (Icon(graphics={
            Text(extent={{-150,60},{150,120}}, textString=
                                                  "%name"),
            Line(
              points={{80,0},{0,0}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{0,0},{-39,68}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{0,0},{-38,-69}},
              color={0,0,255},
              thickness=0.5),
            Text(
              extent={{-100,-110},{100,-70}},
              lineColor={0,0,0},
              textString=                            "m=%m"),
            Line(points={{-90,0},{-40,0}}, color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255})}),
      Documentation(info="<html>
<p>
Star (wye) connection of a multi phase circuit. The potentials at the star points are the same.
</p>
<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Delta>Delta</a>
</p>
</html>"));
    end Star;

    model Delta "Delta (polygon) connection"
      parameter Integer m(final min=2) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));

      PlugToPins_p plugToPins_p annotation (Placement(transformation(extent={{-80,
                -10},{-60,10}}, rotation=0)));
      PlugToPins_n plugToPins_n annotation (Placement(transformation(extent={{80,
                -10},{60,10}}, rotation=0)));
    equation
      for j in 1:m loop
        if j<m then
          connect(plugToPins_p.pin_p[j], plugToPins_n.pin_n[j+1]);
        else
          connect(plugToPins_p.pin_p[j], plugToPins_n.pin_n[1]);
        end if;
      end for;
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-93,0},{-93,1.16573e-015},{-86,1.16573e-015},
              {-86,0},{-72,0}},
            color={85,170,255}));
      connect(plugToPins_n.plug_n, plug_n)
        annotation (Line(points={{72,0},{79,0},{79,1.16573e-015},{86,1.16573e-015},
              {86,0},{100,0}},
            color={85,170,255}));
      annotation (Icon(graphics={
            Text(
              extent={{-150,60},{150,120}},
              lineColor={0,0,255},
              textString=                         "%name"),
            Line(
              points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}},
              color={0,0,255},
              thickness=0.5),
            Text(
              extent={{-100,-110},{100,-70}},
              lineColor={0,0,0},
              textString=                            "m=%m"),
            Line(points={{-90,0},{-40,0}}, color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255})}),
      Documentation(info="<html>
<p>
Delta (polygon) connection of a multi phase circuit.
</p>
<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star>Star</a>
</p>
</html>"));
    end Delta;

    model PlugToPin_p "Connect one (positive) pin"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Integer k(
        final min=1,
        final max=m) = 1 "Phase index";
      Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}}, rotation=
                0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
        pin_p
        annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
    equation
      Connections.branch(plug_p.reference, pin_p.reference);
      plug_p.reference.gamma = pin_p.reference.gamma;
      pin_p.v = plug_p.pin[k].v;
      for j in 1:m loop
        plug_p.pin[j].i = if j == k then -pin_p.i else Complex(0);
       end for;
      annotation (Icon(graphics={
            Rectangle(
              extent={{-20,20},{40,-20}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,100},{100,40}}, textString=
                                                "%name"),
            Text(
              extent={{-100,-60},{100,-100}},
              lineColor={0,0,0},
              textString=                         "k = %k")}),
      Documentation(info="<html>
<p>
Connects the single phase (positive) pin <i>k</i> of the multi phase (positive) plug to a single phase (positive) pin.
</p>
<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n>PlugToPin_n</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p>PlutToPins_p</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n>PlugToPins_n</a>
</p>
</html>"));
    end PlugToPin_p;

    model PlugToPin_n "Connect one (negative) pin"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Integer k(
        final min=1,
        final max=m) = 1 "Phase index";
      Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}}, rotation=
                0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
        pin_n
        annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
    equation
      Connections.branch(plug_n.reference, pin_n.reference);
      plug_n.reference.gamma = pin_n.reference.gamma;
      pin_n.v = plug_n.pin[k].v;
      for j in 1:m loop
        plug_n.pin[j].i = if j == k then -pin_n.i else Complex(0);
      end for;
      annotation (Icon(graphics={
            Rectangle(
              extent={{-20,20},{40,-20}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,100},{100,40}}, textString=
                                                "%name"),
            Text(
              extent={{-100,-60},{100,-100}},
              lineColor={0,0,0},
              textString=                         "k = %k")}),
      Documentation(info="<html>
<p>
Connects the single phase (negative) pin <i>k</i> of the multi phase (negative) plug to a single phase (negative) pin.
</p>
<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p>PlugToPin_p</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p>PlutToPins_p</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n>PlugToPins_n</a>
</p>
</html>"));
    end PlugToPin_n;

    model PlugToPins_p "Connect all (positive) pins"
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}}, rotation=
                0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
        pin_p[                                 m]
        annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
    equation
      for j in 1:m loop
        Connections.branch(plug_p.reference, pin_p[j].reference);
        plug_p.reference.gamma = pin_p[j].reference.gamma;
        plug_p.pin[j].v = pin_p[j].v;
        plug_p.pin[j].i = -pin_p[j].i;
      end for;
      annotation (Icon(graphics={
            Rectangle(
              extent={{-20,20},{40,-20}},
              lineColor={0,0,0},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,100},{100,40}}, textString=
                                                "%name")}),
      Documentation(info="<html>
<p>
Connects all <i>m</i> single phase (positive) pins of the multi phase (positive) plug to an array of <i>m</i> single phase (positive) pins.
</p>
<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p>PlugToPin_p</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n>PlugToPin_n</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n>PlugToPins_n</a>
</p>
</html>"));
    end PlugToPins_p;

    model PlugToPins_n "Connect all (negative) pins"
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}}, rotation=
                0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
        pin_n[                                 m]
        annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
    equation
      for j in 1:m loop
        Connections.branch(plug_n.reference, pin_n[j].reference);
        plug_n.reference.gamma = pin_n[j].reference.gamma;
        plug_n.pin[j].v = pin_n[j].v;
        plug_n.pin[j].i = -pin_n[j].i;
      end for;
      annotation (Icon(graphics={
            Rectangle(
              extent={{-20,20},{40,-20}},
              lineColor={0,0,0},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,100},{100,40}}, textString=
                                                "%name")}),
      Documentation(info="<html>
<p>
Connects all <i>m</i> single phase (negative) pins of the multi phase (negative) plug to an array of <i>m</i> single phase (negative) pins.
</p>
<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p>PlugToPin_p</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n>PlugToPin_n</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p>PlugToPins_p</a>
</p>
</html>"));
    end PlugToPins_n;

    model Resistor "Multiphase linear resistor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance R_ref[m](start=fill(1,m))
        "Reference resistances at T_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15,m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor[
                                          m](
        final R_ref=R_ref,
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plugToPins_p.pin_p, resistor.pin_p)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},
            color={85,170,255}));
      connect(resistor.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,
              2.44929e-016}},                   color={85,170,255}));
      connect(resistor.heatPort, heatPort)
        annotation (Line(points={{0,-10},{0,-32.5},{1.16573e-015,-32.5},{1.16573e-015,
              -55},{0,-55},{0,-100}},
                                   color={191,0,0}));
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                 "%name"),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{100,-80},{-100,-40}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The linear resistor connects the complex voltages <i><u>v</u></i> with the complex
currents <i><u>i</u></i> by <i><u>i</u>*R = <u>v</u></i>,
using <i>m</i> <a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>single phase Resistors</a>.
</p>

<p>
The resistor model also has <i>m</i> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the resistances for enabled heat ports is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Resistor;

    model Conductor "Multiphase linear conductor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Conductance G_ref[m](start=fill(1,m))
        "Reference conductances at T_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15,m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
        "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor conductor[
                                            m](
        final G_ref=G_ref,
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plugToPins_p.pin_p, conductor.pin_p)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},
            color={85,170,255}));
      connect(conductor.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,
              2.44929e-016}},                   color={85,170,255}));
      connect(conductor.heatPort, heatPort)
        annotation (Line(points={{0,-10},{0,-32.5},{1.16573e-015,-32.5},{1.16573e-015,
              -55},{0,-55},{0,-100}},
                                   color={191,0,0}));
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name"),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{100,-80},{-100,-40}},
              lineColor={0,0,0},
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The linear resistor connects the complex currents <i><u>i</u></i> with the complex
voltages <i><u>v</u></i> by <i><u>v</u>*G = <u>i</u></i>,
using <i>m</i> <a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>single phase Conductors</a>.
</p>

<p>
The conductor model also has <i>m</i> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the conductances for enabled heat ports is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Conductor;

    model Capacitor "Multiphase linear capacitor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Capacitance C[m](start=fill(1,m))
        "Capacitances";
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor capacitor[
                                            m](final C=C)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plugToPins_p.pin_p, capacitor.pin_p)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},
            color={85,170,255}));
      connect(capacitor.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,
              2.44929e-016}},                   color={85,170,255}));
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name"),
            Line(
              points={{-14,28},{-14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{14,28},{14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,0},{-14,0}}),
            Line(points={{14,0},{90,0}}),
            Text(
              extent={{100,-80},{-100,-40}},
              lineColor={0,0,0},
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The linear capacitor connects the complex currents <i><u>i</u></i> with the complex
voltages <i><u>v</u></i> by <i><u>v</u>*j*&omega;*C = <u>i</u></i>,
using <i>m</i> <a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>single phase Capacitors</a>.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Capacitor;

    model Inductor "Multiphase linear inductor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Inductance L[m](start=fill(1,m)) "Inductances";
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor[
                                          m](final L=L)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation

      connect(plugToPins_p.pin_p, inductor.pin_p) annotation (Line(points={{-68,0},
              {-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},{-39,0},{-10,0}},
                                                                    color={85,170,
              255}));
      connect(inductor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
              39,0},{39,2.44929e-016},{68,2.44929e-016}},
            color={85,170,255}));
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name"),
            Ellipse(extent={{-60,-15},{-30,15}}),
            Ellipse(extent={{-30,-15},{0,15}}),
            Ellipse(extent={{0,-15},{30,15}}),
            Ellipse(extent={{30,-15},{60,15}}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Text(
              extent={{100,-80},{-100,-40}},
              lineColor={0,0,0},
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The linear inductor connects the complex voltages <i><u>v</u></i> with the complex
currents <i><u>i</u></i> by <i><u>i</u>*j*&omega;*L = <u>v</u></i>,
using <i>m</i> <a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>single phase Inductors</a>.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Inductor;

    model VariableResistor "Multiphase variable resistor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15,m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
      Modelica.Blocks.Interfaces.RealInput R_ref[m]
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor
        variableResistor[                                 m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation

      connect(variableResistor.pin_p, plugToPins_p.pin_p)
        annotation (Line(points={{-10,0},{-24.5,0},{-24.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-68,0}},
            color={85,170,255}));
      connect(variableResistor.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,2.44929e-016}},
                                                color={85,170,255}));
      connect(variableResistor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-10},{0,-100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(R_ref, variableResistor.R_ref) annotation (Line(
          points={{0,110},{0,62},{0,62},{0,11}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name"),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,90},{0,30}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{100,40},{-100,80}},
              lineColor={0,0,0},
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The linear resistor connects the complex voltages <i><u>v</u></i> with the complex
currents <i><u>i</u></i> by <i><u>i</u>*R = <u>v</u></i>,
using <i>m</i> <a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>single phase variable Resistors</a>.
The resistances <i>R</i> are given as <i>m</i> input signals.
</p>

<p>
The resistor model also has <i>m</i> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the resistances for enabled heat ports is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>VariableResistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableResistor;

    model VariableConductor "Multiphase variable conductor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15,m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
        "Temperature coefficient of resistance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
      Modelica.Blocks.Interfaces.RealInput G_ref[m]
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor
        variableResistor[                                  m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(variableResistor.pin_p, plugToPins_p.pin_p)
        annotation (Line(points={{-10,0},{-24.5,0},{-24.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-68,0}},
            color={85,170,255}));
      connect(variableResistor.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,2.44929e-016}},
                                                color={85,170,255}));
      connect(variableResistor.heatPort, heatPort)
        annotation (Line(points={{0,-10},{0,-32.5},{1.16573e-015,-32.5},{1.16573e-015,
              -55},{0,-55},{0,-100}},
                                   color={191,0,0}));
      connect(G_ref, variableResistor.G_ref)
        annotation (Line(points={{0,110},{0,85.25},{1.77635e-015,85.25},{1.77635e-015,
              60.5},{0,60.5},{0,11}},
                                 color={0,0,127}));
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name"),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,90},{0,30}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{100,40},{-100,80}},
              lineColor={0,0,0},
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The linear resistor connects the complex currents <i><u>i</u></i> with the complex
voltages <i><u>v</u></i> by <i><u>v</u>*G = <u>i</u></i>,
using <i>m</i> <a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>single phase variable Conductors</a>.
The conductances <i>G</i> are given as <i>m</i> input signals.
</p>

<p>
The conductor model also has <i>m</i> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the conductances for enabled heat ports is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>VariableConductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableConductor;

    model VariableCapacitor "Multiphase variable capacitor"
      extends Interfaces.TwoPlug;
      Modelica.Blocks.Interfaces.RealInput C[m]
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor
        variableCapacitor[                                  m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(variableCapacitor.pin_p, plugToPins_p.pin_p)
        annotation (Line(points={{-10,0},{-24.5,0},{-24.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-68,0}},
            color={85,170,255}));
      connect(variableCapacitor.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,2.44929e-016}},
                                                color={85,170,255}));
      connect(C, variableCapacitor.C) annotation (Line(
          points={{0,110},{0,61},{0,61},{0,11}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name"),
            Line(
              points={{-14,28},{-14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{14,28},{14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,0},{-14,0}}),
            Line(points={{14,0},{90,0}}),
            Line(points={{0,90},{0,30}}, color={0,0,255}),
            Text(
              extent={{100,40},{-100,80}},
              lineColor={0,0,0},
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The linear capacitor connects the complex currents <i><u>i</u></i> with the complex
voltages <i><u>v</u></i> by <i><u>v</u>*j*&omega;*C = <u>i</u></i>,
using <i>m</i> <a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>single phase variable Capacitors</a>.
The capacitances <i>C</i> are given as <i>m</i> input signals.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>VariableCapacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableCapacitor;

    model VariableInductor "Multiphase variable inductor"
      extends Interfaces.TwoPlug;
      Modelica.Blocks.Interfaces.RealInput L[m]
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor
        variableInductor[                                 m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(variableInductor.pin_p, plugToPins_p.pin_p)
        annotation (Line(points={{-10,0},{-24.5,0},{-24.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-68,0}},
            color={85,170,255}));
      connect(variableInductor.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,2.44929e-016}},
                                                color={85,170,255}));
      connect(variableInductor.L, L)
        annotation (Line(points={{0,10.8},{0,35.6},{1.77636e-015,35.6},{1.77636e-015,
              60.4},{0,60.4},{0,110}},
                                  color={0,0,127}));
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name"),
            Ellipse(extent={{-60,-15},{-30,15}}),
            Ellipse(extent={{-30,-15},{0,15}}),
            Ellipse(extent={{0,-15},{30,15}}),
            Ellipse(extent={{30,-15},{60,15}}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Line(points={{0,90},{0,8}}, color={0,0,255}),
            Text(
              extent={{100,40},{-100,80}},
              lineColor={0,0,0},
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The linear inductor connects the complex voltages <i><u>v</u></i> with the complex
currents <i><u>i</u></i> by <i><u>i</u>*j*&omega;*L = <u>v</u></i>,
using <i>m</i> <a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>single phase variable Inductors</a>.
The inductances <i>L</i> are given as <i>m</i> input signals.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>
</p>
</html>"));
    end VariableInductor;
    annotation (Icon(graphics={
        Line(points={{-100,-40},{-80,-40}}),
        Line(points={{60,-40},{80,-40}}),
        Rectangle(
          extent={{-80,-10},{60,-70}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This package hosts basic models for quasi stationary multiphase circuits.
Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic\">SinglePhase.Basic</a>

</html>"));
  end Basic;

  package Ideal "Ideal components for AC multiphase models"
    extends Modelica.Icons.Library2;

    model Idle "Idle branch"
      extends Interfaces.TwoPlug;

    Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle idle[
                                m] annotation (Placement(transformation(extent={{
                -10,-10},{10,10}}, rotation=0)));

    equation
    connect(plugToPins_p.pin_p, idle.pin_p) annotation (Line(points={{-68,0},{-10,0}},
            color={85,170,255}));
    connect(idle.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},
              {39,2.44929e-016},{68,2.44929e-016}}, color={0,127,0}));
    annotation (
      Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-41,0}}),
            Line(points={{91,0},{40,0}}),
            Text(extent={{-100,100},{100,70}}, textString=
                                                   "%name")}),
      Documentation(info="<html>
<p>
This model describes <i>m</m> simple idle branches considering the complex currents <i><u>i</u></i> = 0;
it uses <i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle\">single phase idle branches</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.Short\">Short</a>
</p>
</html>"));
    end Idle;

    model Short "Short cut branch"
      extends Interfaces.TwoPlug;

    Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short short[
                                  m] annotation (Placement(transformation(extent={{
                -10,-10},{10,10}}, rotation=0)));

    equation
    connect(plugToPins_p.pin_p, short.pin_p) annotation (Line(points={{-68,0},{-10,
              0}}, color={85,170,255}));
    connect(short.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},
              {39,2.44929e-016},{68,2.44929e-016}}, color={0,127,0}));
    annotation (
      Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,100},{100,70}}, textString=
                                                   "%name"),
            Line(points={{91,0},{-90,0}})}),
      Documentation(info="<html>
<p>
This model describes <i>m</m> simple short branches considering the complex voltages <i><u>v</u></i> = 0;
it uses <i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short\">single phase short branches</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short\">Short</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.Idle\">Idle</a>
</p>
</html>"));
    end Short;
  annotation (Icon(graphics={
        Line(points={{-100,-60},{-54,-60}}),
        Ellipse(extent={{-54,-56},{-46,-64}}),
        Line(points={{-47,-58},{30,-10}}),
        Line(points={{30,-40},{30,-60}}),
        Line(points={{30,-60},{80,-60}})}), Documentation(info="<html>
<p>This package hosts ideal models for quasi stationary multiphase circuits.
Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal\">SinglePhase.Ideal</a>

</html>"));
  end Ideal;

  package Interfaces "Interfaces for AC multiphase models"
    extends Modelica.Icons.Library2;

    connector Plug "Basic multiphase plug"
      parameter Integer m=3 "number of phases";
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin pin[
                                     m];
      annotation (Documentation(info="<html>

<p>
This multiphase plug contains a vector of <i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">single phase pins</a>.
The <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive</a> and
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">negative plug</a> are
derived from this base connector.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
    end Plug;

    connector PositivePlug "Positive multiphase connector"
      extends Plug;
      Modelica.Electrical.QuasiStationary.Types.Reference reference;
      annotation (Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),
                                Diagram(graphics={Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}),
      Documentation(info="<html>

<p>
The positive plug is based on <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angluar velocity of each quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">negative plug</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
    end PositivePlug;

    connector NegativePlug "Negative multiphase connector"
      extends Plug;
      Modelica.Electrical.QuasiStationary.Types.Reference reference;
      annotation (Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                                Diagram(graphics={Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}),
      Documentation(info="<html>

<p>
The negative plug is based on <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angluar velocity of each quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive plug</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
</p>
</html>"));
    end NegativePlug;

    partial model TwoPlug "Two plugs with pin-adapter"
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.SIunits.ComplexVoltage v[m];
      Modelica.SIunits.ComplexCurrent i[m];
      Modelica.SIunits.AngularVelocity omega = der(plug_p.reference.gamma);
      PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Basic.PlugToPins_p plugToPins_p(final m=m)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=
                0)));
      Basic.PlugToPins_n plugToPins_n(final m=m)
        annotation (Placement(transformation(
            origin={70,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    equation
      v = plug_p.pin.v - plug_n.pin.v;
      i = plug_p.pin.i;
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-93,0},{-93,1.16573e-015},{-86,1.16573e-015},
              {-86,0},{-72,0}},
            color={85,170,255}));
      connect(plugToPins_n.plug_n, plug_n)
        annotation (Line(points={{72,-2.44929e-016},{86,-2.44929e-016},{86,0},{
              100,0}},                           color={85,170,255}));
      annotation (         Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">negative plug</a> and defines the complex voltage differences as well as the complex currents (into the positive plug). A <a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p\">positive</a> and
a <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n\">negative adapter</a> are used to give easy acces to the single pins of both plugs. Additionally, the angular velocity of the quasi stationary system is explicitely defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>,
</p>
</html>"));
    end TwoPlug;

    partial model AbsoluteSensor "Partial potential sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(min=1) = 3 "number of phases";
      Modelica.SIunits.AngularVelocity omega = der(plug_p.reference.gamma);
      PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m]
        annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=
                0)));
      Basic.PlugToPins_p plugToPins_p(final m=m)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=
                0)));
    equation
      connect(plug_p, plugToPins_p.plug_p)
          annotation (Line(
          points={{-100,0},{-93,0},{-93,1.16573e-015},{-86,1.16573e-015},{-86,0},{-72,
              0}},
          color={85,170,255},
          smooth=Smooth.None));
      annotation (         Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={0,0,0}),
            Text(
              extent={{-100,100},{100,70}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),
            Line(points={{70,0},{80,0},{90,0},{100,0}}, color={85,170,255}),
            Text(
              extent={{100,-100},{-100,-70}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "m=%m")}),
      Documentation(info="<html>

<p>
The absolute sensor partial model relies on the a
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive plug</a> to measure the complex potential. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">RelativeSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor\">SinglePhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor\">SinglePhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
    end AbsoluteSensor;

    partial model RelativeSensor "Partial voltage / current sensor"
      extends Modelica.Icons.RotationalSensor;
      extends TwoPlug;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m]
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      annotation (         Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={0,0,0}),
            Line(points={{70,0},{94,0}}, color={0,0,0}),
            Text(
              extent={{-100,100},{100,70}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),
            Line(points={{0,-70},{0,-80},{0,-90},{0,-100}}, color={85,170,255}),
            Text(
              extent={{100,-100},{-100,-70}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug\">TwoPlug</a> to measure the complex voltages, currents or power. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor\">SinglePhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor\">SinglePhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
    end RelativeSensor;

    partial model Source "Partial voltage / current source"
      extends TwoPlug;
      constant Modelica.SIunits.Angle pi=Modelica.Constants.pi;
      annotation (Icon(graphics={
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{100,-100},{-100,-60}}, textString=
                                                   "%name"),
            Line(points={{-90,0},{-50,0}}, color={0,0,0}),
            Line(points={{50,0},{90,0}}, color={0,0,0}),
            Text(
              extent={{100,60},{-100,100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "m=%m")}),
      Documentation(info="<html>
<p>
The source partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug\">TwoPlug</a> and contains a proper icon.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MutliPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Source\">SinglePhase.Interfaces.Source</a>.
</p>
</html>"));
    end Source;
    annotation (Icon(graphics={
        Ellipse(extent={{-60,10},{40,-90}}, lineColor={0,0,255}),
        Ellipse(
          extent={{-40,-14},{-20,-34}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,-14},{20,-34}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-54},{0,-74}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
  end Interfaces;

  package Sensors "AC multiphase sensors"
    extends Modelica.Icons.Library2;

    model PotentialSensor
      extends Interfaces.AbsoluteSensor;
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor
        potentialSensor[                                  m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation

      connect(plugToPins_p.pin_p, potentialSensor.pin) annotation (Line(points={{-68,0},
              {-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},{-39,0},{-10,0}},
                                                                    color={85,170,
              255}));
      connect(potentialSensor.y, y) annotation (Line(points={{11,0},{35.75,0},{35.75,
              1.16573e-015},{60.5,1.16573e-015},{60.5,0},{110,0}},
                                                 color={85,170,255}));
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "V")}),
      Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex potentials, using <i>m</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">single phase PotentialSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">SinglePhase.PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end PotentialSensor;

    model VoltageSensor
      extends Interfaces.RelativeSensor;
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor
        voltageSensor[                                m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plugToPins_p.pin_p, voltageSensor.pin_p)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},
            color={85,170,255}));
      connect(voltageSensor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
              39,0},{39,2.44929e-016},{68,2.44929e-016}},
            color={85,170,255}));
      connect(voltageSensor.y, y)
        annotation (Line(points={{0,-11},{0,-35.75},{1.16573e-015,-35.75},{1.16573e-015,
              -60.5},{0,-60.5},{0,-110}},
                                   color={85,170,255}));
      annotation (         Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "V")}),
      Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex voltages, using <i>m</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">single phase VoltageSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">SinglePhase.VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end VoltageSensor;

    model CurrentSensor
      extends Interfaces.RelativeSensor;
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
        currentSensor[                                m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plugToPins_p.pin_p,currentSensor. pin_p)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},
            color={85,170,255}));
      connect(currentSensor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
              39,0},{39,2.44929e-016},{68,2.44929e-016}},
            color={85,170,255}));
      connect(currentSensor.y, y)
        annotation (Line(points={{0,-11},{0,-35.75},{1.16573e-015,-35.75},{1.16573e-015,
              -60.5},{0,-60.5},{0,-110}},
                                   color={85,170,255}));
      annotation (         Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "I")}),
      Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex currents, using <i>m</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">single phase CurrentSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">SinglePhase.CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end CurrentSensor;

    model PowerSensor
      parameter Integer m(min=1) = 3 "number of phases";
      Modelica.SIunits.AngularVelocity omega = der(currentP.reference.gamma);
      Interfaces.PositivePlug currentP
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Interfaces.NegativePlug currentN
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Interfaces.PositivePlug voltageP
        annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
      Interfaces.NegativePlug voltageN
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
               0)));
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y
        annotation (Placement(transformation(
            origin={-80,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.PlugToPins_p plugToPinsCurrentP(final m=m)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=
                0)));
      Basic.PlugToPins_p plugToPinsVoltageP(final m=m)
        annotation (Placement(transformation(
            origin={0,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.PlugToPins_n plugToPinsCurrentN(final m=m)
        annotation (Placement(transformation(extent={{80,-10},{60,10}}, rotation=0)));
      Basic.PlugToPins_n plugToPinsVoltageN(final m=m)
        annotation (Placement(transformation(
            origin={0,-70},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor
        powerSensor[                              m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
      Modelica.ComplexBlocks.ComplexMath.Sum sum(final nin=m)
        annotation (Placement(transformation(
            origin={-80,-70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(plugToPinsCurrentP.plug_p, currentP)
        annotation (Line(points={{-72,0},{-79,0},{-79,1.16573e-015},{-86,1.16573e-015},
              {-86,0},{-100,0}},
                              color={85,170,255}));
      connect(currentN, plugToPinsCurrentN.plug_n)
        annotation (Line(points={{100,0},{93,0},{93,1.16573e-015},{86,1.16573e-015},
              {86,0},{72,0}},
            color={85,170,255}));
      connect(voltageP, plugToPinsVoltageP.plug_p) annotation (Line(points={{0,100},
              {0,100},{0,72},{3.67394e-016,72}},                             color=
              {85,170,255}));
      connect(plugToPinsVoltageN.plug_n, voltageN) annotation (Line(points={{-1.22465e-016,
              -72},{0,-72},{0,-100}},                                    color={85,
              170,255}));
      connect(plugToPinsCurrentP.pin_p, powerSensor.currentP)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},
            color={85,170,255}));
      connect(powerSensor.currentN, plugToPinsCurrentN.pin_n)
        annotation (Line(points={{10,0},{24.5,0},{24.5,1.22125e-015},{39,1.22125e-015},
              {39,0},{68,0}},
            color={85,170,255}));
      connect(powerSensor.voltageP, plugToPinsVoltageP.pin_p) annotation (Line(
            points={{0,10},{0,10},{0,68},{-3.67394e-016,68}},
            color={85,170,255}));
      connect(powerSensor.voltageN, plugToPinsVoltageN.pin_n) annotation (Line(
            points={{0,-10},{0,-10},{0,-68},{1.22465e-016,-68}},
                     color={85,170,255}));
      connect(powerSensor.y, sum.u) annotation (Line(points={{-8,-11},{-8,-40},{-80,
              -40},{-80,-58}}, color={85,170,255}));
      connect(sum.y, y) annotation (Line(points={{-80,-81},{-80,-110}}, color={85,
              170,255}));
      connect(currentP, currentP) annotation (Line(points={{-100,0},{-100,0},{-100,0}},
                                                       color={85,170,255}));
      annotation (         Icon(graphics={
            Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,100},{0,70}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={0,0,255}),
            Line(points={{-100,0},{100,0}}, color={0,0,255}),
            Line(points={{0,70},{0,40}}, color={0,0,0}),
            Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
            Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
            Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
            Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "P"),
            Line(points={{-80,-100},{-80,0}}, color={85,170,255})}),
      Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex apparent power values, using <i>m</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">single phase PowerSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">SinglePhase.PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>
</p>

</html>"));
    end PowerSensor;
    annotation (Icon(graphics={
        Ellipse(
          extent={{-60,10},{40,-90}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-16},{-36,-25}}, color={0,0,0}),
        Line(points={{-35,0},{-25,-14}}, color={0,0,0}),
        Line(points={{-10,7},{-10,-10}}, color={0,0,0}),
        Line(points={{15,0},{5,-14}}, color={0,0,0}),
        Line(points={{30,-15},{16,-25}}, color={0,0,0}),
        Polygon(
          points={{-12,-24},{-0.5,-27},{2,1.5},{-12,-24}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-10,-40},{-6,-26}}, color={0,0,0}),
        Ellipse(
          extent={{-15,-35},{-5,-45}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This package hosts sensors for quasi stationary multiphase circuits.
Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors\">SinglePhase.Sensors</a>

</html>"));
  end Sensors;

  package Sources "AC multiphase sources"
    extends Modelica.Icons.Library2;

    model VoltageSource "Constant multiphase AC voltage"
      extends Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      parameter Modelica.SIunits.Voltage V[m](start=fill(1,m))
        "RMS voltage of the source";
      parameter Modelica.SIunits.Angle phi[m]={0 - (j-1)*2*pi/m for j in 1:m}
        "Phase shift of the source";
      Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
        voltageSource[                                m](
        each final f=f,
        final V=V,
        final phi=phi)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plugToPins_p.pin_p, voltageSource.pin_p)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},                                  color={85,170,255}));
      connect(voltageSource.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
              39,0},{39,2.44929e-016},{68,2.44929e-016}},
            color={85,170,255}));
      annotation (Icon(graphics={
            Line(points={{50,0},{-50,0}}, color={0,0,0}),
            Text(
              extent={{-120,50},{-20,0}},
              lineColor={0,0,255},
              textString=
                      "+"),
            Text(
              extent={{20,50},{120,0}},
              lineColor={0,0,255},
              textString=
                      "-")}),
      Documentation(info="<html>

<p>
This model describes <i>m</i> constant voltage sources, specifying the complex voltages by the RMS voltages and the phase shifts.
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">single phase VoltageSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end VoltageSource;

    model VariableVoltageSource "Variable multiphase AC voltage"
      extends Interfaces.Source;
      Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource
        variableVoltageSource[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput f
        annotation (Placement(transformation(
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V[m]
        annotation (Placement(transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      for j in 1:m loop
        connect(f, variableVoltageSource[j].f)
          annotation (Line(points={{40,100},{40,60},{4,60},{4,10}}, color={0,0,127}));
      end for;
      connect(plugToPins_p.pin_p, variableVoltageSource.pin_p)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},                                  color={85,170,255}));
      connect(variableVoltageSource.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,
              2.44929e-016}},                   color={85,170,255}));
      connect(V, variableVoltageSource.V)
        annotation (Line(points={{-40,100},{-40,60},{-4,60},{-4,10}}, color={85,170,
              255}));
      annotation (Icon(graphics={
            Line(points={{50,0},{-50,0}}, color={0,0,0}),
            Text(
              extent={{-120,50},{-20,0}},
              lineColor={0,0,255},
              textString=
                      "+"),
            Text(
              extent={{20,50},{120,0}},
              lineColor={0,0,255},
              textString=
                      "-")}),
      Documentation(info="<html>

<p>
This model describes <i>m</i> variable voltage sources, with <i>m</i> complex signal inputs,
specifying the complex voltages by the complex RMS voltage components.
Additionally, the frequency of the voltage source is defined by a real signal input.
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">single phase VariableVoltageSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end VariableVoltageSource;

    model CurrentSource "Constant multiphase AC current"
      extends Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      parameter Modelica.SIunits.Current I[m](start=fill(1,m))
        "RMS current of the source";
      parameter Modelica.SIunits.Angle phi[m]={0 - (j-1)*2*pi/m for j in 1:m}
        "Phase shift of the source";
      Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource
        currentSource[                                m](
        each final f=f,
        final phi=phi,
        final I=I)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plugToPins_p.pin_p,currentSource. pin_p)
        annotation (Line(points={{-68,0},{-10,0}}, color={85,170,255}));
      connect(currentSource.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
              39,0},{39,2.44929e-016},{68,2.44929e-016}},     color={85,170,255}));
      annotation (Icon(graphics={
            Line(points={{-60,60},{60,60}}, color={0,0,255}),
            Polygon(
              points={{60,60},{30,70},{30,50},{60,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,-50},{0,50}}, color={0,0,0})}),
      Documentation(info="<html>

<p>
This model describes <i>m</i> constant current sources, specifying the complex currents by the RMS currents and the phase shifts.
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">single phase CurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">SinglePhase.CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end CurrentSource;

    model VariableCurrentSource "Variable multiphase AC current"
      extends Interfaces.Source;
      Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource
        variableCurrentSource[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput f
        annotation (Placement(transformation(
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput I[m]
        annotation (Placement(transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      for j in 1:m loop
        connect(f, variableCurrentSource[j].f)
          annotation (Line(points={{40,100},{40,60},{4,60},{4,10}}, color={0,0,127}));
      end for;
      connect(plugToPins_p.pin_p, variableCurrentSource.pin_p)
        annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
              {-39,0},{-10,0}},
            color={85,170,255}));
      connect(variableCurrentSource.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,
              2.44929e-016}},                   color={85,170,255}));
      connect(I, variableCurrentSource.I) annotation (Line(points={{-40,100},{-40,
              60},{-4,60},{-4,10}}, color={85,170,255}));
      annotation (Icon(graphics={
            Line(points={{-60,60},{60,60}}, color={85,170,255}),
            Polygon(
              points={{60,60},{30,70},{30,50},{60,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,-50},{0,50}}, color={0,0,0})}),
      Documentation(info="<html>

<p>
This model describes <i>m</i> variable current sources, with <i>m</i> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">single phase VariableCurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"));
    end VariableCurrentSource;
    annotation (Icon(graphics={
        Line(points={{-100,-40},{-60,-40}}),
        Ellipse(
          extent={{-60,10},{40,-90}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{40,-40},{80,-40}})}), Documentation(info="<html>
<p>This package hosts sources for quasi stationary multiphase circuits.
Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources\">SinglePhase.Sources</a>

</html>"));
  end Sources;
  annotation (Icon(graphics={
      Ellipse(extent={{-60,10},{40,-90}}, lineColor={0,0,255}),
      Ellipse(
        extent={{-40,-14},{-20,-34}},
        lineColor={0,0,255},
        fillColor={0,0,255},
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{0,-14},{20,-34}},
        lineColor={0,0,255},
        fillColor={0,0,255},
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{-20,-54},{0,-74}},
        lineColor={0,0,255},
        fillColor={0,0,255},
        fillPattern=FillPattern.Solid)}),
                                     Documentation(info="<html>
<p>This package hosts models for quasi stationary multi phase circuits.
Quasi stationary theory can be found in
[<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Vaske1973</a>]
and other
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase\">SinglePhase</a>

</html>"));
end MultiPhase;
