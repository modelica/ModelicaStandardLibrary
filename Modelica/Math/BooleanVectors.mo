within Modelica.Math;
package BooleanVectors "Library of functions operating on Boolean vectors"
 extends Modelica.Icons.Package;
function allTrue
    "Returns true, if all elements of the Boolean input vector are true ('and')"
  extends Modelica.Icons.Function;
  input Boolean b[:] "Boolean vector";
  output Boolean result "= true, if all elements of b are true";
algorithm
  result := size(b,1) > 0;
  for i in 1:size(b,1) loop
     result := result and b[i];
  end for;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>allTrue</b>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns <b>true</b> if all elements of the Boolean input vector b are <b>true</b>.
Otherwise the function returns <b>false</b>. If b is an empty vector, 
i.e., size(b,1)=0, the function returns <b>false</b>. 
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {true, true, true};
  Boolean b2[3] = {false, true, false};
  Boolean r1, r2;
<b>algorithm</b>
  r1 = allTrue(b1);  // r1 = true
  r2 = allTrue(b2);  // r2 = false
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>.
</p>

</html>"));
end allTrue;

function anyTrue
    "Returns true, if at least on element of the Boolean input vector is true ('or')"

  extends Modelica.Icons.Function;
  input Boolean b[:];
  output Boolean result;
algorithm
  result := false;
  for i in 1:size(b,1) loop
     result := result or b[i];
  end for;
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>anyTrue</b>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns <b>true</b> if at least one elements of the input Boolean vector b is <b>true</b>.
Otherwise the function returns <b>false</b>. If b is an empty vector, 
i.e., size(b,1)=0, the function returns <b>false</b>. 
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean r1, r2;
<b>algorithm</b>
  r1 = anyTrue(b1);  // r1 = false
  r2 = anyTrue(b2);  // r2 = true
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>.
</p>
</html>"));
end anyTrue;

function oneTrue
    "Returns true, if exactly one element of the Boolean input vector is true ('xor')"

  extends Modelica.Icons.Function;
  input Boolean b[:];
  output Boolean result;
  protected
  Integer count = 0;
algorithm
  for i in 1:size(b,1) loop
     count := if b[i] then count+1 else count;
  end for;
  result :=count == 1;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>oneTrue</b>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns <b>true</b> if exactly one element of the input Boolean vector b is <b>true</b>.
Otherwise the function returns <b>false</b>. If b is an empty vector, 
i.e., size(b,1)=0, the function returns <b>false</b>. 
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean b3[3] = {false, true, true};
  Boolean r1, r2, r3;
<b>algorithm</b>
  r1 = oneTrue(b1);  // r1 = false
  r2 = oneTrue(b2);  // r2 = true
  r3 = oneTrue(b3);  // r3 = false
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>.
</p>
</html>"));
end oneTrue;

function firstTrueIndex
    "Returns the index of the first element of the Boolean vector that is true and returns 0, if no element is true"
   input Boolean b[:];
   output Integer index;
algorithm
   index :=0;
   for i in 1:size(b,1) loop
      if b[i] then
         index :=i;
         return;
      end if;
   end for;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>firstTrueIndex</b>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns the index of the first element of the Boolean vector b 
that is <b>true</b> and returns 0, if no element is <b>true</b>\"
If b is an empty vector, i.e., size(b,1)=0, the function returns 0. 
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean b3[4] = {false, true, false, true};
  Integer r1, r2, r3;
<b>algorithm</b>
  r1 = firstTrueIndex(b1);  // r1 = 0
  r2 = firstTrueIndex(b2);  // r2 = 2
  r3 = firstTrueIndex(b3);  // r3 = 2
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end firstTrueIndex;
  annotation (Documentation(info="<html>
<p>
This library provides functions operating on vectors that have
a Boolean vector as input argument.
</p>
</html>"));
end BooleanVectors;
