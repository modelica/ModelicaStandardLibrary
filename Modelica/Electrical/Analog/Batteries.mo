within Modelica.Electrical.Analog;
package Batteries "Simple battery models"
  extends Modelica.Icons.Package;
  model BatteryOCV_SOCtable
    "Battery with inner resistance and open-circuit voltage dependent on state of charge"
    extends Partials.BaseBatteryOCV_SOCtable;
    parameter Modelica.SIunits.Current Isc "Short-cicuit current at SOC = SOCmax";
    parameter Modelica.SIunits.Resistance Ri=OCVmax/Isc "Inner resistance";
    extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
    Modelica.Electrical.Analog.Basic.Resistor resistor(final R=Ri,
      T_ref=293.15, final useHeatPort=true)
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    connect(resistor.n, n)
      annotation (Line(points={{0,0},{100,0}},  color={0,0,255}));
    connect(ocv.n, resistor.p)
      annotation (Line(points={{-30,0},{-20,0}},
                                               color={0,0,255}));
    connect(resistor.heatPort, internalHeatPort) annotation (Line(points={{-10,-10},
            {-10,-80},{0,-80}},        color={191,0,0}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}})),
      Documentation(info="<html>
<p>
The battery is modeled by open-circuit voltage (OCV) dependent on state of charge (SOC) and an inner resistance, 
whoses losses are dissipated to the optional <code>heatPort</code>. 
</p>
</html>"));
  end BatteryOCV_SOCtable;

  package Partials "Partials for battery models"
    extends Modelica.Icons.BasesPackage;

    partial model BaseBatteryOCV_SOCtable
      "Battery with open-circuit voltage dependent on state of charge"
      import Modelica.Constants.eps;
      parameter Modelica.SIunits.ElectricCharge Qnom(displayUnit="Ah")
        "Nominal (maximum) charge";
      parameter Boolean useLinearSOCDependency=true
        "Use a linear SOC dependent OCV, otherwise table based";
      parameter Modelica.SIunits.Voltage OCVmax(final min=0) "OCV at SOC = SOCmax";
      parameter Modelica.SIunits.Voltage OCVmin(final min=0, start=0) "OCV at SOC = SOCmin"
        annotation(Dialog(enable=useLinearSOCDependency));
      parameter Real SOCmax(final max=1)=1 "Max. state of charge";
      parameter Real SOCmin(final min=0)=0 "Min. state of charge";
      parameter Real OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1] "OCV/OCVmax versus SOC"
        annotation(Dialog(enable=not useLinearSOCDependency));
      Modelica.SIunits.Current i = p.i "Current into the battery";
      Modelica.SIunits.Power power = v*i "Power to the battery";
      extends Modelica.Electrical.Analog.Interfaces.TwoPin;
      output Real SOC(start=SOCmax)=integrator.y "State of charge"
        annotation(Dialog(showStartAttribute=true));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-90,10},{-70,-10}})));
      Modelica.Blocks.Continuous.Integrator integrator(final k=1/Qnom,
        final initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,30})));
      Modelica.Blocks.Tables.CombiTable1Ds ocv_soc(
        table=if useLinearSOCDependency then LinearOCV_SOC else OCV_SOC,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
        annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
      Modelica.Blocks.Math.Gain gainV(final k=OCVmax) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,30})));
      Modelica.Electrical.Analog.Sources.SignalVoltage ocv
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    protected
      final parameter Real LinearOCV_SOC[2,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1] "Linear SOC dependent OV";
    equation
      assert(OCVmax>OCVmin, "Specify 0 <= OCVmin < OCVmax");
      assert(SOCmax>SOCmin, "Specify 0 <= SOCmin < SOCmax <= 1");
      assert(OCV_SOC[1,  1]>=0, "Specify OCV(SOC) table with SOCmin >= 0");
      assert(OCV_SOC[end,1]<=1, "Specify OCV(SOC) table with SOCmax <= 1");
      assert(OCV_SOC[1,  2]>=0, "Specify OCV(SOC)/OCVmax table with  OCVmin/OCVmax >= 0");
      assert(OCV_SOC[end,2]>=1, "Specify OCV(SOC)/OCVmax table with max.OCV/OCVmax <= 1");
      assert(SOC<SOCmax + eps, "Battery overcharged!");
      assert(SOC>SOCmin - eps, "Battery exhausted!");
      connect(gainV.y, ocv.v)
        annotation (Line(points={{-40,19},{-40,12}}, color={0,0,127}));
      connect(ocv_soc.y[1], gainV.u)
        annotation (Line(points={{-49,50},{-40,50},{-40,42}},
                                                          color={0,0,127}));
      connect(integrator.y, ocv_soc.u)
        annotation (Line(points={{-80,41},{-80,50},{-72,50}}, color={0,0,127}));
      connect(currentSensor.n, ocv.p)
        annotation (Line(points={{-70,0},{-50,0}}, color={0,0,255}));
      connect(integrator.u, currentSensor.i)
        annotation (Line(points={{-80,18},{-80,11}}, color={0,0,127}));
      connect(p, currentSensor.p)
        annotation (Line(points={{-100,0},{-90,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Text(
              extent={{-150,-90},{150,-50}},
              lineColor={0,0,0},
              textString="OCV=%OCVnom"),
            Ellipse(extent={{-90,20},{-82,-20}}, lineColor={0,0,255},
              fillColor={170,170,255},
              fillPattern=FillPattern.Sphere),
            Rectangle(extent={{-86,20},{-60,-20}},lineColor={0,0,255},
              fillColor={170,170,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Ellipse(extent={{-64,20},{-56,-20}}, lineColor={0,0,255},
              fillColor={170,170,255},
              fillPattern=FillPattern.Sphere),
            Ellipse(extent={{-70,50},{-50,-50}}, lineColor={0,0,255},
              fillColor={170,170,255},
              fillPattern=FillPattern.Sphere),
            Rectangle(extent={{-60,50},{80,-50}}, lineColor={0,0,255},
              fillColor={170,170,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Ellipse(extent={{70,50},{90,-50}}, lineColor={0,0,255},
              fillColor={170,170,255},
              fillPattern=FillPattern.Sphere),
            Text(
              extent={{-150,70},{150,110}},
              lineColor={0,0,255},
              textString="%name")}),
        Documentation(info="<html>
<p>
The battery is modeled by open-circuit voltage (OCV) dependent on state of charge (SOC).
</p>
<p>Dependency of OCV on SOC can be chosen either linear (<code>useLinearSOCDependency=true</code>) or table based;</p>
<ul>
<li>1st column = SOC in the range [SOCmin, SOCmax]</li>
<li>2nd column = OCV / OCVmax (at SOC = SOCmax) in the range [OCVmin/OCVmax, 1]</li>
</ul>
<p>By default, a linear OCV vs. SOC characteristic is defined (like a capacitor), i.e. <code>OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1]</code></p>
<p>
Note: SOC &gt; SOCmax and SOC &lt; SOCmin triggers an error.
</p>
</html>"));
    end BaseBatteryOCV_SOCtable;
    annotation (Documentation(info="<html>
<p>Partial models for batteries</p>
</html>"));
  end Partials;
  annotation (Icon(graphics={
        Ellipse(extent={{-10,50},{10,-50}},  lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,-80},
          rotation=90),
        Rectangle(extent={{-70,50},{70,-50}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-7.10543e-15,-10},
          rotation=90),
        Ellipse(extent={{-10,50},{10,-50}},lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,60},
          rotation=90),
        Ellipse(extent={{-4,20},{4,-20}},    lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,60},
          rotation=90),
        Rectangle(extent={{-13,20},{13,-20}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={0,73},
          rotation=90),
        Ellipse(extent={{-4,20},{4,-20}},    lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,86},
          rotation=90)}), Documentation(info="<html>
<p>Simple battery models</p>
</html>"));
end Batteries;
