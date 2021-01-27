function [dirx,diry]=follow_strongest_pheromone(pheromone_grid, homenest)
%function [deltax,deltay]=follow_strongest_pheromone(pheromone_grid)


%
%THIS NEEDS RENAMING, CHANGED TO WORK NOT LOOK PRETTY
%
[xmaxval,xmax]=max(pheromone_grid);
[~,ymax]=max(xmaxval);
% disp([xmax(ymax),ymax])
% disp([xmax(ymax)-3,ymax-3])
% disp(pheromone_grid(xmax(ymax),ymax))
deltay=ymax-3;
deltax=xmax(ymax)-3;
ecatch = any(any(pheromone_grid(4:5,:)));
ncatch = any(any(pheromone_grid(:,4:5)));
wcatch = any(any(pheromone_grid(1:2,:)));
scatch = any(any(pheromone_grid(:,1:2)));

if deltay < 0% && all(size(pheromone_grid)>1)
    % move south
    diry=-1;
elseif deltay > 0% && all(size(pheromone_grid)>1)
    % move north
    diry=1;
else
    % move random-y OR opposite of the nest
    diry=rand;
end
if deltax < 0% && all(size(pheromone_grid)>1)
    dirx=-1;
elseif deltax > 0% && all(size(pheromone_grid)>1)
    % move west
    dirx=1;
else
    % move random-x OR opposite of the nest
    dirx=rand;
end

% SW homenest
if homenest==1
    if ncatch
        diry = 1;
    end
    if ecatch
        dirx = 1;
    end
end
% NW homenest
if homenest==2
    if scatch
        diry = -1;
    end
    if ecatch
        dirx = 1;
    end
end
% NE homenest
if homenest==3
    if scatch
        diry = -1;
    end
    if wcatch
        dirx = -1;
    end
end
% SE homenest
if homenest==4
    if ncatch
        diry = 1;
    end
    if wcatch
        dirx = -1;
    end
end
% disp([deltax,deltay])
% disp([dirx,diry])

