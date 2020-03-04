within Modelica.Blocks.Interfaces;
package Adaptors "Package with adaptors (especially useful for FMUs)"
  extends Modelica.Icons.InterfacesPackage;

  annotation (Documentation(info="<html>
<p>
This package contains partial adaptors to implement adaptors in various domains
between a physical connector and a signal representation of the connector signals.
This component is used to provide a pure signal interface around a physical model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
</p>
</html>"));
end Adaptors;
