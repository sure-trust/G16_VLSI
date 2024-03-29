module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       
    output motor        
);
    assign ringer=(ring==1 & vibrate_mode==0)?1'b1:1'b0;
    assign motor=(vibrate_mode==1 & ring==1)?1'b1:1'b0;

endmodule
