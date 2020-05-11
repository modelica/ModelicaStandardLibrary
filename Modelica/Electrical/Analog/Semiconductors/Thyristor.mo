within Modelica.Electrical.Analog.Semiconductors;
model Thyristor "Simple Thyristor Model"
  parameter SI.Voltage VDRM(final min=0) = 100
    "Forward breakthrough voltage";
  parameter SI.Voltage VRRM(final min=0) = 100
    "Reverse breakthrough voltage";
  parameter SI.Current IDRM=0.1 "Saturation current";
  parameter SI.Voltage VTM= 1.7 "Conducting voltage";
  parameter SI.Current IH=6e-3 "Holding current";
  parameter SI.Current ITM= 25 "Conducting current";

  parameter SI.Voltage VGT= 0.7 "Gate trigger voltage";
  parameter SI.Current IGT= 5e-3 "Gate trigger current";

  parameter SI.Time TON = 1e-6 "Switch on time";
  parameter SI.Time TOFF = 15e-6 "Switch off time";
  parameter SI.Voltage Vt=0.04
    "Voltage equivalent of temperature (kT/qn)";
  parameter Real Nbv=0.74 "Reverse Breakthrough emission coefficient";
 extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
  SI.Current iGK "Gate current";
  SI.Voltage vGK "Voltage between gate and cathode";
  SI.Voltage vAK "Voltage between anode and cathode";
  SI.Voltage vControl(start=0);
  SI.Voltage vContot;
  SI.Voltage vConmain;

public
  Modelica.Electrical.Analog.Interfaces.PositivePin Anode annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin Cathode annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin Gate annotation (Placement(
        transformation(extent={{90,90},{110,110}}),iconTransformation(extent={{90,90},{110,110}})));

protected
  parameter SI.Voltage Von=5;
  parameter SI.Voltage Voff= 1.5;
  parameter SI.Resistance Ron=(VTM-0.7)/ITM
    "Forward conducting mode resistance";
  parameter SI.Resistance Roff=(VDRM^2)/VTM/IH
    "Blocking mode resistance";

equation
  //Kirchhoff's equations
  Anode.i+Gate.i+Cathode.i=0;
  vGK=Gate.v-Cathode.v;
  vAK=Anode.v-Cathode.v;

  // Gate and Control voltage
  iGK = Gate.i;
  vGK = smooth(0,(if vGK < 0.65 then VGT/IGT*iGK else
        0.65^2/VGT+iGK*(VGT-0.65)/IGT));
  vContot = vConmain + smooth(0, if iGK < 0.95 * IGT then 0 else if iGK < 0.95*IGT + 1e-3 then 10000*(iGK-0.95*IGT)*vAK else 10* vAK);
  der(vControl)= (vContot - vControl) / (if (vContot - vControl) > 0 then 1.87*TON else 0.638*TOFF);

  // Anode-Cathode characteristics
  Anode.i= smooth(1, if vAK < -VRRM then -VRRM/Roff*exp(-(vAK+VRRM)/(Nbv*Vt)) else
         if vControl<Voff then vAK/Roff else
         if vControl<Von then vAK/(sqrt(Ron*Roff)*(Ron/Roff)^((3*((2*vControl-Von-Voff)/(2*(Von-Voff)))-4*((2*vControl-Von-Voff)/(2*(Von-Voff)))^3)/2)) else
          vAK/Ron);

  // holding effect and forward breakthrough
  vConmain = (if Anode.i>IH or vAK>VDRM then Von else 0);
  LossPower = Anode.i*Anode.v + Cathode.i*Cathode.v + Gate.i*Gate.v;
 annotation (
   Documentation(info="<html>
<p>This is a simple thyristor model with three pins: Anode, Cathode and Gate. There are three operating modes:conducting, blocking and reverse breakthrough.
<br>As long as the thyristor is in blocking mode it behaves like a linear resistance Roff=VDRM^2/(VTM*IH). But if the voltage between anode and cathode exceeds VDRM or a positive gate current flows for a sufficient time the mode changes to conducting mode. The model stays in conducting mode until the anode current falls below the holding current IH. There is no way to switch off the thyristor via the gate. If the voltage between anode and cathode is negative, the model represents a diode (parameters Vt, Nbv) with reverse breakthrough voltage VRRM.</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Semiconductors/Thyristor.png\"
     alt=\"Thyristor.png\">
</div>
<p>The dV/dt switch on is not taken into account in this model. The gate circuit is not influenced by the main circuit.</p>
</html>",
  revisions=
    "<html>
<ul>
<li><em>May 12, 2009   </em>
       by Matthias Franke
       </li>
</ul>
</html>"),
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255}),
        Line(points={{30,20},{100,90},{100,100}},
                                               color={0,0,255}),
        Text(
          extent={{-150,-40},{150,-80}},
          textString="%name",
          textColor={0,0,255})}));
end Thyristor;
