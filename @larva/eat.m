function [agt,eaten]=eat(agt,cn)

cfood = agt.food;

agt.food = cfood-1;
eaten = 1;