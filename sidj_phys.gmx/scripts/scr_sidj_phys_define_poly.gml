///scr_sidj_phys_define_poly( point list, density, restitution, linear damping, angular damping, friction )
var fxt = physics_fixture_create();

physics_fixture_set_polygon_shape(fxt);

for (var i=0;i<ds_list_size(argument0)/2;i++)
{
    physics_fixture_add_point(fxt,argument0[| i],argument0[| i+1]);
}
ds_list_destroy(argument0);

physics_fixture_set_density( fxt, argument1 );
physics_fixture_set_restitution( fxt, argument2 );
physics_fixture_set_linear_damping( fxt, argument3 );
physics_fixture_set_angular_damping( fxt, argument4 );
physics_fixture_set_friction( fxt, argument5 );

return fxt;
