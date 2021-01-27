function c=set(c,prop_name,val)

%standard function to allow insertion of memory parameters from forager object

switch prop_name

case 'food'
   c.food=val;
case 'pos'
    c.pos=val;
case 'age'
   c.age=val;
case 'speed'
   c.speed=val;
otherwise 
   error('invalid field name')
end
