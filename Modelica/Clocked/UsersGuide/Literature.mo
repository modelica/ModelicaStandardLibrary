within Modelica.Clocked.UsersGuide;
class Literature "Literature"
  extends Modelica.Icons.References;
  annotation (Documentation(info="<html>

<p>
<em>This library is based on the following references:</em>
<br>
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>[Astrom2008]</td>
    <td>K.J. Astr&ouml;m, B. Wittenmark,
      <em>Computer Controlled Systems: Theory and Design</em>,
      3rd ed.: Prentice Hall, 1997.</td>
  </tr>
  <tr>
    <td>[Elmqvist2012]</td>
    <td>H. Elmqvist, M. Otter, S.E. Mattsson,
      \"Fundamentals of Synchronous Control in Modelica,\"
      In <em>Proceedings of 9th International Modelica Conference</em>,
      Munich, Germany, Sep. 3-5, 2012.
      <a href=\"https://www.doi.org/10.3384/ecp1207615\">DOI:10.3384/ecp1207615</a>.</td>
  </tr>
  <tr>
    <td>[Otter2012]</td>
    <td>M. Otter, B. Thiele, S.E. Mattsson,
      \"A Library for Synchronous Control Systems in Modelica,\"
      In <em>Proceedings of 9th International Modelica Conference</em>,
      Munich, Germany, Sep. 3-5, 2012.
      <a href=\"https://www.doi.org/10.3384/ecp1207627\">DOI:10.3384/ecp1207627</a>.</td>
  </tr>
  <tr>
    <td>[Walther2002]</td>
    <td>N. Walther,
      \"Praxisgerechte Modelica-Bibliothek f&uuml;r Abtastregler,\"
      Diplomarbeit, HTWK Leipzig, Fachbereich Elektro- und Informationstechnik,
      supervised by Prof. M&uuml;ller (HWTK) and Prof. Martin Otter (DLR), 12 Nov. 2002.</td>
  </tr>
</table>

<p>
<em>
The synchronous Modelica language elements allow for the first
time to utilize a continuous-time, nonlinear, inverse model in
a Modelica sampled-data system, by automatically discretizing
this model and providing it as a clocked partition. This allows
a convenient definition of certain nonlinear control systems,
see example
<a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\">Examples.Systems.ControlledMixingUnit</a>.
Several practical details to use nonlinear inverse plant models in
a control system are discussed in the following reference:</em>
<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>[Looye2005]</td>
    <td>G. Looye, M. Th&uuml;mmel, M. Kurze, M. Otter, and J. Bals,
      \"Nonlinear Inverse Models for Control\",
      In <em>Proceedings of 4th International Modelica Conference</em>,
      Hamburg, Germany, Mar. 7-8, 2005.
      <a href=\"https://www.modelica.org/events/Conference2005/online_proceedings/Session3/Session3c3.pdf\">Download</a>.</td>
  </tr>
</table>

<p>
<em>
The synchronous Modelica language elements used in this library
are based on the clock calculus and inference system proposed by [Colaco2003]
and implemented in Lucid Synchrone version 2 and 3 [Pouzet2006].
However, the Modelica approach also uses multi-rate periodic clocks based on
rational arithmetic introduced by [Forget2008], as an extension of
the Lucid Synchrone semantics. These approaches belong to the class of
synchronous languages [Benveniste2003]:</em>
<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>[Benveniste2003]</td>
    <td>A. Benveniste, P. Caspi, S.A. Edwards, N. Halbwachs, P. Le Guernic, and R. Simone,
      \"The Synchronous Languages Twelve Years Later,\"
      In <em>Proceedings of the IEEE</em>,
      Vol., 91, No. 1, 2003.
      <a href=\"http://www.irisa.fr/distribcom/benveniste/pub/synch_ProcIEEE_2002.pdf\">Download</a>.</td>
  </tr>
  <tr>
    <td>[Colaco2003]</td>
    <td>J.-L. Colaco, and M. Pouzet,
      \"Clocks as First Class Abstract Types,\"
      In <em>Third International Conference on Embedded Software (EMSOFT'03)</em>,
      Philadelphia, Pennsylvania, USA, October 2003.
      <a href=\"http://www.di.ens.fr/~pouzet/lucid-synchrone/papers/emsoft03.ps.gz\">Download</a>.</td>
  </tr>
  <tr>
    <td>[Forget2008]</td>
    <td>J. Forget, F. Boniol, D. Lesens, C. Pagetti,
      \"A Multi-Periodic Synchronous Data-Flow Language,\"
      In <em>11th IEEE High Assurance Systems Engineering Symposium (HASE'08)</em>,
      pp. 251-260, Nanjing, China, Dec. 3-5, 2008.
      <a href=\"http://ieeexplore.ieee.org/xpl/articleDetails.jsp?reload=true&amp;arnumber=4708883&amp;contentType=Conference+Publications\">Download</a>.</td>
  </tr>
  <tr>
    <td>[Pouzet2006]</td>
    <td>M. Pouzet,
      \"Lucid Synchrone, Version 3.0, Tutorial and Reference Manual\".
      <a href=\"http://www.di.ens.fr/~pouzet/lucid-synchrone/\">Download</a>.</td>
  </tr>
</table>

</html>"));
end Literature;
