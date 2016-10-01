///scr_sidj_phys_player_init()

enum enum_sidj_phys_player {
    freefall, on_ground, on_rope, on_ladder, wall_slide
}

fxt_player_feet = scr_sidj_phys_define_circle( 8, 2, 0, 0.5, 0.1, 1.2 );
physics_fixture_bind( fxt_player_feet, id );
phy_fixed_rotation = true;
phy_direction = 0;

phys_player_state = enum_sidj_phys_player.freefall;

phys_player_angle = 90;
phys_player_collision_normal = 90;
phys_player_normal = 90;
phys_player_move_direction = 270;

phys_player_stand_steps = 5;
phys_player_stand_speed = 3;

phys_player_run_angle = 100;
phys_player_run_impulse_x = 8;
phys_player_run_impulse_y = 8;
phys_player_run_force_x = 200;
phys_player_run_force_y = 200;
phys_player_run_max_x = 80;
phys_player_run_max_y = 80;
phys_player_run_change_dir_modifier = 2.9;
phys_player_on_ground_steps = 5;

phys_player_jump_impulse_x = 50;
phys_player_jump_impulse_y = 90;
phys_player_float_impulse = 1.7;

phys_player_wallslide_direction = 0;
phys_player_wallslide_steps = 7;
phys_player_wallslide_impulse_x = 60;
phys_player_wallslide_impulse_y = 70;

phys_player_rope_impulse = 1;
phys_player_rope_jump_angle = 50;
phys_player_rope_jump_impulse_x = 50;
phys_player_rope_jump_impulse_y = 50;
phys_player_rope_release_steps = 10;
phys_player_rope_climb_speed = 0.1;

phys_player_stand_alarm = 0;
phys_player_on_ground_alarm = 1;
phys_player_wallslide_alarm = 2;
phys_player_rope_release_alarm = 3;

phys_player_x_scale = 1;

phys_player_on_rope = false;
phys_player_rope_parent = noone;
phys_player_rope_segment = noone;
phys_player_rope_t = 0;
phys_player_rope_joint = noone;
phys_player_rope_rope_joint = noone;

phys_player_on_ladder = false;
phys_player_ladder_parent = noone;
phys_player_ladder_t = 0;
phys_player_ladder_climb_speed = 0.01;
