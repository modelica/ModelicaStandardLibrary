within Modelica.Blocks.Continuous;
block Integrator "Output the integral of the input signal with optional reset"
  import Modelica.Blocks.Types.Init;
  parameter Real k(unit="1")=1 "Integrator gain";
  parameter Boolean use_reset = false "= true, if reset port enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_set = false "= true, if set port enabled and used as reinitialization value when reset"
    annotation(Dialog(enable=use_reset), Evaluate=true, HideResult=true, choices(checkBox=true));

  /* InitialState is the default, because it was the default in Modelica 2.2
     and therefore this setting is backward compatible
  */
  parameter Init initType=Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3,4: initial output)" annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(group="Initialization"));
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
      reinit(y, local_set);
    end when;
  else
    local_reset = false;
    local_set = 0;
  end if;
  der(y) = k*u;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output <strong>y</strong> as
<em>integral</em> of the input <strong>u</strong> multiplied with
the gain <em>k</em>:
</p>
<blockquote><pre>
    k
y = - u
    s
</pre></blockquote>

<p>
It might be difficult to initialize the integrator in steady state.
This is discussed in the description of package
<a href=\"modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
</p>

<p>
If the <em>reset</em> port is enabled, then the output <strong>y</strong> is reset to <em>set</em>
or to <em>y_start</em> (if the <em>set</em> port is not enabled), whenever the <em>reset</em>
port has a rising edge.
</p>
</html>"),
         Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
          Line(
            points={{-80.0,78.0},{-80.0,-90.0}},
            color={192,192,192}),
          Polygon(
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
          Line(
            points={{-90.0,-80.0},{82.0,-80.0}},
            color={192,192,192}),
          Polygon(
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
          Text(
            textColor={192,192,192},
            extent={{0.0,-70.0},{60.0,-10.0}},
            textString="I"),
          Text(
            extent={{-150.0,-150.0},{150.0,-110.0}},
            textString="k=%k"),
          Line(
            points=DynamicSelect({{-80.0,-80.0},{80.0,80.0}}, if use_reset then {{-80.0,-80.0},{60.0,60.0},{60.0,-80.0},{80.0,-60.0}} else {{-80.0,-80.0},{80.0,80.0}}),
            color={0,0,127}),
          Line(
            visible=use_reset,
            points={{60,-100},{60,-80}},
            color={255,0,255},
            pattern=LinePattern.Dot),
          Text(
            visible=use_reset,
            extent={{-28,-62},{94,-86}},
            textString="reset")}));
end Integrator;
