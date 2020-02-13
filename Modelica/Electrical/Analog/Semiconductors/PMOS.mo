within Modelica.Electrical.Analog.Semiconductors;
model PMOS "Simple PMOS transistor with heating port"

        Modelica.Electrical.Analog.Interfaces.Pin D "Drain"
          annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
        Modelica.Electrical.Analog.Interfaces.Pin G "Gate"
          annotation (Placement(transformation(extent={{-90,-50},{-110,-70}}), iconTransformation(extent={{-90,-50},{-110,-70}})));
        Modelica.Electrical.Analog.Interfaces.Pin S "Source"
          annotation (Placement(transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
        Modelica.Electrical.Analog.Interfaces.Pin B "Bulk"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        parameter SI.Length W=20.0e-6 "Width";
        parameter SI.Length L=6.0e-6 "Length";
        parameter SI.Transconductance Beta=0.0105e-3 "Transconductance parameter";
        parameter SI.Voltage Vt=-1.0 "Zero bias threshold voltage";
        parameter Real K2=0.41 "Bulk threshold parameter";
        parameter Real K5=0.839 "Reduction of pinch-off region";
        parameter SI.Length dW=-2.5e-6 "Narrowing of channel";
        parameter SI.Length dL=-2.1e-6 "Shortening of channel";
        parameter SI.Resistance RDS=1e7 "Drain-Source-Resistance";
  parameter Boolean useTemperatureDependency = false "= true, if parameters Beta, K2 and Vt depend on temperature" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature Tnom=300.15 "Parameter measurement temperature" annotation(Dialog(enable=useTemperatureDependency));
  parameter Real kvt=-2.9e-3 "Fitting parameter for Vt" annotation(Dialog(enable=useTemperatureDependency));
  parameter Real kk2=6.2e-4 "Fitting parameter for K2" annotation(Dialog(enable=useTemperatureDependency));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(useHeatPort=useTemperatureDependency);
protected
        Real v;
        Real uds;
        Real ubs;
        Real ugst;
        Real ud;
        Real us;
        Real id;
        Real gds;
        Real beta_t;
        Real vt_t;
        Real k2_t;
equation
  assert(L + dL > 0, "PMOS: Effective length must be positive");
  assert(W + dW > 0, "PMOS: Effective width must be positive");
  assert(T_heatPort > 0,"PMOS: Temperature must be positive");
        gds = if (RDS < 1e-20 and RDS > -1e-20) then 1e20 else 1/RDS;
        v = beta_t*(W + dW)/(L + dL);
        ud = smooth(0,if (D.v > S.v) then S.v else D.v);
        us = smooth(0,if (D.v > S.v) then D.v else S.v);
        uds = ud - us;
        ubs = smooth(0,if (B.v < us) then 0 else B.v - us);
        ugst = (G.v - us - vt_t + k2_t*ubs)*K5;
        id = smooth(0,if (ugst >= 0) then uds*gds else if (ugst < uds) then -v*uds*(
          ugst - uds/2) + uds*gds else -v*ugst*ugst/2 + uds*gds);

  beta_t = if useTemperatureDependency then Beta*pow((T_heatPort/Tnom), -1.5) else Beta;
  vt_t = if useTemperatureDependency then Vt*(1 + (T_heatPort - Tnom)*kvt) else Vt;
  k2_t = if useTemperatureDependency then K2*(1 + (T_heatPort - Tnom)*kk2) else K2;

        G.i = 0;
        D.i = smooth(0,if (D.v > S.v) then -id else id);
        S.i = smooth(0,if (D.v > S.v) then id else -id);
        B.i = 0;
        LossPower = D.i*(D.v - S.v);
        annotation (defaultComponentName="pMOS",
          Documentation(info="<html>
<p>The PMOS model is a simple model of a p-channel metal-oxide semiconductor FET. It differs slightly from the device used in the SPICE simulator. For more details please care for [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Spiro1990</a>].
<br>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.
<br>The model does not consider capacitances. A high drain-source resistance RDS is included to avoid numerical difficulties.</p>
<p><strong>References:</strong> [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Spiro1990</a>]</p>
<p>Some typical parameter sets are:</p>
<blockquote><pre>
W       L      Beta        Vt    K2     K5      dW       dL
m       m      A/V^2       V     -      -       m        m
50.e-6  8.e-6  0.0085e-3  -0.15  0.41   0.839  -3.8e-6  -4.0e-6
20.e-6  6.e-6  0.0105e-3  -1.0   0.41   0.839  -2.5e-6  -2.1e-6
30.e-6  5.e-6  0.0059e-3  -0.3   0.98   1.01    0       -3.9e-6
30.e-6  5.e-6  0.0152e-3  -0.69  0.104  1.1    -0.8e-6  -0.4e-6
30.e-6  5.e-6  0.0163e-3  -0.69  0.104  1.1    -0.8e-6  -0.4e-6
30.e-6  5.e-6  0.0182e-3  -0.69  0.086  1.06   -0.1e-6  -0.6e-6
20.e-6  6.e-6  0.0074e-3  -1.    0.4    0.59    0        0
</pre></blockquote>
</html>",revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>December 7, 2005   </em>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><em>March 31, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,-60},{-10,-60}}, color={0,0,255}),
        Line(points={{-10,-60},{-10,60}}, color={0,0,255}),
        Line(points={{10,80},{10,39}}, color={0,0,255}),
        Line(points={{10,20},{10,-21}}, color={0,0,255}),
        Line(points={{10,-40},{10,-81}}, color={0,0,255}),
        Line(points={{10,60},{91,60}}, color={0,0,255}),
        Line(points={{10,0},{90,0}}, color={0,0,255}),
        Line(points={{10,-60},{90,-60}}, color={0,0,255}),
        Polygon(
          points={{60,0},{40,5},{40,-5},{60,0}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(     extent={{-150,130},{150,90}},
          textString="%name",
                  textColor={0,0,255})}));
end PMOS;
