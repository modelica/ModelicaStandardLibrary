within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
function random "Pseudo random number generator"
  extends Modelica.Icons.Function;

  input Integer seedIn[3]
    "Integer vector defining random number sequence, e.g., {23,87,187}";
  output Real x "Random number between 0 and 1";
  output Integer seedOut[3]
    "Modified seed to be used for next call of random()";
algorithm
  seedOut[1] := rem((171*seedIn[1]), 30269);
  seedOut[2] := rem((172*seedIn[2]), 30307);
  seedOut[3] := rem((170*seedIn[3]), 30323);
  // zero is a poor seed, therefore substitute 1;
  if seedOut[1] == 0 then
    seedOut[1] := 1;
  end if;
  if seedOut[2] == 0 then
    seedOut[2] := 1;
  end if;
  if seedOut[3] == 0 then
    seedOut[3] := 1;
  end if;
  x := rem((seedOut[1]/30269.0 + seedOut[2]/30307.0 + seedOut[3]/30323.0), 1.0);
  annotation (
    Documentation(info="<html>
<p>
<em>Random</em> generates a sequence of uniform distributed
pseudo-random numbers. The algorithm is a variant of the
multiplicative congruential algorithm, known as the
Wichmann-Hill generator:</p>
<blockquote><pre>
x(k) = (a1*x(k-1)) mod m1
y(k) = (a2*y(k-1)) mod m2
z(k) = (a3*z(k-1)) mod m3
U(k) = (x(k)/m1 + y(k)/m2 + z(k)/m3) mod 1
</pre></blockquote>
<p>
This generates pseudo-random numbers U(k) uniformly distributed
in the interval (0,1). There are many forms of generators depending
on the parameters m (prime numbers) and a. The sequence needs an
initial Integer vector {x,y,z} known as the seed. The use of the same
seed will lead to the same sequence of numbers.
</p>
<p>
<strong>Remarks</strong>
</p>
<p>Random number generators (RNG) are pseudo-functions which are not true
functions but algorithms which deliver a fixed sequence of (usually Integer) numbers
which should have a very large period before they repeat itself and
appropriate statistic properties such that the sequence appears to be
a random draw. For real-valued random numbers, the integers are scaled to
the real interval 0.0-1.0. They result in a uniformly distributed random variate
between 0-1, which has to be transformed to give a random variate of a wanted
distribution. There are two types of techniques for transforming random variates:
</p>
<ul>
<li>Acceptance-Rejection techniques</li>
<li>Transformation techniques</li>
</ul>
<p>Acceptance-Rejection techniques throw away some of the generated variates and are thus less efficient. They can not be avoided for all distributions. A good summary about random number generation and most of the transformation techniques used below is given in:</p>
 <address> Discrete Event Simulation <br>
 Jerry Banks and John S. Carson II<br>
 Prentice Hall Inc.<br>
 Englewood Cliffs, New Jersey<br>
 </address>
<p>Some of the other references are quoted below.</p>
<blockquote><pre>
WICHMANN-HILL RANDOM NUMBER GENERATOR
Wichmann, B. A. & Hill, I. D. (1982)
  Algorithm AS 183:
  An efficient and portable pseudo-random number generator
  Applied Statistics 31 (1982) 188-190
see also:
  Correction to Algorithm AS 183
  Applied Statistics 33 (1984) 123
McLeod, A. I. (1985)
  A remark on Algorithm AS 183
  Applied Statistics 34 (1985),198-200
In order to completely avoid external functions, all seeds are
set via parameters. For simulation purposes this is almost
always the desired behaviour.
Translated by Hubertus Tummescheit from Python source provided by
Guido van Rossum translated from C source by Adrian Baddeley.
http://www.python.org/doc/current/lib/module-random.html
R A N D O M   V A R I A B L E   G E N E R A T O R S
distributions on the real line:
------------------------------
    normal (Gaussian) 2 versions
</pre></blockquote>
<h4>Reference Literature</h4>
<ul>
<li>function random: Wichmann, B. A. & Hill, I. D. (1982), Algorithm AS 183:
  <br>
  An efficient and portable pseudo-random number generator, Applied Statistics 31 (1982) 188-190<br>
  see also: Correction to Algorithm AS 183, Applied Statistics 33 (1984) 123 <br>
  McLeod, A. I. (1985), A remark on Algorithm AS 183, Applied Statistics 34 (1985),198-200</li>
<li>function normalvariate: Kinderman, A.J. and Monahan, J.F., 'Computer generation of random
  variables using the ratio of uniform deviates', ACM Trans Math Software, 3, (1977),
  pp257-260.</li>
<li>function gaussianvariate: Discrete Event Simulation, Jerry Banks and John S. Carson II,
<br>
  Prentice Hall Inc. Englewood Cliffs, New Jersey, page 315/316</li>
</ul>
<p>
Copyright &copy; Hubertus Tummescheit and Department of Automatic Control, Lund University, Sweden.
</p>
<p>
<em>This Modelica function is <strong>free</strong> software; it can be redistributed and/or modified
under the terms of the BSD-3-Clause license.</em>
</p>
</html>",
  revisions="<html>
<p>2019-05-20: Changed license to BSD-3-Clause after consultation with Hubertus Tummescheit.</p>
</html>"));
end random;
