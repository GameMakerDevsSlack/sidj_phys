///scr_sidj_phys_define_fixtures()

with( global.sidj_phys_controller ) {
    
    enum enum_sidj_phys_fixture {
        block, box
    }
    
    var fxt = scr_sidj_phys_define_box( 16, 16,   0, 0.2, 1, 1, 0.2 );
    cout( "scr_sidj_phys_define_fixtures", "block", fxt );
    sidj_phys_fixtures[ enum_sidj_phys_fixture.block ] = fxt;
    
    var fxt = scr_sidj_phys_define_box( 16, 16,   0.10, 0.3, 0.3, 1, 0.2 );
    cout( "scr_sidj_phys_define_fixtures", "box", fxt );
    sidj_phys_fixtures[ enum_sidj_phys_fixture.box ] = fxt;

}
