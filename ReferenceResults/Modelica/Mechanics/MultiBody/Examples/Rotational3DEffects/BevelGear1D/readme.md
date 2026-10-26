# Modelica.Mechanics.MultiBody.Examples.Rotational3DEffects.BevelGear1D

## MSL 4.1.0-dev vs. MSL 4.0.0

2024-10-21: The CSV file has been manually edited in order to stop comparison at 0.4 s.

- The original simulation result is available named BevelGear1D.csv.uncut

- More info from issue "MSL 4.1.0 Regressions - MultiBody" https://github.com/modelica/ModelicaStandardLibrary/issues/4341

    - The trajectories diverge sharply for time > 0.52, most likely due to chaotic motion - the system is highly nonlinear and has more than two states, which are necessary ingredients for the path to chaos. Just changing Dymola version produces a different trajectory after that point, and also OpenModelica behaves differently. There's no point trying to reproduce chaotic trajectories, so we can limit the time span to StopTime = 0.4 only for the reference results. 
    - CSV compare should stop comparing when it no longer has data, but it needs to be fixed, see issue
    "Correctly handle reference files with shorter time span than simulation StopTime"
    https://github.com/modelica-tools/csv-compare/issues/65

