# agent based modelling - ant colony

Made by James Taylor, Ammar Shehata, Matt Prestwich.

Agent based modelling representation of an ant colony in MatLab.

Uploaded from my university github.

Completed April 2020.

## recommendations
the ecolab function accept parameters as follows:
ecolab(
    size of one side of the map - actual size will be size\*size,
    initial number of feeder ants,
    initial number of forager ants,
    initial number of queens - also the number of nests,
    initial number of larvae,
    number of steps or iterations - 1 iteration == 1 hour,
    (optional) fast mode enabling to end the simulation early if the queens are dead,
    (optional) save output images every \~3 iterations
)

the fast mode option default state is true
the output images option default is false - turning it to true is not recommended for slower machines

to avoid potential errors, make sure you use agent numbers that are divisible by 4.
more generally, the number of any particular type of agents should be wholly divisible by the number of queens or nests.

for example `ecolab(23,12,36,2,12,720)` will run a simulation with a 23\*23 map that will have 2 queens and 2 nests.
the number of agents will be divided equally between the nests so each will have 6 feeders, 18 foragers, 1 queen, and 6 larvae.
this simulation will also run for 720 iterations which is equivalent to 1 month.

## modifying the code
if you would like to run additional experiments you can modify certain parts of the code as outlined below.

to adjust the food or pheromone distributions you can edit `create_environment.m`.
for parameters that are part of the agents themselves (including the chance of changing from a larvae to a feeder or forager) edit `create_params.m`.

## model output
there are 3 figures output by the model:
- the one with the purple colors is the pheromone trail map
- the one with the red colors is the food distribution map
- the one with the graphs shows the statistics as the model is being run
