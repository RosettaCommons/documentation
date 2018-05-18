<!-- --- title: Simulatedannealing (Metropolishastings) -->This is not implemented. But it would be fairly straightfoward to do. in initialize\_simulation() you need to query the number of cycles change the temperature in "temperature\_move()" according to the pre-set schedule. Figure out a nice input format for the schedule: e.g

simulated\_annealing.schedule:

    progress temp
    0 3
    0.5 1
    1 0.6 

fast cooling from 3-\>1 during first half of simulation; slow coolins from 1-\>0.6 during second half.

One could have a RosettaScripts syntax to specify temperature targets that would then get turned into a schedule. I'd imagine the following:

```xml
<TemperatureTarget temperature="(Real)" progress_frac="(Real)" interpolation="(linear" or exponential)>
```

The above could be specified in XML like the following:

```xml
     <MetropolisHastingsMover temperature="3">
       <SimulatedAnnealing>
         <TemperatureTarget temp="1" progress_frac="0.5"/>
         <TemperatureTarget temp="0.6" progress_frac="1"/>
       </SimulatedAnnealing>
     </MetropolisHastingsMover>
```

If no TemperatureTarget for progress\_frac 0 is given the starting temperature of the MetropolisHastingsMover is used. The target time could be specified either in the number of trials (dangerous) or fraction of total trials (better). Interpolation between the previous temperature and the target temperature could be either linear or exponential.
