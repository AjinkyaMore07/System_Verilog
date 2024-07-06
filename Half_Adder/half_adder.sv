interface adder_if();
    logic a, b;
    logic sum, carry;
endinterface

class transaction;
    rand bit a, b;
    bit sum, carry;
    
    function transaction copy();
        copy = new();
        copy.a = this.a;
        copy.b = this.b;
        copy.sum = this.sum;
        copy.carry = this.carry;
    endfunction
    
    function void display(input string in);
      $display(" Time = %0t tag = %s , a = %0b , b= %0b , sum = %0b , carry = %0b", $time ,in, a, b, sum, carry);
    endfunction
endclass

class generator;
    transaction tr;
    mailbox #(transaction) gen2drv;
    mailbox #(transaction) gen2scb;
    event nextrr;
    event done;
    
    int count;
    
    function new(mailbox #(transaction) gen2drv, mailbox #(transaction) gen2scb);
        this.gen2drv = gen2drv;
        this.gen2scb = gen2scb;
        tr = new();
    endfunction
    
    task run();
        repeat (count) begin  

          if (tr.randomize())
                $display("successful randomization");
          else
                $display("failed randomization");
          gen2drv.put(tr.copy());
          tr.display("[Gen]");
          #10;
        end
        $display("******************************************************");
        ->done;
    endtask
endclass

class driver;
    transaction tr;
    mailbox #(transaction) gen2drv;
    event nextrr;
    virtual adder_if aif;
    
    function new(mailbox #(transaction) gen2drv, virtual adder_if aif);
        this.gen2drv = gen2drv;
        this.aif = aif;
    endfunction
    
    task run();
        forever begin
            tr = new();
            gen2drv.get(tr);
            aif.a <= tr.a;
            aif.b <= tr.b;
          	#5;
            tr.display("[drv]");
            $display("Time = %0t aif.a = %0b , aif.b = %0b aif.sum = %0b , aif.carry = %0b",$time , aif.a,aif.b  ,aif.sum,aif.carry);

        end
    endtask
endclass

module tb;
    adder_if aif();
    
    half_adder dut(.a(aif.a), .b(aif.b), .sum(aif.sum), .carry(aif.carry));
    
    generator gen;
    driver drv;
    event done;
    mailbox #(transaction) gen2drv;
    mailbox #(transaction) gen2scb;
    
    initial begin
        gen2drv = new();
        gen2scb = new();
        gen = new(gen2drv, gen2scb);
        drv = new(gen2drv, aif);
        done = gen.done;
        gen.count = 25;
    end
    
    initial begin
        fork
            gen.run();
            drv.run();
        join_none
        @(done);
        $finish;
    end
    
    initial begin
        $dumpfile("file.vcd");
        $dumpvars;
    end
endmodule
