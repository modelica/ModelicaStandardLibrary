# ModelicaTest.MultiBody.Parts.Rotor1D.GearConstraint3

## MSL 4.1.0-dev vs. MSL 4.0.0

2024-10-21: The CSV file has been manually edited in order to stop comparison at 0.3 s.

- The original simulation result is available named GearConstraint3.csv.uncut

- More info from issue "MSL 4.1.0 Regressions - MultiBody" https://github.com/modelica/ModelicaStandardLibrary/issues/4341

    - Reason: chaotic motion with bifurcation after time = 0.30
    - Also needs fixing modelica-tools/csv-compare/missing smoothOrder annotations in Media #65 to avoid a false positive
      https://github.com/modelica/ModelicaStandardLibrary/issues/65


