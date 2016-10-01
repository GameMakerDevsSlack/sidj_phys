///scr_sidj_phys_bind( fixture, [id] )

if ( argument_count < 1 ) or ( argument_count > 2 ) {
    cout( "scr_sidj_phys_bind", "error", "wrong number of arguments", argument_count );
    exit;
}

var fxt = scr_sidj_phys_get_fixture( argument[0] );
if ( argument_count == 1 ) idn = id else idn = argument[1];

idn.phys_fixture = physics_fixture_bind( fxt, idn );

/*with( idn ) {
    phy_position_x = x;
    phy_position_y = y;
}*/

cout( "scr_sidj_phys_bind", "id", idn, "fixture", fxt, idn.phys_fixture, "xy", x, y, "phys_xy", phy_position_x, phy_position_y );
