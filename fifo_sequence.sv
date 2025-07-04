package fifo_sequence_pkg;

  import uvm_pkg::*;
  import fifo_seq_item_pkg::*;
  import shared_pkg::*;
  `include "uvm_macros.svh"

  class write_only_sequence extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(write_only_sequence)
    fifo_seq_item item;

    function new(string name = "write_only_sequence");
      super.new(name);
    endfunction

    task body();
      repeat (10000) begin
        item = fifo_seq_item::type_id::create("item");
        start_item(item);
        assert(item.randomize());
        item.wr_en=1;
        item.rd_en=0;
        finish_item(item);
      end
    endtask
  endclass

  class read_only_sequence extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(read_only_sequence)
    fifo_seq_item item;

    function new(string name = "read_only_sequence");
      super.new(name);
    endfunction

    task body();
      repeat (10000) begin
        item = fifo_seq_item::type_id::create("item");
        start_item(item);
        assert(item.randomize());
        item.wr_en=0;
        item.rd_en=1;
        finish_item(item);
      end
    endtask
  endclass

  class write_read_sequence extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(write_read_sequence)
    fifo_seq_item item;

    function new(string name = "write_read_sequence");
      super.new(name);
    endfunction

    task body();
      repeat (5000) begin
        item = fifo_seq_item::type_id::create("item");
        start_item(item);
        assert(item.randomize());
        item.wr_en=1;
        item.rd_en=1;
        finish_item(item);
      end
      repeat(10000)begin
        start_item(item);
        assert(item.randomize());
        finish_item(item);
        end
    endtask
  endclass

  class reset_sequence extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(reset_sequence)
    fifo_seq_item item;

    function new(string name = "reset_sequence");
      super.new(name);
    endfunction

    task body();
      item = fifo_seq_item::type_id::create("item");
      start_item(item);
      item.data_in=0;
      item.rst_n = 0;
      item.wr_en = 0;
      item.rd_en = 0;
      finish_item(item);
    endtask
  endclass

endpackage
