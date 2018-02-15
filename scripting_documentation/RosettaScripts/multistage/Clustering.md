#MultistageRosettaScripts

#Resource Usage For Precalculated Clustering

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

UNDER CONSTRUCTION

##Runtime

[[/images/multistage_rosetta_scripts/ClusterRuntime.png]]

Using the fitted data, we can predict:

| Number of elements | Seconds    | Minutes | Hours  | Days  | Years |
|:------------------:|:----------:|:-------:|:------:|:-----:|:-----:|
| 10                 | 0.00005    |         |        |       |       |
| 100                | 0.005      |         |        |       |       |
| 1000               | 0.5        |         |        |       |       |
| 10,000             | 50         |    0.8  |        |       |	     |
| 100,000            | 5000       |    83.3 |  1.4   | 0.1   |	     |
| 1,000,000          | 500,000    | 8333.3  | 138.9  | 5.8   |	     |
| 10,000,000         | 50,000,000 | 833,333 | 13,889 | 578.7 | 1.6   |

##Memory Usage

[[/images/multistage_rosetta_scripts/ClusterMemoryUsage.png]]

Using the fitted data, we can predict:

| Number of elements | KB    | MB    | GB    |
|:------------------:|:-----:|:-----:|:-----:|
| 10 	    	     | 74757 | 75    | 0.075 |
| 100		     | 74973 | 75    | 0.075 |
| 1000		     | 78824 | 78.8  | 0.079 |
| 10,000	     |       | 286.6 | 0.29  |
| 100,000	     |	     | 19294 | 19.3  |
| 1,000,000	     |	     | 	     | 1902  |
