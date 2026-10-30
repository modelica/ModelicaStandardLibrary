# Modelica parameter records

The file Par_*material*.txt can be transferred by copy and paste into a Modelica parameter record as shown in *ShowCharacteristic.mo*:

```
record *material*
  // copy and paste goes here
  annotation(defaultComponentPrefixes="parameter",
    defaultComponentName="material");
end *material*;
```

You can investigate your material using *Examples.ShowSSEE*:

Within 1 second the magnetic field strength `H` is varied between `Hmin` and `Hmax`.

The following quantities are calculated:

- Polarization `J`

- Flux density `B`

- Relative permability `m_r`

- Differential relative permability `m_rd`

- Magnetic flux `psi` (using parameter wA)

- Induced voltage `v`

and can be plotted either with respect to time or to the magnetic field strength `H`.
