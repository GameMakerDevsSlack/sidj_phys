///scr_sidj_phys_define_circle( radius, density, restitution, linear damping, angular damping, friction )

var fxt = physics_fixture_create();

physics_fixture_set_circle_shape( fxt, argument0 );
physics_fixture_set_density( fxt, argument1 );
physics_fixture_set_restitution( fxt, argument2 );
physics_fixture_set_linear_damping( fxt, argument3 );
physics_fixture_set_angular_damping( fxt, argument4 );
physics_fixture_set_friction( fxt, argument5 );

return fxt;
