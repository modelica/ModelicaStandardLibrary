within Modelica.ComplexMath.Vectors;
function sort "Sort elements of complex vector"
  extends Modelica.Icons.Function;
  input Complex v[:] "Vector to be sorted";
  input Boolean ascending = true
        "= true if ascending order, otherwise descending order";
  input Boolean sortFrequency=true
        "= true, if sorting is first for imaginary then for real value; = false, if sorting is for absolute value";
  output Complex sorted_v[size(v,1)] = v "Sorted vector";
  output Integer indices[size(v,1)] = 1:size(v,1) "sorted_v = v[indices]";

  /* shellsort algorithm; should be improved later */
protected
  Integer gap;
  Integer i;
  Integer j;
  Complex wv;
  Integer wi;
  Integer nv = size(v,1);
  Boolean swap;
  Integer k1;
  Integer k2;
algorithm
  gap := div(nv,2);

  while gap > 0 loop
     i := gap;
     while i < nv loop
        j := i-gap;
        if j>=0 then
           k1 := j+1;
           k2 := j + gap + 1;
           if sortFrequency then
              if ascending then
                 swap := abs(sorted_v[k1].im) >  abs(sorted_v[k2].im) or
                         abs(sorted_v[k1].im) == abs(sorted_v[k2].im) and
                         (sorted_v[k1].re  > sorted_v[k2].re or
                          sorted_v[k1].re  == sorted_v[k2].re and sorted_v[k1].im < sorted_v[k2].im);
              else
                 swap := abs(sorted_v[k1].im) <  abs(sorted_v[k2].im) or
                         abs(sorted_v[k1].im) == abs(sorted_v[k2].im) and
                         (sorted_v[k1].re  < sorted_v[k2].re or
                          sorted_v[k1].re  == sorted_v[k2].re and sorted_v[k1].im < sorted_v[k2].im);
              end if;
           else
              if ascending then
            swap := ComplexMath.'abs'(sorted_v[k1]) > ComplexMath.'abs'(
              sorted_v[k2]);
              else
            swap := ComplexMath.'abs'(sorted_v[k1]) < ComplexMath.'abs'(
              sorted_v[k2]);
              end if;
           end if;
        else
           swap := false;
        end if;

        while swap loop
           wv := sorted_v[j+1];
           wi := indices[j+1];
           sorted_v[j+1] := sorted_v[j+gap+1];
           sorted_v[j+gap+1] := wv;
           indices[j+1] := indices[j+gap+1];
           indices[j+gap+1] := wi;
           j := j - gap;
           if j >= 0 then
              k1 := j+1;
              k2 := j + gap + 1;
              if sortFrequency then
                 if ascending then
                    swap := abs(sorted_v[k1].im) >  abs(sorted_v[k2].im) or
                            abs(sorted_v[k1].im) == abs(sorted_v[k2].im) and
                            (sorted_v[k1].re  > sorted_v[k2].re or
                             sorted_v[k1].re  == sorted_v[k2].re and sorted_v[k1].im < sorted_v[k2].im);
                 else
                    swap := abs(sorted_v[k1].im) <  abs(sorted_v[k2].im) or
                            abs(sorted_v[k1].im) == abs(sorted_v[k2].im) and
                            (sorted_v[k1].re  < sorted_v[k2].re or
                             sorted_v[k1].re  == sorted_v[k2].re and sorted_v[k1].im < sorted_v[k2].im);
                 end if;
              else
                 if ascending then
              swap := ComplexMath.'abs'(sorted_v[k1]) > ComplexMath.'abs'(
                sorted_v[k2]);
                 else
              swap := ComplexMath.'abs'(sorted_v[k1]) < ComplexMath.'abs'(
                sorted_v[k2]);
                 end if;
              end if;
           else
              swap := false;
           end if;
        end while;
        i := i + 1;
     end while;
     gap := div(gap,2);
  end while;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           sorted_v = Vectors.<strong>sort</strong>(v);
(sorted_v, indices) = Vectors.<strong>sort</strong>(v, ascending=true);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>sort</strong>(..) sorts a Real vector v
in ascending order and returns the result in sorted_v.
If the optional argument \"ascending\" is <strong>false</strong>, the vector
is sorted in descending order. In the optional second
output argument the indices of the sorted vector with respect
to the original vector are given, such that sorted_v = v[indices].
</p>

<h4>Example</h4>
<blockquote><pre>
(v2, i2) := Vectors.sort({-1, 8, 3, 6, 2});
    -> v2 = {-1, 2, 3, 6, 8}
       i2 = {1, 5, 3, 4, 2}
</pre></blockquote>

</html>"));
end sort;
