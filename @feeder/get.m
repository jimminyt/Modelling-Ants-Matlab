function val=get(c,prop_name)

%standard function to allow extraction of memory parameters from feeder object

switch prop_name

case 'age'
   val=c.age;
case 'food'
   val=c.food;
case 'pos'
    val=c.pos;
case 'speed'
     val=c.speed;
otherwise 
   error('invalid field name')
end
