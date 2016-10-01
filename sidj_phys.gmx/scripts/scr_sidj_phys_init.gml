///scr_sidj_phys_init()

global.sidj_phys_controller = id;

physics_world_create( 0.1 );
physics_world_update_speed( 60 );
physics_world_update_iterations( 20 );
physics_world_gravity( 0, 60 );

cout( "scr_sidj_phys_init", global.sidj_phys_controller );
