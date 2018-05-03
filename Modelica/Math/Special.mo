within Modelica.Math;
package Special "Library of special mathematical functions"
  extends Modelica.Icons.Package;

  function erf "Error function erf(u) = 2/sqrt(pi)*Integral_0_u exp(-t^2)*d"
    extends Modelica.Icons.Function;
    input Real u "Input argument";
    output Real y "= 2/sqrt(pi)*Integral_0_u exp(-t^2)*dt";
  protected
     Boolean inv;
     Real z;
     Real zz;
     constant Real y1 = 1.044948577880859375;
     constant Real P[5] = {0.0834305892146531832907,
                           -0.338165134459360935041,
                           -0.0509990735146777432841,
                           -0.00772758345802133288487,
                           -0.000322780120964605683831};
     constant Real Q[5] = {1,
                           0.455004033050794024546,
                           0.0875222600142252549554,
                           0.00858571925074406212772,
                           0.000370900071787748000569};
  algorithm
     if u >= 0 then
        z :=u;
        inv :=false;
     else
        z :=-u;
        inv :=true;
     end if;

     if z < 0.5 then
        if z <= 0 then
           y := 0;
        elseif z < 1.0e-10 then
           y := z*1.125 + z*0.003379167095512573896158903121545171688;
        else
           // Maximum Deviation Found:                     1.561e-17
           // Expected Error Term:                         1.561e-17
           // Maximum Relative Change in Control Points:   1.155e-04
           // Max Error found at double precision =        2.961182e-17
           zz := z*z;
           y := z*(y1 + Internal.polyEval(P, zz)/Internal.polyEval(Q, zz));
        end if;

     elseif z < 5.8 then
        y :=1 - Internal.erfcUtil(z);

     else
        y :=1;
     end if;

     if inv then
        y :=-y;
     end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Special.<strong>erf</strong>(u);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the error function erf(u) = 2/sqrt(pi)*Integral_0_u exp(-t^2)*dt numerically with a relative precision of about 1e-15. The implementation utilizes the formulation of the Boost library
(53-bit implementation of <a href=\"http://www.boost.org/doc/libs/1_57_0/boost/math/special_functions/erf.hpp\">erf.hpp</a>,
developed by John Maddock). Plot
of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Special/erf.png\">
</blockquote>

<p>
For more details, see <a href=\"http://en.wikipedia.org/wiki/Error_function\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  erf(0)    // = 0
  erf(10)   // = 1
  erf(0.5)  // = 0.520499877813047
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Special.erfc\">erfc</a>,
<a href=\"modelica://Modelica.Math.Special.erfInv\">erfInv</a>,
<a href=\"modelica://Modelica.Math.Special.erfcInv\">erfcInv</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end erf;

  function erfc "Complementary error function erfc(u) = 1 - erf(u)"
    extends Modelica.Icons.Function;
    input Real u "Input argument";
    output Real y "= 1 - erf(u)";

  algorithm
    if u < 0 then
       if u < -0.5 then
          if u > -28 then
             y := 2 - Internal.erfcUtil(-u);
          else
             y := 2;
          end if;
       else
          y := 1 + erf(-u);
       end if;

    elseif u < 0.5 then
       y := 1 - erf(u);

    elseif u < 28 then
       y := Internal.erfcUtil(u);

    else
       y := 0;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Special.<strong>erfc</strong>(u);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the complementary error function erfc(u) = 1 - erf(u) with a relative precision of about 1e-15. The implementation utilizes the formulation of the Boost library
(53-bit implementation of <a href=\"http://www.boost.org/doc/libs/1_57_0/boost/math/special_functions/erf.hpp\">erf.hpp</a>
developed by John Maddock). Plot
of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Special/erfc.png\">
</blockquote>

<p>
If u is large and erf(u) is subtracted from 1.0, the result is not accurate.
It is then better to use erfc(u). For more details,
see <a href=\"http://en.wikipedia.org/wiki/Error_function\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  erfc(0)    // = 1
  erfc(10)   // = 0
  erfc(0.5)  // = 0.4795001221869534
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Special.erf\">erf</a>,
<a href=\"modelica://Modelica.Math.Special.erfInv\">erfInv</a>,
<a href=\"modelica://Modelica.Math.Special.erfcInv\">erfcInv</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end erfc;

  function erfInv "Inverse error function: u = erf(erfInv(u))"
    extends Modelica.Icons.Function;
    input Real u "Input argument in the range -1 <= u <= 1";
    output Real y "= inverse of error function";
  protected
    constant Real eps = 0.1;
  algorithm
    if u >= 1 then
       y := Modelica.Constants.inf;
    elseif u <= -1 then
       y := -Modelica.Constants.inf;
    elseif u == 0 then
       y := 0;
    elseif u < 0 then
       y :=-Internal.erfInvUtil(-u, 1 + u);
    else
       y :=Internal.erfInvUtil(u, 1 - u);
    end if;

    annotation (smoothOrder=1, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Special.<strong>erfInv</strong>(u);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the inverse of the error function erf(u) = 2/sqrt(pi)*Integral_0_u exp(-t^2)*dt numerically with a relative precision of about 1e-15. Therefore, u = erf(erfInv(u)). Input argument u must be in the range
(otherwise an assertion is raised):
</p>

<blockquote>
-1 &le; u &le; 1
</blockquote>

<p>
If u = 1, the function returns Modelica.Constants.inf.<br>
If u = -1, the function returns -Modelica.Constants.inf<br>
The implementation utilizes the formulation of the Boost library (<a href=\"http://www.boost.org/doc/libs/1_57_0/boost/math/special_functions/detail/erf_inv.hpp\">erf_inv.hpp</a>,
developed by John Maddock).<br>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Special/erfInv.png\">
</blockquote>

<p>
For more details, see <a href=\"http://en.wikipedia.org/wiki/Error_function\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  erfInv(0)            // = 0
  erfInv(0.5)          // = 0.4769362762044699
  erfInv(0.999999)     // = 3.458910737275499
  erfInv(0.9999999999) // = 4.572824958544925
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Special.erf\">erf</a>,
<a href=\"modelica://Modelica.Math.Special.erfc\">erfc</a>,
<a href=\"modelica://Modelica.Math.Special.erfcInv\">erfcInv</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end erfInv;

  function erfcInv "Inverse complementary error function: u = erfc(erfcInv(u))"
    extends Modelica.Icons.Function;
    input Real u "Input argument";
    output Real y "erfcInv(u)";
  algorithm
    assert(u >= 0 and u <= 2, "Input argument u not in range 0 <= u <= 2");

    if u == 0 then
       y := Modelica.Constants.inf;

    elseif u == 2 then
       y := -Modelica.Constants.inf;

    elseif u == 1 then
       y := 0;

    elseif u > 1 then
       y :=-Internal.erfInvUtil(u-1, 2-u);

    else
       y :=Internal.erfInvUtil(1-u, u);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Special.<strong>erfInv</strong>(u);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the inverse of the complementary error function
erfc(u) = 1 - erf(u) with a relative precision of about 1e-15.
Therefore, u = erfc(erfcInv(u)) and erfcInv(u) = erfInv(1 - u). Input argument u must be in the range
(otherwise an assertion is raised):
</p>

<blockquote>
0 &le; u &le; 2
</blockquote>

<p>
If u = 2, the function returns -Modelica.Constants.inf.<br>
If u = 0, the function returns Modelica.Constants.inf<br>
The implementation utilizes the formulation of the Boost library (<a href=\"http://www.boost.org/doc/libs/1_57_0/boost/math/special_functions/detail/erf_inv.hpp\">erf_inv.hpp</a>,
developed by John Maddock).<br>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Special/erfcInv.png\">
</blockquote>

<p>
For more details, see <a href=\"http://en.wikipedia.org/wiki/Error_function\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  erfcInv(1)         // = 0
  erfcInv(0.5)       // = 0.4769362762044699
  erfInv(1.999999)   // = -3.4589107372909473
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Special.erf\">erf</a>,
<a href=\"modelica://Modelica.Math.Special.erfc\">erfc</a>,
<a href=\"modelica://Modelica.Math.Special.erfInv\">erfInv</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end erfcInv;

  function sinc "Unnormalized sinc function: sinc(u) = sin(u)/u"
    extends Modelica.Icons.Function;
    input Real u "Input argument";
    output Real y "= sinc(u) = sin(u)/u";
  algorithm

    y := if abs(u) > 0.5e-4 then sin(u)/u else 1 - (u^2)/6 + (u^4)/120;

    annotation (Inline=true, Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>",   info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Special.<strong>sinc</strong>(u);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the unnormalized sinc function sinc(u) = sin(u)/u. The implementation utilizes
a Taylor series approximation for small values of u. Plot
of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Special/sinc.png\">
</blockquote>

<p>
For more details, see <a href=\"http://en.wikipedia.org/wiki/Sinc_function\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  sinc(0)   // = 1
  sinc(3)   // = 0.0470400026866224
</pre></blockquote>
</html>"));
  end sinc;

  package Internal
    "Internal utility functions that should not be directly utilized by the user"
     extends Modelica.Icons.InternalPackage;

    function polyEval "Evaluate a polynomial c[1] + c[2]*u + c[3]*u^2 + ...."
      extends Modelica.Icons.Function;
      input Real  c[:] "Polynomial coefficients";
      input Real  u "Abscissa value";
      output Real y "= c[1] + u*(c[2] + u*(c[3] + u*(c[4]*u^3 + ...)))";
    algorithm
      y := c[size(c,1)];
      for j in size(c, 1)-1:-1:1 loop
         y := c[j] + u*y;
      end for;
     annotation (Documentation(info="<html>
<p>
Evaluate a polynomial using Horner's scheme.
</p>
</html>",  revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end polyEval;

    function erfcUtil "Evaluate erfc(z) for 0.5 <= z "
      extends Modelica.Icons.Function;
      input Real z "Input argument 0.5 <= z required (but not checked)";
      output Real y "Result erfc(z) for 0.5 <= z";
    protected
       constant Real y1 = 0.405935764312744140625;
       constant Real P1[6] = {-0.098090592216281240205,
                               0.178114665841120341155,
                               0.191003695796775433986,
                               0.0888900368967884466578,
                               0.0195049001251218801359,
                               0.00180424538297014223957};
       constant Real Q1[7] = {1,
                              1.84759070983002217845,
                              1.42628004845511324508,
                              0.578052804889902404909,
                              0.12385097467900864233,
                              0.0113385233577001411017,
                              0.337511472483094676155e-5};

       constant Real y2 = 0.50672817230224609375;
       constant Real P2[6] = {-0.0243500476207698441272,
                               0.0386540375035707201728,
                               0.04394818964209516296,
                               0.0175679436311802092299,
                               0.00323962406290842133584,
                               0.000235839115596880717416};
       constant Real Q2[6] = {1,
                              1.53991494948552447182,
                              0.982403709157920235114,
                              0.325732924782444448493,
                              0.0563921837420478160373,
                              0.00410369723978904575884};

       constant Real y3 = 0.5405750274658203125;
       constant Real P3[6] = {0.00295276716530971662634,
                              0.0137384425896355332126,
                              0.00840807615555585383007,
                              0.00212825620914618649141,
                              0.000250269961544794627958,
                              0.113212406648847561139e-4};
       constant Real Q3[6] = {1,
                              1.04217814166938418171,
                              0.442597659481563127003,
                              0.0958492726301061423444,
                              0.0105982906484876531489,
                              0.000479411269521714493907};

       constant Real y4 = 0.5579090118408203125;
       constant Real P4[7] = {0.00628057170626964891937,
                              0.0175389834052493308818,
                             -0.212652252872804219852,
                             -0.687717681153649930619,
                             -2.5518551727311523996,
                             -3.22729451764143718517,
                             -2.8175401114513378771};
       constant Real Q4[7] = {1,
                              2.79257750980575282228,
                             11.0567237927800161565,
                             15.930646027911794143,
                             22.9367376522880577224,
                             13.5064170191802889145,
                              5.48409182238641741584};

    algorithm
       if z < 1.5 then
          // Maximum Deviation Found:                     3.702e-17
          // Expected Error Term:                         3.702e-17
          // Maximum Relative Change in Control Points:   2.845e-04
          // Max Error found at double precision =        4.841816e-17
          y :=y1 + polyEval(P1, z - 0.5)/polyEval(Q1, z - 0.5);

       elseif z < 2.5 then
          // Max Error found at double precision =        6.599585e-18
          // Maximum Deviation Found:                     3.909e-18
          // Expected Error Term:                         3.909e-18
          // Maximum Relative Change in Control Points:   9.886e-05
          y :=y2 + polyEval(P2, z - 1.5)/polyEval(Q2, z - 1.5);

       elseif z < 4.5 then
          // Maximum Deviation Found:                     1.512e-17
          // Expected Error Term:                         1.512e-17
          // Maximum Relative Change in Control Points:   2.222e-04
          // Max Error found at double precision =        2.062515e-17
          y :=y3 + polyEval(P3, z - 3.5)/polyEval(Q3, z - 3.5);

       else
          // Max Error found at double precision =        2.997958e-17
          // Maximum Deviation Found:                     2.860e-17
          // Expected Error Term:                         2.859e-17
          // Maximum Relative Change in Control Points:   1.357e-05
          y :=y4 + polyEval(P4, 1/z)/polyEval(Q4, 1/z);
       end if;

       y := y*(exp(-z * z) / z);
     annotation (Documentation(info="<html>
<p>
Utility function in order to compute part of erf(..) and erfc(..).
</p>
</html>",  revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end erfcUtil;

    function erfInvUtil "Utility function for erfInv(u) and erfcInv(u)"
      extends Modelica.Icons.Function;
      input Real p "First input argument";
      input Real q "Second input argument";
      output Real y "Result value";

    protected
       Real g;
       Real r;
       Real xs;
       Real x;

       constant Real y1 = 0.0891314744949340820313;
       constant Real P1[8] = {-0.000508781949658280665617,
                              -0.00836874819741736770379,
                               0.0334806625409744615033,
                              -0.0126926147662974029034,
                              -0.0365637971411762664006,
                               0.0219878681111168899165,
                               0.00822687874676915743155,
                              -0.00538772965071242932965};
       constant Real Q1[10] = { 1.0,
                               -0.970005043303290640362,
                               -1.56574558234175846809,
                                1.56221558398423026363,
                                0.662328840472002992063,
                               -0.71228902341542847553,
                               -0.0527396382340099713954,
                                0.0795283687341571680018,
                                -0.00233393759374190016776,
                                0.000886216390456424707504};

       constant Real y2 = 2.249481201171875;
       constant Real P2[9] = {-0.202433508355938759655,
                               0.105264680699391713268,
                               8.37050328343119927838,
                              17.6447298408374015486,
                             -18.8510648058714251895,
                             -44.6382324441786960818,
                              17.445385985570866523,
                              21.1294655448340526258,
                              -3.67192254707729348546};
       constant Real Q2[9] = {1.0,
                              6.24264124854247537712,
                              3.9713437953343869095,
                            -28.6608180499800029974,
                            -20.1432634680485188801,
                             48.5609213108739935468,
                             10.8268667355460159008,
                            -22.6436933413139721736,
                              1.72114765761200282724};

       constant Real y3 = 0.807220458984375;
       constant Real P3[11] = {-0.131102781679951906451,
                               -0.163794047193317060787,
                                0.117030156341995252019,
                                0.387079738972604337464,
                                0.337785538912035898924,
                                0.142869534408157156766,
                                0.0290157910005329060432,
                                0.00214558995388805277169,
                               -0.679465575181126350155e-6,
                                0.285225331782217055858e-7,
                               -0.681149956853776992068e-9};
       constant Real Q3[8] = { 1.0,
                               3.46625407242567245975,
                               5.38168345707006855425,
                               4.77846592945843778382,
                               2.59301921623620271374,
                               0.848854343457902036425,
                               0.152264338295331783612,
                               0.01105924229346489121};

       constant Real y4 = 0.93995571136474609375;
       constant Real P4[9] = {-0.0350353787183177984712,
                              -0.00222426529213447927281,
                               0.0185573306514231072324,
                               0.00950804701325919603619,
                               0.00187123492819559223345,
                               0.000157544617424960554631,
                               0.460469890584317994083e-5,
                              -0.230404776911882601748e-9,
                               0.266339227425782031962e-11};
       constant Real Q4[7] = { 1.0,
                               1.3653349817554063097,
                               0.762059164553623404043,
                               0.220091105764131249824,
                               0.0341589143670947727934,
                               0.00263861676657015992959,
                               0.764675292302794483503e-4};

       constant Real y5 = 0.98362827301025390625;
       constant Real P5[9] = {-0.0167431005076633737133,
                              -0.00112951438745580278863,
                               0.00105628862152492910091,
                               0.000209386317487588078668,
                               0.149624783758342370182e-4,
                               0.449696789927706453732e-6,
                               0.462596163522878599135e-8,
                              -0.281128735628831791805e-13,
                               0.99055709973310326855e-16};
       constant Real Q5[7] = {1.0,
                              0.591429344886417493481,
                              0.138151865749083321638,
                              0.0160746087093676504695,
                              0.000964011807005165528527,
                              0.275335474764726041141e-4,
                              0.282243172016108031869e-6};

       constant Real y6 = 0.99714565277099609375;
       constant Real P6[8] = {-0.0024978212791898131227,
                              -0.779190719229053954292e-5,
                               0.254723037413027451751e-4,
                               0.162397777342510920873e-5,
                               0.396341011304801168516e-7,
                               0.411632831190944208473e-9,
                               0.145596286718675035587e-11,
                              -0.116765012397184275695e-17};
       constant Real Q6[7] = {1.0,
                              0.207123112214422517181,
                              0.0169410838120975906478,
                              0.000690538265622684595676,
                              0.145007359818232637924e-4,
                              0.144437756628144157666e-6,
                              0.509761276599778486139e-9};

       constant Real y7 = 0.99941349029541015625;
       constant Real P7[8] = {-0.000539042911019078575891,
                              -0.28398759004727721098e-6,
                               0.899465114892291446442e-6,
                               0.229345859265920864296e-7,
                               0.225561444863500149219e-9,
                               0.947846627503022684216e-12,
                               0.135880130108924861008e-14,
                              -0.348890393399948882918e-21};
       constant Real Q7[7] = { 1.0,
                               0.0845746234001899436914,
                               0.00282092984726264681981,
                               0.468292921940894236786e-4,
                               0.399968812193862100054e-6,
                               0.161809290887904476097e-8,
                               0.231558608310259605225e-11};
    algorithm
       if p <= 0.5 then
          //
          // Evaluate inverse erf using the rational approximation:
          //
          // x = p(p+10)(Y+R(p))
          //
          // Where Y is a constant, and R(p) is optimised for a low
          // absolute error compared to |Y|.
          //
          // double: Max error found: 2.001849e-18
          // long double: Max error found: 1.017064e-20
          // Maximum Deviation Found (actual error term at infinite precision) 8.030e-21
          //
          g :=p*(p + 10);
          r :=polyEval(P1, p)/polyEval(Q1, p);
          y :=g*y1 + g*r;

       elseif q >= 0.25 then
          //
          // Rational approximation for 0.5 > q >= 0.25
          //
          // x = sqrt(-2*log(q)) / (Y + R(q))
          //
          // Where Y is a constant, and R(q) is optimised for a low
          // absolute error compared to Y.
          //
          // double : Max error found: 7.403372e-17
          // long double : Max error found: 6.084616e-20
          // Maximum Deviation Found (error term) 4.811e-20
          //
          g  :=sqrt(-2*log(q));
          xs :=q - 0.25;
          r :=polyEval(P2, xs)/polyEval(Q2, xs);
          y :=g/(y2 + r);

       else
          //
          // For q < 0.25 we have a series of rational approximations all
          // of the general form:
          //
          // let: x = sqrt(-log(q))
          //
          // Then the result is given by:
          //
          // x(Y+R(x-B))
          //
          // where Y is a constant, B is the lowest value of x for which
          // the approximation is valid, and R(x-B) is optimised for a low
          // absolute error compared to Y.
          //
          // Note that almost all code will really go through the first
          // or maybe second approximation.  After than we're dealing with very
          // small input values indeed: 80 and 128 bit long double's go all the
          // way down to ~ 1e-5000 so the "tail" is rather long...
          //
          x :=sqrt(-log(q));
          if x < 3 then
             // Max error found: 1.089051e-20
             xs :=x - 1.125;
             r :=polyEval(P3, xs)/polyEval(Q3, xs);
             y :=y3*x + r*x;

          elseif x < 6 then
             // Max error found: 8.389174e-21
             xs :=x - 3;
             r :=polyEval(P4, xs)/polyEval(Q4, xs);
             y :=y4*x + r*x;

          elseif x < 18 then
             // Max error found: 1.481312e-19
             xs :=x - 6;
             r :=polyEval(P5, xs)/polyEval(Q5, xs);
             y :=y5*x + r*x;

          elseif x < 44 then
             // Max error found: 5.697761e-20
             xs :=x - 18;
             r :=polyEval(P6, xs)/polyEval(Q6, xs);
             y :=y6*x + r*x;

          else
             // Max error found: 1.279746e-20
             xs :=x - 44;
             r :=polyEval(P7, xs)/polyEval(Q7, xs);
             y :=y7*x + r*x;
          end if;
       end if;
      annotation (Documentation(info="<html>
<p>
Utility function in order to compute erfInv(..) and erfcInv(..).
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end erfInvUtil;
    annotation (Documentation(info="<html>
<p>
This package contains internal utility functions for the computation of
erf, erfc, erfInc and erfcInv. These functions should not be directly used
by the user.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end Internal;
annotation (Icon(graphics={Line(
      points={{-80,-80},{-20,-80},{20,80},{80,80}},
      smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This sublibrary contains functions to compute often used mathematical operators that
cannot be expressed analytically.
</p>
</html>", revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
end Special;
