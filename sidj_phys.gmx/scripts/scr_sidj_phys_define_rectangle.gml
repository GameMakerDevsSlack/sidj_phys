///scr_sidj_phys_define_rectangle( x1, y1, x2, y2, density, restitution, linear damping, angular damping, friction )
var fxt = physics_fixture_create();

physics_fixture_set_polygon_shape(fxt);
physics_fixture_add_point(fxt,argument0,argument1);
physics_fixture_add_point(fxt,argument2,argument1);
physics_fixture_add_point(fxt,argument2,argument3);
physics_fixture_add_point(fxt,argument0,argument3);

physics_fixture_set_density(fxt,argument4);
physics_fixture_set_restitution(fxt,argument5);
physics_fixture_set_linear_damping(fxt,argument6);
physics_fixture_set_angular_damping(fxt,argument7);
physics_fixture_set_friction(fxt,argument8);

return fxt;
