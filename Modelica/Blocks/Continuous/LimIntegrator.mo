within Modelica.Blocks.Continuous;
block LimIntegrator "Integrator with limited value of the output and optional reset"
  import Modelica.Blocks.Types.Init;
  parameter Real k(unit="1")=1 "Integrator gain";
  parameter Real outMax(start=1) "Upper limit of output";
  parameter Real outMin=-outMax "Lower limit of output";
  parameter Boolean use_reset = false "= true, if reset port enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_set = false "= true, if set port enabled and used as reinitialization value when reset"
    annotation(Dialog(enable=use_reset), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Init initType=Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)"
    annotation(Evaluate=true, Dialog(group="Initialization"));
  parameter Boolean limitsAtInit = true
    "= false, if limits are ignored during initialization (i.e., der(y)=k*u)"
    annotation(Evaluate=true, Dialog(group="Initialization"));
  parameter Real y_start=0
    "Initial or guess value of output (must be in the limits outMin .. outMax)"
    annotation (Dialog(group="Initialization"));
  parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
  extends Interfaces.SISO(y(start=y_start));
  Modelica.Blocks.Interfaces.BooleanInput reset if use_reset "Optional connector of reset signal" annotation(Placement(
    transformation(
      extent={{-20,-20},{20,20}},
      rotation=90,
      origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput set if use_reset and use_set "Optional connector of set signal" annotation(Placement(
    transformation(
      extent={{-20,-20},{20,20}},
      rotation=270,
      origin={60,120})));
protected
  Modelica.Blocks.Interfaces.BooleanOutput local_reset annotation(HideResult=true);
  Modelica.Blocks.Interfaces.RealOutput local_set annotation(HideResult=true);

initial equation
  if initType == Init.SteadyState then
     der(y) = 0;
  elseif initType == Init.InitialState or
         initType == Init.InitialOutput then
    y = y_start;
  end if;
equation
  if use_reset then
    connect(reset, local_reset);
    if use_set then
      connect(set, local_set);
    else
      local_set = y_start;
    end if;
    when local_reset then
      reinit(y, if local_set < outMin then outMin elseif local_set > outMax then outMax else local_set);
    end when;
  else
    local_reset = false;
    local_set = 0;
  end if;
  if initial() and not limitsAtInit then
     der(y) = k*u;
     assert(y >= outMin - 0.001*abs(outMax-outMin) and y <= outMax + 0.001*abs(outMax-outMin),
          "LimIntegrator: During initialization the limits have been ignored.\n"
        + "However, the result is that the output y is not within the required limits:\n"
        + "  y = " + String(y) + ", outMin = " + String(outMin) + ", outMax = " + String(outMax));
  elseif strict then
     der(y) = noEvent(if y < outMin and k*u < 0 or y > outMax and k*u > 0 then 0 else k*u);
  else
     der(y) = if y < outMin and k*u < 0 or y > outMax and k*u > 0 then 0 else k*u;
  end if;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes <strong>y</strong> as <em>integral</em>
of the input <strong>u</strong> multiplied with the gain <em>k</em>. If the
integral reaches a given upper or lower <em>limit</em> and the
input will drive the integral outside of this bound, the
integration is halted and only restarted if the input drives
the integral away from the bounds.
</p>

<p>
It might be difficult to initialize the integrator in steady state.
This is discussed in the description of package
<a href=\"modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
</p>

<p>
If parameter <strong>limitsAtInit</strong> = <strong>false</strong>, the limits of the
integrator are removed from the initialization problem which
leads to a much simpler equation system. After initialization has been
performed, it is checked via an assert whether the output is in the
defined limits. For backward compatibility reasons
<strong>limitsAtInit</strong> = <strong>true</strong>. In most cases it is best
to use <strong>limitsAtInit</strong> = <strong>false</strong>.
</p>
<p>
If the <em>reset</em> port is enabled, then the output <strong>y</strong> is reset to <em>set</em>
or to <em>y_start</em> (if the <em>set</em> port is not enabled), whenever the <em>reset</em>
port has a rising edge.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points=DynamicSelect({{-80,-80},{20,20},{80,20}}, if use_reset then {{-80,-80},{20,20},{60,20},{60,-80},{80,-60}} else {{-80,-80},{20,20},{80,20}}),
          color={0,0,127}),
        Text(
          extent={{0,-10},{60,-70}},
          textColor={192,192,192},
          textString="I"),
        Text(
          extent={{-150,-150},{150,-110}},
          textString="k=%k"),
        Line(
          visible=strict,
          points=DynamicSelect({{20,20},{80,20}}, if use_reset then {{20,20},{60,20}} else {{20,20},{80,20}}),
          color={255,0,0}),
        Line(
          visible=use_reset,
          points={{60,-100},{60,-80}},
          color={255,0,255},
          pattern=LinePattern.Dot),
        Text(
          visible=use_reset,
          extent={{-28,-62},{94,-86}},
          textString="reset")}));
end LimIntegrator;
