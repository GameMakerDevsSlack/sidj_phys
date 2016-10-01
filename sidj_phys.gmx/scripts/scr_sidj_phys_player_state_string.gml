///scr_sidj_phys_player_state_string( state )

switch argument0 {
    case enum_sidj_phys_player.freefall:   return "freefall";   break;
    case enum_sidj_phys_player.on_ground:  return "on_ground";  break;
    case enum_sidj_phys_player.on_rope:    return "on_rope";    break;
    case enum_sidj_phys_player.on_ladder:  return "on_ladder";  break;
    case enum_sidj_phys_player.wall_slide: return "wall_slide"; break;
}
