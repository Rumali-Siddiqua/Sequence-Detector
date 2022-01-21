module lock_FSM_tb;
  reg data_in;
  reg clk= 0;
  reg rst_n;
  wire unlock;
  
  initial forever #5 clk= ~ clk;
  
  lock_FSM  DUT( .data_in (data_in), .clk(clk), .rst_n(rst_n), .unlock (unlock));
  
  initial 
    begin
      rst_n= 0;
      data_in= 0;
      @(negedge clk);
      rst_n= 1;
      @(negedge clk);
      data_in= 1;
      @(negedge clk);
      data_in= 0;
      @(negedge clk)
      data_in= 1;
      
      repeat(3)@(negedge clk);
      
      $finish;
    end
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0);
    
  end
endmodule
      
             
  