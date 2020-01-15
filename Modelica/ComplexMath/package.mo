within Modelica;
package ComplexMath "Library of complex mathematical functions (e.g., sin, cos) and of functions operating on complex vectors and matrices"
  extends Modelica.Icons.Package;
  final constant Complex j = Complex(0,1) "Imaginary unit";

  function 'abs' "Absolute value of complex number"
    extends Modelica.Icons.Function;
    input Complex c "Complex number";
    output Real result "= abs(c)";
  algorithm
    result := (c.re^2 + c.im^2)^0.5; //changed from sqrt
    annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Real absolute of the Complex input, i.e., its length.</p>
</html>"));
  end 'abs';

  function 'sqrt' "Square root of complex number"
    extends Modelica.Icons.Function;
    input Complex c1 "Complex number";
    output Complex c2 "= sqrt(c1)";
  algorithm
    c2 := Complex(sqrt('abs'(c1))*Math.cos(arg(c1)/2), sqrt('abs'(c1))*Math.sin(arg(c1)/2));
    annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex square root (principal square root) of the Complex input.</p>
</html>"));
  end 'sqrt';

  function 'max' "Return maximum element of complex vector"
    extends Modelica.Icons.Function;
    input Complex v[:] "Vector";
    output Complex result "Element of v with largest absolute value";
    output Integer index "v[index] has the largest absolute value";
protected
    Real absv_i;
    Real absres;
  algorithm
    if size(v,1) > 0 then
      absres := 'abs'(v[1]);
      index  := 1;
      for i in 2:size(v,1) loop
        absv_i := 'abs'(v[i]);
        if absv_i > absres then
          absres := absv_i;
          index := i;
        end if;
      end for;
      result :=v[index];
    else
      result := Complex(0);
      index  := 0;
    end if;
    annotation(Documentation(info="<html>
<p>This function returns the largest element of the Complex input vector, defined by the Complex absolute.</p>
</html>"));
  end 'max';

  function 'min' "Return minimum element of complex vector"
    extends Modelica.Icons.Function;
    input Complex v[:] "Vector";
    output Complex result "Element of v with smallest absolute value";
    output Integer index "v[index] has the smallest absolute value";
protected
    Real absv_i;
    Real absres;
  algorithm
    if size(v,1) > 0 then
      absres := 'abs'(v[1]);
      index  := 1;
      for i in 2:size(v,1) loop
        absv_i := 'abs'(v[i]);
        if absv_i < absres then
          absres := absv_i;
          index := i;
        end if;
      end for;
      result :=v[index];
    else
      result := Complex(0);
      index  := 0;
    end if;
    annotation(Documentation(info="<html>
<p>This function returns the smallest element of the Complex input vector, defined by the Complex absolute.</p>
</html>"));
  end 'min';

  function 'sum' "Return sum of complex vector"
    extends Modelica.Icons.Function;
    input Complex v[:] "Vector";
    output Complex result "Complex sum of vector elements";
  algorithm
    result:=Complex(sum(v[:].re), sum(v[:].im));
    annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex sum of the Complex input vector</p>
</html>"));
  end 'sum';

  function 'product' "Return product of complex vector"
    extends Modelica.Icons.Function;
    input Complex v[:] "Vector";
    output Complex result "Complex product of vector elements";
  algorithm
    result:=Complex(1);
    for i in 1:size(v,1) loop
      result:=result * v[i];
    end for;
    annotation(Documentation(info="<html>
<p>This function returns the Complex product of the Complex input vector</p>
</html>"));
  end 'product';

  annotation (Documentation(info="<html>
<p>
This package contains <strong>basic mathematical functions</strong>
operating on complex numbers (such as sin(..)),
as well as functions operating on vectors of complex numbers.
</p>

</html>"), Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics={
        Line(points={{32,-86},{32,88}}, color={175,175,175}),
        Line(points={{-84,2},{88,2}}, color={175,175,175}),
        Line(
          points={{-50,75},{-5,30}}),
        Line(
          points={{-50,30},{-5,75}}),
        Line(
          points={{-50,-30},{-5,-75}}),
        Line(
          points={{-50,-75},{-5,-30}})}));

end ComplexMath;
