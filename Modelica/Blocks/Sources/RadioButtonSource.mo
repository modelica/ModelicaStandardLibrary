within Modelica.Blocks.Sources;
block RadioButtonSource "Boolean signal source that mimics a radio button"

  parameter SI.Time buttonTimeTable[:]={0,1}
    "Time instants where button is pressed";
  input Boolean reset[:]={false}
    "Reset button to false, if an element of reset becomes true"
    annotation (Dialog(group="Time varying expressions"));

  Modelica.Blocks.Interfaces.BooleanOutput on(start=false,fixed=true)
    annotation (Placement(transformation(extent={{100,-15},{130,15}})));
protected
  Modelica.Blocks.Sources.BooleanTable table(table=buttonTimeTable, y(start=false, fixed=true));
  parameter Integer nReset=size(reset, 1);
  Boolean pre_reset[nReset];
initial equation
  pre(pre_reset) = fill(false, nReset);
  pre(reset) = fill(false, nReset);
algorithm
  pre_reset := pre(reset);
  when pre_reset then
    on := false;
  end when;

  when change(table.y) then
    on := true;
  end when;

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.06), graphics={Rectangle(
          extent={{-100,-100},{100,100}},
          borderPattern=BorderPattern.Raised,
          fillColor=DynamicSelect({192,192,192}, if on then {0,255,0} else {192,192,192}),
          fillPattern=FillPattern.Solid,
          lineColor={128,128,128}), Text(
          extent={{-300,110},{300,175}},
          textColor={0,0,255},
          textString="%name")},
        interaction={OnMouseDownSetBoolean(on, true)}), Documentation(info="<html>
<p>
Boolean signal source that mimics a radio button:
Via a table, a radio button is pressed (i.e., the output 'on' is set to true) and is reset when an element of the Boolean vector
'reset' becomes true. If both appear at the same time instant, setting
the button according to the table has a higher priority as resetting
the button. Example:
</p>

<blockquote><pre>
RadioButtonSource start(buttonTimeTable={1,3}, reset={stop.on});
RadioButtonSource stop (buttonTimeTable={2,4}, reset={start.on});
</pre></blockquote>

<p>
The \"start\" button is pressed at time=1 s and time=3 s,
whereas the \"stop\" button is pressed at time=2 s and time=4 s.
This gives the following result:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/RadioButtonSource.png\"
     alt=\"RadioButtonSource.png\">
</blockquote>

<p>
This example is also available in
<a href=\"modelica://Modelica.Blocks.Examples.Interaction1\">Modelica.Blocks.Examples.Interaction1</a>
</p>

</html>"));
end RadioButtonSource;
