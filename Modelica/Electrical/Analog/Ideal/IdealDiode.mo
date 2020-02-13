within Modelica.Electrical.Analog.Ideal;
model IdealDiode "Ideal diode"
  extends Modelica.Electrical.Analog.Interfaces.IdealSemiconductor;
equation
  off = s < 0;
  annotation (defaultComponentName="diode",
    Documentation(info="<html>
<p>
This is an ideal diode, for details see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\">IdealSemiconductor</a><br>
The diode is conducting if voltage &gt; Vknee.<br>
The diode is locking if current &lt; Vknee*Goff.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSemiconductor<br>
       </li>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>Mai 7, 2004   </em>
       by Christoph Clauss and Anton Haumer<br> Vknee added<br>
       </li>
<li><em>some years ago   </em>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</html>"));
end IdealDiode;
