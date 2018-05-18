# MetropolisHastings
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MetropolisHastings

This mover performs [[Metropolis-Hastings Monte Carlo simulations|MetropolisHastings-Documentation]] , which can be used to estimate the thermodynamic distribution of conformational states for a given score function, temperature, and set of underlying movers. See the dedicated [[MetropolisHastings Documentation|MetropolisHastings-Documentation]] page for more information.

```xml
<MetropolisHastings name="(&string)" scorefxn="(score12 &string)" temperature="(0.6 &Real)" trials="(1000 &Size)">
  ...
</MetropolisHastings>
```

The MetropolisHastings mover uses submovers to perform the trial moves and optionally record statistics about the simulation after each trial. They can be specified in one of two ways:

1.  Defining the movers within MetropolisHastings:

    ```
    <MetropolisHastings ...>
      <Backrub sampling_weight=(1 &Real) .../>
    </MetropolisHastings>
    ```

2.  Referencing previously defined movers:

    ```
    <Backrub name=backrub .../>
    <MetropolisHastings ...>
      <Add mover_name=backrub sampling_weight=(1 &Real)/>
    </MetropolisHastings>
    ```

In either case, the probability that any given submover will be chosen during the simulation can be controlled using the sampling\_weight parameter. The sampling weights for all movers are automatically normalized to 1. Submovers used with MetropolisHastings must be subclasses of ThermodynamicMover.

In addition to trial movers, you can also specify a specialized mover that will change the temperature or score function during the simulation. This type of mover is called a TemperatureController. Finally, additional movers that only record simulation statistics after each trial move can also be used, which are known as ThermodynamicObserver modules.

Both the TemperatureController and ThermodynamicObserver modules can be specified in the same two ways as trial movers, with the sampling\_weight excluded, for example:

```xml
<MetropolisHastings ...>
  <Backrub sampling_weight="(1 &Real)" .../>
  <SimulatedTempering temp_low="(0.6 &Real)" .../>
  <PDBTrajectoryRecorder stride="(100 &Size)" filename="(traj.pdb &string)"/>
  <MetricRecorder stride="(100 &Size)" filename="(metrics.txt &string)">
    <Torsion rsd="(&string)" type="(&string)" torsion="(&Size)" name="('' &string)"/>
  </MetricRecorder>
</MetropolisHastings>
```


##See Also

* [[MetropolisHastings Documentation]]: Home page of documentation for the MetropolisHastings protocol
* [[I want to do x]]: Guide to choosing a mover
