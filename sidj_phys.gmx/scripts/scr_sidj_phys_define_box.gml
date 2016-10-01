///scr_sidj_phys_define_box( half width, half height, density, restitution, linear damping, angular damping, friction )

var fxt = physics_fixture_create();

physics_fixture_set_box_shape( fxt, argument0, argument1 );
physics_fixture_set_density( fxt, argument2 );
physics_fixture_set_restitution( fxt, argument3 );
physics_fixture_set_linear_damping( fxt, argument4 );
physics_fixture_set_angular_damping( fxt, argument5 );
physics_fixture_set_friction( fxt, argument6 );

return fxt;
