////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: UVM Example
// 
////////////////////////////////////////////////////////////////////////////////
package fifo_test_pkg;
import fifo_env_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_config_pkg::*;
import fifo_env_pkg::*;
import fifo_sequence_pkg::*;
class fifo_test extends uvm_test;
 `uvm_component_utils(fifo_test)
  fifo_env env;
  write_only_sequence wr_only;
  read_only_sequence rd_only;
  write_read_sequence wr_rd;
  reset_sequence rst_seq;
  fifo_config fifo_cfg;

  function new(string name="fifo_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = fifo_env::type_id::create("env",this);
    fifo_cfg = fifo_config::type_id::create("fifo_cfg",this);
    wr_rd = write_read_sequence::type_id::create("wr_rd",this); 
    rst_seq = reset_sequence::type_id::create("rst_seq",this);
    rd_only = read_only_sequence::type_id::create("rd_only",this);
    wr_only = write_only_sequence::type_id::create("wr_only",this);
    if(!uvm_config_db #(virtual fifo_if)::get(this,"","fifo_if",fifo_cfg.fifo_vif)) begin
      `uvm_fatal("build_phase", "test - unable to get the virtual interface of the fifo from the uvm config_db")
    end
    uvm_config_db #(fifo_config)::set(this,"*","CFG",fifo_cfg);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("run_phase", "reset asserted",UVM_LOW)
    rst_seq.start(env.agt.sqr);
    `uvm_info("run_phase", "reset deasserted",UVM_LOW)

    `uvm_info("run_phase", "stim gen started",UVM_LOW)
    wr_rd.start(env.agt.sqr);
    `uvm_info("run_phase", "stim gen ended",UVM_LOW)
    
    `uvm_info("run_phase", "stim gen started",UVM_LOW)
      wr_only.start(env.agt.sqr);
    `uvm_info("run_phase", "stim gen ended",UVM_LOW)

    `uvm_info("run_phase", "stim gen started",UVM_LOW)
      rd_only.start(env.agt.sqr);
    `uvm_info("run_phase", "stim gen ended",UVM_LOW)
    phase.drop_objection(this);
  endtask 
endclass
endpackage