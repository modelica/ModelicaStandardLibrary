package Modelica_Interpolation "Interpolation of tables and geometric curves with Bsplines of any order"
  annotation (version="0.96",
              versionDate="2006-02-19",
              uses(                        Plot3D(version="1"), Modelica(
        version="2.2.2 development")),
              preferedView="info",
                     Documentation(info="<html>
<p>
Library <b>Modelica_Interpolation</b> is a <b>free</b> Modelica package 
providing basic functionality for the 1-dim. interpolation of
Bsplines of any order and some higher level models and functions, such 
as <a href=\"Modelica://Modelica_Interpolation.Tables\">Tables</a>,
where the Bsplines are used to interpolate in tables and in 
geometric curves in space. It is planned to include this library
into the Modelica Standard Library.
</p>

<p>
The basic input data to construct splines are a set of points
(n-dim. vectors) defined over a path parameter. Optionally, 
also the first derivatives at these points can be provided
as input data (= Hermite splines). From this data a spline
data structure (= <a href=\"Modelica://Modelica_Interpolation.Bspline1D\">Bspline1D</a>)
is constructed and operations are provided to interpolate the
function values, or first and higher order derivatives of the
Bsplines. In the following two figures, typical results of this
package are shown:
</p>

<p>
<img src=\"../Images/plot_dim2.png\"><br>
<img src=\"../Images/plot_dim3.png\">
</p>

<p>
This is a beta release of library Modelica_Interpolation. All models and functions are
tested and should work as expected. It might be that for the release
version some interfaces will change (especially the plotXXX function
interfaces) and that no automatic conversion from this
beta release to the release version will be provided.
The documentation is yet incomplete. For a release version and before an inclusion
into the Modelica Standard Library, the following needs to be improved:
</p>

<ul>
<li> The plot functionality is based on Dymolas plot API, since there is
     no free Modelica plot interface available. It is planned to define
     a standardized set of plot interfaces. Once available, this package will
     be based on this vendor-independent interface.</li>
<li> The B-Spline data has currently to be defined via Modelica arrays. 
     Tool-specific function calls might be used (such as \"ReadMatrix\" from Dymola)
     to read interpolation data from file. Experience shows that large data sets
     that shall be interpolated become unefficient in this case. It is planned
     to enhance this package so that large data sets available on file are
     efficiently handled. This requires either an extension of Modelica or
     (prefered) an automatic caching functionality of Modelica tools. The basic
     idea is that interpolation is defined via a set of function calls:
     <pre>
          y = interpolate(u, getSplineCoefficients(readTableData(filename)));     </pre>
     Formally, at every interpolation point the data is read from file and
     the spline coefficients are computed before the interpolation is carried out.
     However, a tool could automatically
     deduce that functions \"getSplineCoefficients(..)\" and \"readTableData(..)\"
     need only to be called once (since the input arguments depend on constant
     data) and could dynamically cache the resulting data structure for further
     use. The main advantage is that from a user perspective, interpolation
     is then performed efficiently by a <b>pure function</b>.</li>
<li> Usage of the interpolation as model, e.g., \"Modelica_Interpolation.Tables.Table1D\"
     is reasonably efficient. However, using it in form of a (pure) function call,
     e.g., \"Modelica_Interpolation.Tables.interpolate1D\" is currently very unefficient
     because the above sketched caching technique is not available in Dymola or
     other Modelica tools (this function computes the spline coefficients for every
     interpolation point).</li>
<li> Currently, all Modelica tools have restrictions how to handled records
     containing dynamic arrays. It is not yet clear whether this is a tool issue
     and/or whether there are missing pieces in the Modelica specification.
     As a result, usage of the Bspline datastructure is sometimes currently
     awkward. This should be improved. </li>
</ul>

<p>
The main functions of this package have been developed by Gerhard Schillhuber under
a contract of DLR based on its diploma thesis
'Geometrische Modellierung oszillationsarmer Trajektorien von
Industrierobotern', TU Munich, June 2002; supervisors: Prof. R. Koch and 
Dr.-Ing. Martin Otter). The package has then been improved by Martin Otter (DLR),
especially restructuring the package and 
adding standard plot functions (based on Dymolas plot interface).
</p>
 
<p>
Copyright &copy; 2002-2007, DLR and Modelica Association.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
 
</html>"),
classOrder={"UsersGuide","Bspline1D","Table1D","Curve","Path","*"});
end Modelica_Interpolation;
