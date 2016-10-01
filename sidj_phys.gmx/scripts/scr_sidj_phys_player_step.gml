///scr_sidj_phys_player_step()

phy_direction = point_direction( 0, 0, phy_speed_x, phy_speed_y );




//  INPUT
var lr = keyboard_check( vk_right ) - keyboard_check( vk_left );
var ud = keyboard_check( vk_down ) - keyboard_check( vk_up );
var jump = keyboard_check_pressed( ord( "X" ) );

if ( lr == 1 ) phys_player_x_scale = 1 else if ( lr == -1 ) phys_player_x_scale = -1;




//  COLLISIONS
if ( phys_player_collision_normal != col_none ) {
    
    //Work out if the platform is below the player
    var flat = ( ( phys_player_collision_normal > 70 ) and ( phys_player_collision_normal < 110 ) );
    
    if ( abs( angle_difference( phys_player_normal, phys_player_collision_normal ) ) < 50 ) or ( flat ) {
        
        if ( !scr_sidj_phys_player_state_climb( phys_player_state ) ) phys_player_state = enum_sidj_phys_player.on_ground;
        
        phys_player_normal = phys_player_collision_normal;
        
        alarm[phys_player_stand_alarm] = phys_player_stand_steps;
        alarm[phys_player_on_ground_alarm] = phys_player_on_ground_steps;
        
        //Conform to the slope angle
        if ( phy_speed > 1 ) or ( flat ) {
            var target_dir = phys_player_collision_normal;  //- 0.6 * angle_difference( phys_player_collision_normal, 90 );
            phys_player_angle += angle_difference(target_dir,phys_player_angle)*0.25; //lerp(phys_player_angle,target_dir,0.125); //+= angle_difference( target_dir, phys_player_angle ) * 0.2;
        }
        
    } else {
        
        //Pushing into wall
        var ddir = angle_difference( phys_player_collision_normal, 90 );
        phys_player_wallslide_direction = sign( ddir );
        
        if ( abs( ddir ) > 85 ) and ( abs( ddir ) < 95 ) and ( phys_player_wallslide_direction == lr ) {
            phys_player_state = enum_sidj_phys_player.wall_slide;
            phy_speed_x = 0;
            //alarm[phys_player_wall_jump_alarm] = phys_player_wall_jump_steps;
        }
        
    }
    
}

//If there's no collision, reset the collision normal
if ( !physics_test_overlap( x, y, phy_rotation, obj_sidj_phys_par_solid ) ) phys_player_collision_normal = col_none;

//Anti-gravity floating
if ( place_meeting( x, y, obj_sidj_phys_antigrav ) ) {
    physics_apply_force( x, y, 0, -250 );
    physics_apply_impulse( x, y, 0, phys_player_float_impulse * ud );
}
//  STATE LOGIC
switch( phys_player_state ) {
    
    case enum_sidj_phys_player.on_ground:
        
        if ( lr != 0 ) {
            
            phys_player_move_direction = phys_player_normal - lr * phys_player_run_angle;
            if ( abs( angle_difference( phys_player_move_direction, phy_direction ) ) > 120 ) var multi = phys_player_run_change_dir_modifier else var multi = 1;
            
            var vx = lengthdir_x( phys_player_run_impulse_x * multi, phys_player_move_direction );
            var vy = lengthdir_y( phys_player_run_impulse_y * multi, phys_player_move_direction );
            physics_apply_impulse( x, y, vx, vy );
            
        }
            
        if ( alarm[phys_player_on_ground_alarm] <= 0 ) phys_player_state = enum_sidj_phys_player.freefall;
        
        if ( jump ) {
            var vx = lengthdir_x( phys_player_jump_impulse_x, phys_player_normal );
            var vy = lengthdir_y( phys_player_jump_impulse_y, phys_player_normal );
            physics_apply_impulse( x, y, vx, vy );
        }
        
    break;
    
    case enum_sidj_phys_player.freefall:
        
        if ( alarm[phys_player_stand_alarm] <= 0 ) {
            phys_player_angle += clamp( angle_difference( 90, phys_player_angle ), -phys_player_stand_speed, phys_player_stand_speed );
        }
        
        if ( jump ) and ( alarm[phys_player_wallslide_alarm] > 0 ) {
            alarm[phys_player_wallslide_alarm] = 0;
            physics_apply_impulse( x, y, lr * phys_player_wallslide_impulse_x, -phys_player_wallslide_impulse_y );
        }
        
        physics_apply_impulse( x, y, phys_player_float_impulse * lr, 0 );
        
    break;
    
    case enum_sidj_phys_player.wall_slide:
        
        physics_apply_force( x, y, 0, -210 );
        
        if ( lr != phys_player_wallslide_direction ) {
            physics_apply_impulse( x, y, phys_player_float_impulse * lr, 0 );
            phys_player_state = enum_sidj_phys_player.freefall;
            alarm[phys_player_wallslide_alarm] = phys_player_wallslide_steps;
        }
        
    break;
    
    case enum_sidj_phys_player.on_ladder:
        
        phy_speed_y = 0;
        phy_position_x = lerp( phy_position_x, phys_player_ladder_parent.x, 0.6 );
        phy_position_y = clamp( phy_position_y + ud, phys_player_ladder_parent.top, phys_player_ladder_parent.bottom );
        
        if ( jump ) {
            var dir = 90 - lr * phys_player_rope_jump_angle;
            var vx = lengthdir_x( phys_player_jump_impulse_x, dir );
            var vy = lengthdir_y( phys_player_jump_impulse_y, dir );
            physics_apply_impulse( x, y, vx, vy );
            
            phys_player_state = enum_sidj_phys_player.freefall;
            alarm[phys_player_rope_release_alarm] = phys_player_rope_release_steps;
        }
        
    break;
    
    case enum_sidj_phys_player.on_rope:
        
        physics_apply_impulse( x, y, phys_player_rope_impulse * lr, 0 );
        phys_player_rope_t += ud * phys_player_rope_climb_speed;
        
        if ( phys_player_rope_t > 1 ) {
            if ( phys_player_rope_segment < phys_player_rope_parent.size-1 ) {
                phys_player_rope_t--;
                phys_player_rope_segment++;
                phys_player_rope_instance = phys_player_rope_parent.rope[phys_player_rope_segment];
            } else {
                phys_player_rope_t = 1;
            }
        } else if ( phys_player_rope_t < 0 ) {
            if ( phys_player_rope_segment > 2 ) {
                phys_player_rope_t++;
                phys_player_rope_segment--;
                phys_player_rope_instance = phys_player_rope_parent.rope[phys_player_rope_segment];
            } else {
                phys_player_rope_t = 0;
            }
        }
        
        if ( ud != 0 ) {
            
            physics_joint_delete( phys_player_rope_joint );
            phys_player_rope_joint = noone;
            phys_player_rope_joint = physics_joint_rope_create( id, phys_player_rope_instance, x, y, phys_player_rope_instance.x, phys_player_rope_instance.y + ( phys_player_rope_t - 0.5 ) * 8, 4, false );
            
        }
        
        if ( jump ) {
            physics_joint_delete( phys_player_rope_joint );
            phys_player_rope_joint = noone;
            
            var dir = 90 - lr * phys_player_rope_jump_angle;
            var vx = lengthdir_x( phys_player_rope_jump_impulse_x, dir );
            var vy = lengthdir_y( phys_player_rope_jump_impulse_y, dir );
            physics_apply_impulse( x, y, vx, vy );
            
            phys_player_state = enum_sidj_phys_player.freefall;
            alarm[phys_player_rope_release_alarm] = phys_player_rope_release_steps;
        }
        
    break;
    
}

//  SPEED LIMITING
/*
phy_speed_x = clamp(phy_speed_x,-phys_player_run_max_x,phys_player_run_max_x);
phy_speed_y = clamp(phy_speed_y,-phys_player_run_max_y,phys_player_run_max_y);
*/







//  SET SPRITE
switch( phys_player_state ) {
    
    case enum_sidj_phys_player.on_ground:
        
        if ( lr == 0 ) {
            
            if ( abs( phy_speed ) > 0.2 ) {
                
                sprite_index = spr_sprite_player_fall;
                
            } else if ( image_index > 1 ) and ( sprite_index != spr_sprite_player_idle ) {
                
                sprite_index = spr_sprite_player_walk;
                image_index = ( image_index + 0.2 ) mod image_number;
                
            } else {
                
                sprite_index = spr_sprite_player_idle;
                image_index += 0.1;
                
            }
            
        } else {
            
            if ( alarm[phys_player_on_ground_alarm] > phys_player_on_ground_steps - 2 ) {
                sprite_index = spr_sprite_player_walk;
                image_index = ( image_index + clamp( abs( phy_speed_x ) / 20, 0.2, 1 ) * 1.1 ) mod image_number;
            }
        
        }
        
    break;
    
    default:
        
        if ( phy_speed_y > 0.1 ) {
            sprite_index = spr_sprite_player_fall;
        } else if ( phy_speed_y < 0.1 ) {
            sprite_index = spr_sprite_player_rise;
        }
        
    break;
    
}
