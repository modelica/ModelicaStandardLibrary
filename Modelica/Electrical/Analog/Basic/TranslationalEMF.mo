within Modelica.Electrical.Analog.Basic;
model TranslationalEMF "Electromotoric force (electric/mechanic transformer)"
  parameter Boolean useSupport=false
    "= true, if support flange enabled, otherwise implicitly grounded"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter SI.ElectricalForceConstant k(start=1)
    "Transformation coefficient";

  SI.Voltage v "Voltage drop between the two pins";
  SI.Current i "Current flowing from positive to negative pin";
  SI.Position s "Position of flange relative to support";
  SI.Velocity vel "Velocity of flange relative to support";
  SI.Force f "Force of flange";
  SI.Force fElectrical "Electrical force";

  Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive electrical pin" annotation (Placement(
        transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative electrical pin" annotation (Placement(
        transformation(
        origin={0,-100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange "Flange" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.Translational.Interfaces.Support support if useSupport
    "Support/housing"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
protected
  Modelica.Mechanics.Translational.Components.Fixed fixed if not useSupport
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  Modelica.Mechanics.Translational.Interfaces.InternalSupport internalSupport(f=-f) "Internal support"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;

  s = flange.s - internalSupport.s;
  vel = der(s);
  k*vel = v;
  f = -k*i;
  fElectrical = -f;
  f = flange.f;

  connect(internalSupport.flange, support) annotation (Line(
      points={{-80,0},{-90,0},{-90,0},{-100,0}}, color={0,127,0}));
  connect(internalSupport.flange, fixed.flange) annotation (Line(
      points={{-80,0},{-80,-10}}, color={0,127,0}));
  annotation (defaultComponentName="emf",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-90,51},{-40,-50}},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-21,20},{90,-20}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{40,-40},{200,-80}},
          textString="k=%k"),
        Line(points={{-30,49},{-30,80},{0,80},{0,91}}, color={0,0,255}),
        Line(points={{20,-49},{20,-80},{0,-80},{0,-89},{0,-90}}, color={0,0,255}),
        Ellipse(extent={{-21,50},{9,-50}}, lineColor={0,0,255}),
        Ellipse(extent={{2,50},{32,-50}}, lineColor={0,0,255}),
        Ellipse(extent={{-43,50},{-13,-50}}, lineColor={0,0,255}),
        Rectangle(
          extent={{-4,20},{-1,-20}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{7,20},{10,-20}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-14,20},{-11,-20}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{19,20},{44,-20}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(
          visible=not useSupport,
          points={{-100,-70},{-40,-70}}),
        Line(
          visible=not useSupport,
          points={{-100,-90},{-80,-70}}),
        Line(
          visible=not useSupport,
          points={{-80,-90},{-60,-70}}),
        Line(
          visible=not useSupport,
          points={{-60,-90},{-40,-70}}),
        Line(
          visible=not useSupport,
          points={{-70,-70},{-70,-50}}),
        Text(
          extent={{20,80},{220,40}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
            points={{-17,95},{-20,85},{-23,95},{-17,95}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),Line(points={{-20,110},{-20,85}},
          color={160,160,164}),Text(
            extent={{-40,110},{-30,90}},
            textColor={160,160,164},
            textString="i"),Line(points={{9,75},{19,75}}, color={192,192,192}),
          Line(points={{-20,-110},{-20,-85}}, color={160,160,164}),Polygon(
            points={{-17,-100},{-20,-110},{-23,-100},{-17,-100}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),Text(
            extent={{-40,-110},{-30,-90}},
            textColor={160,160,164},
            textString="i"),Line(points={{8,-79},{18,-79}}, color={192,192,192}),
          Line(points={{14,80},{14,70}}, color={192,192,192}),Polygon(
            points={{140,3},{150,0},{140,-3},{140,3},{140,3}},
            fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>EMF transforms electrical energy into translational mechanical energy. It is used as basic building block of an electrical linear motor. The mechanical connector flange can be connected to elements of the Modelica.Mechanics.Translational library. flange.f is the cut-force, flange.s is the distance at the translational connection.</p>
</html>",
        revisions="<html>
<dl>
<dt>2009</dt>
<dd>by Anton Haumer<br> initially implemented</dd>
</dl>
</html>"));
end TranslationalEMF;
