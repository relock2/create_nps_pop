# A Tool to Create a Simulated Population with a Given Net Promoter Score (NPS)

While performing analysis on the Net Promoter Score (NPS), it can be useful to generate simulated data with desired properties. The nature of the NPS means that the same score can be produced by many different combinations of promoters, detractors, and passives.

For example, a Net Promoter Score of +0.0 can be produced by 10 respondents in 6 different ways. Assume that below promoters are coded as 1, passives as 0, and detractors as -1. Each of the following combinations produces an NPS of 0:

|    NPS    | Type | Type | Type | Type | Type | Type | Type | Type | Type | Type  |
|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|
|   +0.0    |  0      | 0       | 0       | 0       | 0       | 0       |  0      | 0       | 0       | 0        |
|   +0.0    |  1      | 0       | 0       | 0       | 0       | 0       |  0      | 0       | 0       | -1       |
|   +0.0    |  1      | 1       | 0       | 0       | 0       | 0       |  0      | 0       | -1      | -1       |
|   +0.0    |  1      | 1       | 1       | 0       | 0       | 0       |  0      | -1      | -1      | -1       |
|   +0.0    |  1      | 1       | 1       | 1       | 0       | 0       | -1      | -1      | -1      | -1       |
|   +0.0    |  1      | 1       | 1       | 1       | 1       | -1      | -1      | -1      | -1      | -1       |


![image](https://www.pisano.com/hs-fs/hubfs/Imported%20sitepage%20images/621383dd8d43be1d12084a7f_2nps_blog_2.png?width=2400&name=621383dd8d43be1d12084a7f_2nps_blog_2.png)

Because the NPS is calculated at the percentage of promoters minus the percentage of detractors, the number of possible combinations increases as a function of sample size and how close the score is to zero. In contrast to the 6 combinations above, there is only one way to have a Net Promoter Score of +100 or -100, no matter the sample size:

__+100: All Promoters__

|    NPS    | Type | Type | Type | Type | Type | Type | Type | Type | Type | Type  |
|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|
|   +0.0    |  1      | 1       | 1       | 1       | 1       | 1       |  1      | 1       | 1       | 1        |


__-100: All Detractors__

|    NPS    | Type | Type | Type | Type | Type | Type | Type | Type | Type | Type  |
|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|
|   +0.0    |  -1      | -1       | -1       | -1       | -1       | -1       |  -1      | -1       | -1       | -1        |

This function takes two parameters:

* population: The desired population size
* nps: The desired Net Promoter Score on a scale of -1 to 1

It then returns a randomly-generated vector like those above. So if the user inputs create_nps_pop(population = 10, nps = 0), then it will return one of the 6 possible combinations shown above, e.g.:

|    NPS    | Type | Type | Type | Type | Type | Type | Type | Type | Type | Type  |
|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|
|   +0.0    |  1      | 0       | 0       | 0       | 0       | 0       |  0      | 0       | 0       | -1       |

It will also shuffle the results so they appear in a random order. In this way, it is possible to generate any permutation of the population, not just combinations.


Because not every NPS is possible for every population (e.g. nps = 0.75 and population = 10), the function will return an NPS as close as possible to the one created by the user.

```
create_nps_pop(population = 10, nps = 0.75)

############### Simulated Net Promoter Population ############### 
## 
## Submitted NPS: 0.75 
## Submitted population: 10 
## 
## Population size: 10 
## Net Promoter Score: 0.7 
## 
## Number of promoters: 7 
## Number of passives: 3 
## Number of detractors: 0 

```
