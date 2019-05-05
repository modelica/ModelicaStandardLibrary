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
<strong>allTrue</strong>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns <strong>true</strong> if all elements of the Boolean input vector b are <strong>true</strong>.
Otherwise the function returns <strong>false</strong>. If b is an empty vector,
i.e., size(b,1)=0, the function returns <strong>false</strong> (as opposed to <a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a> returning <strong>true</strong>).
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {true, true, true};
  Boolean b2[3] = {false, true, false};
  Boolean r1, r2;
<strong>algorithm</strong>
  r1 = allTrue(b1);  // r1 = true
  r2 = allTrue(b2);  // r2 = false
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>

</html>"));
end allTrue;

function andTrue
    "Returns true, if all elements of the Boolean input vector are true ('and')"
  extends Modelica.Icons.Function;
  input Boolean b[:] "Boolean vector";
  output Boolean result "= true, if all elements of b are true";
algorithm
  result := true;
  for i in 1:size(b,1) loop
     result := result and b[i];
  end for;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<strong>andTrue</strong>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns <strong>true</strong> if all elements of the Boolean input vector b are <strong>true</strong>.
Otherwise the function returns <strong>false</strong>. If b is an empty vector,
i.e., size(b,1)=0, the function returns <strong>true</strong> (as opposed to <a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a> returning <strong>false</strong>).
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {true, true, true};
  Boolean b2[3] = {false, true, false};
  Boolean r1, r2;
<strong>algorithm</strong>
  r1 = andTrue(b1);  // r1 = true
  r2 = andTrue(b2);  // r2 = false
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>

</html>"));
end andTrue;

function anyTrue
    "Returns true, if at least one element of the Boolean input vector is true ('or')"

  extends Modelica.Icons.Function;
  input Boolean b[:] "Boolean vector";
  output Boolean result "= true, if at least one element of b is true";
algorithm
  result := false;
  for i in 1:size(b,1) loop
     result := result or b[i];
  end for;
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<strong>anyTrue</strong>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns <strong>true</strong> if at least one element of the input Boolean vector b is <strong>true</strong>.
Otherwise the function returns <strong>false</strong>. If b is an empty vector,
i.e., size(b,1)=0, the function returns <strong>false</strong>.
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean r1, r2;
<strong>algorithm</strong>
  r1 = anyTrue(b1);  // r1 = false
  r2 = anyTrue(b2);  // r2 = true
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end anyTrue;

function countTrue "Returns the number of true elements in a Boolean vector"

  extends Modelica.Icons.Function;
  input Boolean b[:] "Boolean vector";
  output Integer n "Number of true elements in b";
algorithm
  n := sum(if b[i] then 1 else 0 for i in 1:size(b, 1));

    annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<strong>countTrue</strong>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the number of <strong>true</strong> elements in a Boolean vector b.
</p>

<h4>Example</h4>
<p><code>countTrue({false, true, false, true})</code> returns 2.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end countTrue;

function enumerate
    "Enumerates the true elements in a Boolean vector (0 for false elements)"
  extends Modelica.Icons.Function;

  input Boolean b[:] "Boolean vector";
  output Integer enumerated[size(b, 1)]
      "Indices of the true elements in b (increasing order; 0 for false elements)";

  protected
  Integer count;

algorithm
    count := 1;
    for i in 1:size(b, 1) loop
      if b[i] then
        enumerated[i] := count;
        count := count + 1;
      else
        enumerated[i] := 0;
      end if;
    end for;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<strong>enumerate</strong>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns an integer vector that consecutively numbers
the <strong>true</strong> elements in a Boolean vector b. The <strong>false</strong> elements are
indicated by 0.
</p>

<h4>Example</h4>
<p><code>enumerate({false, true, false, true})</code> returns <code>{0,1,0,2}</code>.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end enumerate;

function firstTrueIndex
    "Returns the index of the first true element of a Boolean vector"
  extends Modelica.Icons.Function;
  input Boolean b[:] "Boolean vector";
  output Integer index "Index of the first true element of b";
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
<strong>firstTrueIndex</strong>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns the index of the first <strong>true</strong> element of the Boolean vector b.
If no element is <strong>true</strong> or b is an empty vector (i.e., size(b,1)=0) the
function returns 0.
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean b3[4] = {false, true, false, true};
  Integer r1, r2, r3;
<strong>algorithm</strong>
  r1 = firstTrueIndex(b1);  // r1 = 0
  r2 = firstTrueIndex(b2);  // r2 = 2
  r3 = firstTrueIndex(b3);  // r3 = 2
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end firstTrueIndex;

function index "Returns the indices of the true elements of a Boolean vector"
  extends Modelica.Icons.Function;

  input Boolean b[:] "Boolean vector";
  output Integer indices[countTrue(b)] "Indices of the true elements of b";

  protected
  Integer count;

algorithm
    count := 1;
    for i in 1:size(b, 1) loop
      if b[i] then
        indices[count] := i;
        count := count + 1;
      end if;
    end for;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<strong>index</strong>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns an integer vector that contains indices to the
<strong>true</strong> elements in a Boolean vector b. The number of elements in
the integer vector is the number of <strong>true</strong> elements in b.
</p>

<h4>Example</h4>
<code>index({false, true, false, true})</code> returns <code>{2,4}</code>.

  <h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end index;

function oneTrue
    "Returns true, if exactly one element of the Boolean input vector is true (\"xor\")"
  extends Modelica.Icons.Function;

  input Boolean b[:] "Boolean vector";
  output Boolean result "= true, if exactly one element of b is true";

algorithm
  result := countTrue(b) == 1;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<strong>oneTrue</strong>(b);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns <strong>true</strong> if exactly one element of the input Boolean vector b is <strong>true</strong>.
Otherwise the function returns <strong>false</strong>. If b is an empty vector,
i.e., size(b,1)=0, the function returns <strong>false</strong>.
</p>

<h4>Example</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean b3[3] = {false, true, true};
  Boolean r1, r2, r3;
<strong>algorithm</strong>
  r1 = oneTrue(b1);  // r1 = false
  r2 = oneTrue(b2);  // r2 = true
  r3 = oneTrue(b3);  // r3 = false
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>.
</p>
</html>"));
end oneTrue;
  annotation (Documentation(info="<html>
<p>
This library provides functions operating on vectors that have
a Boolean vector as input argument.
</p>
</html>"), Icon(graphics={Rectangle(
          extent={{-16,62},{14,14}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-16,-18},{14,-66}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid)}));
end BooleanVectors;
