[[include:mover_SwitchMover_type]]

This mover allows the option of choose between several different movers provided to it.

In combination with `-parser:script_vars`, it basically allows a single script to have different behaviours depending on the selected mover to run. Thus, something such as: (assuming that `minimize`, `minimize_pack` and `fastdesign` are the names of three already declared movers)

``` 
<SwitchMover name="switch" movers="minimize,minimize_pack,fastdesign" selected="%%protocol%%" />
``` 

Will allow to call to one or another depending on the circumstance from outside the script.  
The extra value is that the name of the selected mover is added as a score to the score/silent file. That score's name will be the name of the mover. Thus, in the previous case, we could get a new score named `switch` with a value equal to the name of the `%%protocol%%` requested
