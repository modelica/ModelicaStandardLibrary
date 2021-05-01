within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.ExampleUtilities;
block SpacePhasorLimiter "Limit space phasor"
  extends Modelica.Blocks.Interfaces.SI2SO;
  parameter Modelica.Units.SI.Current yMax "Maximum output";
equation
  y = sign(u2)*min(abs(u2), sqrt(yMax^2 - min(yMax, abs(u1))^2));
  annotation (Documentation(info="<html>
<p>
Limit the real part <code>u2</code> of a space phasor if necessary to keep the length lower than <code>yMax</code> keeping <code>u1</code> unchanged. 
If <code>u1</code> is greater than <code>yMax</code>, this cannot be satisfied even with <code>u2 = 0</code>.
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-100,80},{-60,40}},
          textColor={28,108,200},
          textString="re"),
        Text(
          extent={{-100,-40},{-60,-80}},
          textColor={28,108,200},
          textString="im"),
        Text(
          extent={{20,20},{100,-20}},
          textColor={28,108,200},
          textString="lim.im")}));
end SpacePhasorLimiter;
