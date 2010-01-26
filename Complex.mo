within  ;
record Complex "Complex number with overloaded operators"
  extends Modelica.Icons.Record;
  Real re "Real part of complex number" annotation(Dialog);
  Real im "Imaginary part of complex number" annotation(Dialog);

encapsulated operator 'constructor'
  function fromReal
      import Complex;
    input Real re "Real part of complex number";
    input Real im=0 "Imaginary part of complex number";
    output Complex result(re=re, im=im) "Complex number";
  algorithm

    annotation(Inline=true);
  end fromReal;
end 'constructor';

  encapsulated operator '-' "Unary and binary minus"
    function negate "Unary minus (multiply complex number by -1)"
      import Complex;                      // changed to Modelica_LinearSystems2
      input Complex c1 "Complex number";
      output Complex c2 "= -c1";
    algorithm
      c2 := Complex(-c1.re, -c1.im);
      annotation(Inline=true);
    end negate;

    function subtract "Subtract two complex numbers"
      import Complex;                     // changed to Modelica_LinearSystems2
      input Complex c1 "Complex number 1";
      input Complex c2 "Complex number 2";
      output Complex c3 "= c1 - c2";
    algorithm
      c3 := Complex(c1.re - c2.re, c1.im - c2.im);
      annotation(Inline=true);
    end subtract;
  end '-';

  encapsulated operator function '+' "Add two complex numbers"
    import Complex;

      input Complex c1 "Complex number 1";
      input Complex c2 "Complex number 2";
      output Complex c3 "= c1 + c2";
  algorithm
    c3 := Complex(c1.re + c2.re, c1.im + c2.im);
    annotation(Inline=true);
  end '+';

  encapsulated operator function '*' "Multiply two complex numbers"
    import Complex;

      input Complex c1 "Complex number 1";
      input Complex c2 "Complex number 2";
      output Complex c3 "= c1*c2";
  algorithm
      c3 := Complex(c1.re*c2.re - c1.im*c2.im, c1.re*c2.im + c1.im*c2.re);
    annotation(Inline=true);
  end '*';

  encapsulated operator function '/' "Divide two complex numbers"
    import Complex;

      input Complex c1 "Complex number 1";
      input Complex c2 "Complex number 2";
      output Complex c3 "= c1/c2";
  algorithm
      c3 := Complex((c1.re*c2.re + c1.im*c2.im)/(c2.re^2 + c2.im^2), (-c1.re*c2.im + c1.im*c2.re)/(c2.re^2 + c2.im^2));
    annotation(Inline=true);
  end '/';

encapsulated operator function '^' "Complex power of complex number"
  import Complex;
  input Complex c1 "Complex number";
  input Complex c2 "Complex exponent";
  output Complex c3 "= c1^c2";
  protected
  Real lnz=0.5*ln(c1.re*c1.re + c1.im*c1.im);
  Real phi=arctan2(c1.im, c1.re);
  Real re=lnz*c2.re - phi*c2.im;
  Real im=lnz*c2.im + phi*c2.re;
algorithm
  c3 := Complex(exp(re)*cos(im), exp(re)*sin(im));
end '^';

  encapsulated operator function '=='
    "Test whether two complex numbers are identical"
    import Complex;
      input Complex c1 "Complex number 1";
      input Complex c2 "Complex number 2";
      output Boolean result "c1 == c2";
  algorithm
      result := c1.re == c2.re and c1.im == c2.im;
    annotation(Inline=true);
  end '==';

  encapsulated operator function 'String'
    "Transform Complex number into a String representation"
    import Complex;
      input Complex c
      "Complex number to be transformed in a String representation";
      input String name="j"
      "Name of variable representing sqrt(-1) in the string";
      input Integer significantDigits=6
      "Number of significant digits that are shown";
      output String s="";
  algorithm
      s := String(c.re, significantDigits=significantDigits);
      if c.im <> 0 then
        if c.im > 0 then
          s := s + " + ";
        else
          s := s + " - ";
        end if;
        s := s + String(abs(c.im), significantDigits=significantDigits) + "*" + name;
      end if;
    //    end toString;
  end 'String';

  annotation (version="1.0",
versionBuild=1,
versionDate="2010-01-26",
dateModified = "2010-01-26 19:32:58Z",
revisionId="$Id::                                       $");
end Complex;
