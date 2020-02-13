within Modelica.Electrical.Analog.Basic;
model RotationalEMF "Electromotoric force (electric/mechanic transformer)"
  parameter Boolean useSupport=false
    "= true, if support flange enabled, otherwise implicitly grounded"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter SI.ElectricalTorqueConstant k(start=1)
    "Transformation coefficient";
  SI.Voltage v "Voltage drop between the two pins";
  SI.Current i "Current flowing from positive to negative pin";
  SI.Angle phi
    "Angle of shaft flange with respect to support (= flange.phi - support.phi)";
  SI.AngularVelocity w "Angular velocity of flange relative to support";
  SI.Torque tau "Torque of flange";
  SI.Torque tauElectrical "Electrical torque";
  Interfaces.PositivePin p "Positive electrical pin" annotation (Placement(transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Interfaces.NegativePin n "Negative electrical pin" annotation (Placement(transformation(
        origin={0,-100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange "Flange" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));
  Mechanics.Rotational.Interfaces.Support support if useSupport
    "Support/housing of emf shaft"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
protected
  Mechanics.Rotational.Components.Fixed fixed if not useSupport
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  Mechanics.Rotational.Interfaces.InternalSupport internalSupport(tau=-tau) "Internal support"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;

  phi = flange.phi - internalSupport.phi;
  w = der(phi);
  k*w = v;
  tau = -k*i;
  tauElectrical = -tau;
  tau = flange.tau;

  connect(internalSupport.flange, support) annotation (Line(
      points={{-80,0},{-100,0}}));
  connect(internalSupport.flange, fixed.flange) annotation (Line(
      points={{-80,0},{-80,-10}}));
  annotation (
    defaultComponentName="emf",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-85,10},{-36,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{35,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-40,40},{40,-40}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-50},{150,-90}},
          textString="k=%k"),
        Line(
          visible=not useSupport,
          points={{-100,-30},{-40,-30}}),
        Line(
          visible=not useSupport,
          points={{-100,-50},{-80,-30}}),
        Line(
          visible=not useSupport,
          points={{-80,-50},{-60,-30}}),
        Line(
          visible=not useSupport,
          points={{-60,-50},{-40,-30}}),
        Line(
          visible=not useSupport,
          points={{-70,-30},{-70,-10}}),
        Line(points={{0,40},{0,50}}, color={0,0,255}),
        Line(points={{0,-50},{0,-40}}, color={0,0,255})}),
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
          Line(points={{14,80},{14,70}}, color={192,192,192})}),
    Documentation(info="<html>
<p>EMF transforms electrical energy into rotational mechanical energy. It is used as basic building block of an electrical motor. The mechanical connector flange can be connected to elements of the Modelica.Mechanics.Rotational library. flange.tau is the cut-torque, flange.phi is the angle at the rotational connection.</p>
</html>",
        revisions="<html>
<ul>
<li><em> 1998   </em>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>"));
end RotationalEMF;
