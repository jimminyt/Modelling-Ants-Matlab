function create_params

%set up breeding, migration and starvation threshold parameters. These are all
%completely made up!

%PARAM - structure containing values of all parameters governing agent behaviour
%for the current simulation

global PARAM

    PARAM.FE_SPD=0;                %speed of movement - units per itn (feeder)
    PARAM.FO_SPD=3;                %speed of movement - units per itn (forager)
    PARAM.QU_SPD=0;                %speed of movement - units per itn (queen)
    PARAM.LA_SPD=0;                %speed of movement - units per itn (larva)

    PARAM.FE_MINFOOD=0;            %minimum food threshold before agent dies (feeder)
    PARAM.FO_MINFOOD=0;            %minimum food threshold before agent dies (forager)
    PARAM.QU_MINFOOD=0;            %minimum food threshold before agent dies (queen)
    PARAM.LA_MINFOOD=0;            %minimum food threshold before agent dies (larva)
    PARAM.FE_MAXEATFOOD=40;            %minimum food threshold before agent dies (feeder)
    PARAM.FO_MAXEATFOOD=80;            %minimum food threshold before agent dies (forager)
    PARAM.QU_MAXEATFOOD=250;            %minimum food threshold before agent dies (queen)
    PARAM.LA_MAXEATFOOD=24;            %minimum food threshold before agent dies (larva)

    PARAM.FE_MAXAGE=360;            %maximum age allowed (feeder)
    PARAM.FO_MAXAGE=720;            %maximum age allowed (forager)
    PARAM.QU_MAXAGE=2160;            %maximum age allowed (queen)
    PARAM.LA_MAXAGE=24;            %maximum age allowed (larva)

    PARAM.QU_BRDFREQ=1;           %breeding frequency - iterations

    PARAM.QU_FOODBRD=1;            %minimum food threshold for breeding
    PARAM.LA_FOODBRD=12;           %minimum food threshold for breeding (i.e. transforming)

    PARAM.FE_CHANCE=0.5;                    %chance for a larva to transform into a feeder
    PARAM.FO_CHANCE=1-PARAM.FE_CHANCE;      %chance for a larva to transform into a forager
    %the second chance param may never actually be used since there's only 2 possibilities
    %therefore only 1-X will be used in the larva.transform function 

    PARAM.FO_MAXFOOD=60;
