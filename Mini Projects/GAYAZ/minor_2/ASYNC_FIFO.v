module ASYNC_FIFO#(parameter S = 8)(
  input wrclk,
  input wrrst,
  input wren,
  input wrdata,
  input rdclk,
  input rdrst,
  input rden,
  output [7:0]rddata,
  output [7:0]full,
  output [7:0]empty
);
wire wrenDerived;
wire [S-1:0] wrptr;
wire [S-1:0] rdptrG2B;
wire [S-1:0] rdptrDualFlopSyncOut;
wire [S-1:0] wrptrB2G;
wire [S-1:0] rdptr;
wire [S-1:0] wrptrG2B;
wire [S-1:0] wrptrDualFlopSyncOut;
wire [S-1:0] rdptrB2G;

fifoMemory uutFifoMemory (
  .wrclk(wrclk),
  .rdclk(rdclk),
  .wrptr(wrptr),
  .rdptr(rdptr),
  .wren(wrenDerived),
  .wrdata(wrdata),
  .rddata(rddata)
    );
    
and (wrenDerived, wren, ~full);
	
	writeUnit uutWritUnit(
      .wrclk(wrclk),
      .wren(wren),
      .wrrst(wrrst),
      .rdptr(rdptrG2B),
      .wrptr(wrptr),
      .full(full)
    );

readUnit uutReadUnit(
  .rdclk(rdclk),
  .rden(rden),
  .rdrst(rdrst),
  .wrptr(wrptrG2B),
  .rdptr(rdptr),
  .empty(empty)      
    );

binaryGray uutBinaryGrayWrite (
  .binaryIn(wrptr),
  .grayOut(wrptrB2G)
    );

dualFlopSynchronizer uutDualFlopSynchronizerWrite(
  .dataIn(wrptrB2G),
  .dataOut(wrptDualFlopSyncOut),
  .clk(rdclk),
  .rst(rdrst)
    );

grayBinary uutGrayBinaryWrite(
  .grayIn(wrptDualFlopSyncOut),
  .binaryOut(wrptrG2B)
    );
    
binaryGray uutBinaryGrayRead (
   .binaryIn(rdptr),
   .grayOut(rdptrB2G)
    );

dualFlopSynchronizer uutDualFlopSynchronizerRead(
  .dataIn(rdptrB2G),
  .dataOut(rdptDualFlopSyncOut),
  .clk(wrclk),
  .rst(wrrst)
    );
    
grayBinary uutGrayBinaryRead(
  .grayIn(rdptDualFlopSyncOut),
  .binaryOut(rdptrG2B)
    );  
  
endmodule  
  