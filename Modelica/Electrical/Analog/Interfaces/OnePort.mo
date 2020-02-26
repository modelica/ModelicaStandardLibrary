within Modelica.Electrical.Analog.Interfaces;
partial model OnePort
  "Component with two electrical pins p and n and current i from p to n"
  extends TwoPin;
  SI.Current i "Current flowing from pin p to pin n";
equation
  0 = p.i + n.i;
  i = p.i;
  annotation (
    Documentation(info="<html>
<p>Superclass of elements which have <strong>two</strong> electrical pins: the positive pin connector <em>p</em>, and the negative pin connector <em>n</em>. It is assumed that the current flowing into pin p is identical to the current flowing out of pin n. This current is provided explicitly as current i.</p>
</html>",
 revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
end OnePort;
