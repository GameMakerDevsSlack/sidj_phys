///scr_sidj_phys_cape(x,y, length);

var cape = instance_create(x,y,obj_sidj_phys_cape_segment);
var fxt = scr_sidj_phys_define_box(2,2,0,0.1,0.1,0.1,0.1);

physics_fixture_bind(fxt,cape);

fxt = scr_sidj_phys_define_box(2,2,1,0.1,0.1,0.1,0.1);
var o, prev = cape;
for (var i=0;i<argument2;i++)
{
    o = instance_create(argument0,argument1+i*4,obj_sidj_phys_cape_segment);
    physics_fixture_bind(fxt,o);
    if i != 0
    {
        physics_joint_weld_create( o, prev, o.x, o.y, 0, 10, 12, true);
        //physics_joint_distance_create( o, prev, o.x, o.y, prev.x, prev.y, false );
        //physics_joint_rope_create( o, prev, o.x, o.y, prev.x, prev.y, 6, false );
        //physics_joint_revolute_create( o, prev, o.x, prev.y-8, 0, 360, true, 0, 0, false, false );
    }
    if i == 0
    {
        physics_joint_revolute_create( o, prev, o.x, prev.y-8, 0, 360, true, 0, 0, false, false );
    }
    o.parent = prev;
    prev = o;
}

return cape;
