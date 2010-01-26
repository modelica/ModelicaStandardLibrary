within Modelica;
package ComplexConstants "Library of complex mathematical constants"
  extends Icons.Library2;
  final constant Complex j = Complex(0,1);
  final constant Complex zero = Complex(0,0);
  final constant Complex one = Complex(1,0);
  final constant Complex a = Modelica.ComplexMath.exp(j*2*Modelica.Constants.pi/3);
  final constant Complex a2 = a*a;

  annotation (Icon(graphics={Text(
          extent={{-94,-14},{72,-56}},
          lineColor={0,0,0},
          textString="j")}));
end ComplexConstants;
