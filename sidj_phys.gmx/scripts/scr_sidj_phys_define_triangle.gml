///scr_sidj_phys_define_triangle( x1, y1, x2, y2, x3, y3, density, restitution, linear damping, angular damping, friction )

var fxt = physics_fixture_create();
physics_fixture_set_chain_shape( fxt, true );

physics_fixture_add_point( fxt, argument0, argument1 );
physics_fixture_add_point( fxt, argument2, argument3 );
physics_fixture_add_point( fxt, argument4, argument5 );

physics_fixture_set_density( fxt, argument6 );
physics_fixture_set_restitution( fxt, argument7 );
physics_fixture_set_linear_damping( fxt, argument8 );
physics_fixture_set_angular_damping( fxt, argument9 );
physics_fixture_set_friction( fxt, argument10 );

return fxt;
