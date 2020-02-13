within Modelica.Electrical.Analog.Semiconductors;
model NPN "Simple NPN BJT according to Ebers-Moll with heating port"
        parameter Real Bf=50 "Forward beta";
        parameter Real Br=0.1 "Reverse beta";
        parameter SI.Current Is=1e-16 "Transport saturation current";
        parameter SI.InversePotential Vak=0.02 "Early voltage (inverse), 1/Volt";
        parameter SI.Time Tauf=0.12e-9 "Ideal forward transit time";
        parameter SI.Time Taur=5e-9 "Ideal reverse transit time";
        parameter SI.Capacitance Ccs=1e-12 "Collector-substrate(ground) cap.";
        parameter SI.Capacitance Cje=0.4e-12 "Base-emitter zero bias depletion cap.";
        parameter SI.Capacitance Cjc=0.5e-12 "Base-coll. zero bias depletion cap.";
        parameter SI.Voltage Phie=0.8 "Base-emitter diffusion voltage";
        parameter Real Me=0.4 "Base-emitter gradation exponent";
        parameter SI.Voltage Phic=0.8 "Base-collector diffusion voltage";
        parameter Real Mc=0.333 "Base-collector gradation exponent";
        parameter SI.Conductance Gbc=1e-15 "Base-collector conductance";
        parameter SI.Conductance Gbe=1e-15 "Base-emitter conductance";
        parameter Real EMin=-100 "If x < EMin, the exp(x) function is linearized";
        parameter Real EMax=40 "If x > EMax, the exp(x) function is linearized";
  parameter Boolean useTemperatureDependency = false "= true, if parameters Bf, Br, Is and Vt depend on temperature" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Voltage Vt=0.02585 "Voltage equivalent of temperature" annotation(Dialog(enable=not useTemperatureDependency));
  parameter SI.Temperature Tnom=300.15 "Parameter measurement temperature" annotation(Dialog(enable=useTemperatureDependency));
  parameter Real XTI=3 "Temperature exponent for effect on Is" annotation(Dialog(enable=useTemperatureDependency));
  parameter Real XTB=0 "Forward and reverse beta temperature exponent" annotation(Dialog(enable=useTemperatureDependency));
  parameter SI.Voltage EG=1.11 "Energy gap for temperature effect on Is" annotation(Dialog(enable=useTemperatureDependency));
        parameter Real NF=1.0 "Forward current emission coefficient";
        parameter Real NR=1.0 "Reverse current emission coefficient";
  parameter SI.Voltage IC=0 "Initial value of collector to substrate voltage" annotation(Dialog(enable=UIC));
  parameter Boolean UIC = false "Decision if initial value IC should be used";
  parameter Boolean useSubstrate = false "= false, if substrate is implicitly grounded";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(useHeatPort=useTemperatureDependency);

        SI.Voltage vbc "Base-collector voltage";
        SI.Voltage vbe "Base-emitter voltage";
  SI.Voltage vcs "Collector-substrate voltage";
        Real qbk "Relative majority carrier charge, inverse";
        SI.Current ibc "Base-collector diode current";
        SI.Current ibe "Base-emitter diode current";
        SI.Capacitance cbc "Total base-collector capacitance";
        SI.Capacitance cbe "Total base-emitter capacitance";
        SI.Capacitance Capcje "Effective base-emitter depletion capacitance";
        SI.Capacitance Capcjc "Effective base-collector depletion capacitance";
        SI.Current is_t "Temperature dependent transport saturation current";
        Real br_t "Temperature dependent forward beta";
        Real bf_t "Temperature dependent reverse beta";
        SI.Voltage vt_t "Voltage equivalent of effective temperature";
        Real hexp "Auxiliary quantity temperature dependent exponent";
        Real htempexp "Auxiliary quantity exp(hexp)";
  SI.Voltage vS "Substrate potential";
  SI.Current iS "Substrate current";

        Modelica.Electrical.Analog.Interfaces.Pin C "Collector"
          annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
        Modelica.Electrical.Analog.Interfaces.Pin B "Base"
          annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
        Modelica.Electrical.Analog.Interfaces.Pin E "Emitter"
          annotation (Placement(transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin S(final i = iS, final v = vS) if useSubstrate "Substrate"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
initial equation
  if UIC then
    vcs = IC;
  end if;
equation
        assert(T_heatPort > 0,"Temperature must be positive");
        vbc = B.v - C.v;
        vbe = B.v - E.v;
  vcs = C.v - vS;
        qbk = 1 - vbc*Vak;

        hexp = (T_heatPort/Tnom - 1)*EG/vt_t;
        htempexp = smooth(1, exlin2(hexp, EMin, EMax));

  is_t = if useTemperatureDependency then Is*pow(T_heatPort/Tnom, XTI)*htempexp else Is;
  br_t = if useTemperatureDependency then Br*pow(T_heatPort/Tnom, XTB) else Br;
  bf_t = if useTemperatureDependency then Bf*pow(T_heatPort/Tnom, XTB) else Bf;
  vt_t = if useTemperatureDependency then (k/q)*T_heatPort else Vt;

        ibc = smooth(1, is_t*(exlin2(vbc/(NR*vt_t), EMin, EMax) - 1) + vbc*Gbc);
        ibe = smooth(1, is_t*(exlin2(vbe/(NF*vt_t), EMin, EMax) - 1) + vbe*Gbe);
        Capcjc = smooth(1, Cjc*powlin(vbc/Phic, Mc));
        Capcje = smooth(1, Cje*powlin(vbe/Phie, Me));
        cbc = smooth(1, Taur*is_t/(NR*vt_t)*exlin2(vbc/(NR*vt_t), EMin, EMax) + Capcjc);
        cbe = smooth(1, Tauf*is_t/(NF*vt_t)*exlin2(vbe/(NF*vt_t), EMin, EMax) + Capcje);
  C.i = (ibe - ibc)*qbk - ibc/br_t - cbc*der(vbc) - iS;
        B.i = ibe/bf_t + ibc/br_t + cbc*der(vbc) + cbe*der(vbe);
  E.i = -B.i - C.i - iS;
  iS = -Ccs * der(vcs);
  if not useSubstrate then
    vS = 0;
  end if;
  LossPower = vbc*ibc/br_t + vbe*ibe/bf_t + (ibe - ibc)*qbk*(C.v - E.v);
        annotation (defaultComponentName="npn",
          Documentation(info="<html>
<p>This model is a simple model of a bipolar NPN junction transistor according to Ebers-Moll.
<br>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.
<br>A typical parameter set is (the parameter Vt is no longer used):</p>
<blockquote><pre>
Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe
-   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS
50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15
</pre></blockquote>
<p><strong>References:</strong> [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Vlach1983</a>]</p>
</html>",revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>March 20, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-20,40},{-20,-40}}, color={0,0,255}),
        Line(points={{-20,0},{-100,0}}, color={0,0,255}),
        Line(points={{91,60},{30,60}}, color={0,0,255}),
        Line(points={{30,60},{-20,10}}, color={0,0,255}),
        Line(points={{-20,-10},{30,-60}}, color={0,0,255}),
        Line(points={{30,-60},{91,-60}}, color={0,0,255}),
        Polygon(
          points={{30,-60},{24,-46},{16,-54},{30,-60}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(     extent={{-150,130},{150,90}},
          textString="%name",
    textColor={0,0,255}),
        Line(
          points={{0,0},{90,0}},
          color={0,0,255},
          pattern=LinePattern.Dash,
          visible = useSubstrate)}));
end NPN;
