///scr_sidj_phys_player_state_climb( state )

switch argument0 {
    case enum_sidj_phys_player.freefall:   return false; break;
    case enum_sidj_phys_player.on_ground:  return false; break;
    case enum_sidj_phys_player.on_rope:    return true;  break;
    case enum_sidj_phys_player.on_ladder:  return true;  break;
    case enum_sidj_phys_player.wall_slide: return false; break;
}
