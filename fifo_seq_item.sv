package fifo_seq_item_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import shared_pkg::*;
class fifo_seq_item extends uvm_sequence_item;
    `uvm_object_utils(fifo_seq_item)
    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;
    rand logic [FIFO_WIDTH-1:0] data_in;
    rand bit wr_en, rd_en;
    rand bit rst_n;
    logic [FIFO_WIDTH-1:0] data_out;
    bit wr_ack, overflow;
    bit full, empty, almostfull, almostempty, underflow;
    int RD_EN_ON_DIST=3;
    int WR_EN_ON_DIST=7; 
    function new(string name="fifo_seq_item");
        super.new(name);        
    endfunction 
    function string convert2string();
        return $sformatf("%s wr_en=%0b,rd_en=%0b,rst_n=%0b,data_in=%0b,full=%0b,empty=%0b,almostfull=%0b,almostempty=%0b,underflow=%0b,overflow=%0b,wr_ack=%0b,data_out=%0d",super.convert2string(),
                            wr_en,rd_en,rst_n,data_in,full,empty,almostfull,almostempty,underflow,overflow,wr_ack,data_out);
    endfunction

    function string convert2string_stimulus();
        return $sformatf("%s wr_en=%0b,rd_en=%0b,rst_n=%0b,data_in=%0b",super.convert2string(),wr_en,rd_en,rst_n,data_in);
    endfunction
   
   constraint c_fifo{
        //constraint_1
        rst_n dist {0:=1,1:=9};
        //constraint_2
        wr_en dist{1:=WR_EN_ON_DIST,0:=10-WR_EN_ON_DIST};
        //constraint_3
        rd_en dist{1:=RD_EN_ON_DIST,0:=10-RD_EN_ON_DIST};
    }
endclass 
    
endpackage