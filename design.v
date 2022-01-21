module lock_FSM (
  
  input wire data_in,
  input wire clk,
  input wire rst_n,
  output reg unlock);
  
  reg [2:0] pstate,nstate;
  parameter [2:0] idle = 3'b000,
                  state1 = 3'b001,
                  state10 = 3'b010,
                  state101 =3'b011,
                  state1011 = 3'b100;
  
  always@ (*)
    begin: NSOL
      begin: NSL
        case (pstate)
          
          idle: if(data_in) nstate= state1;
            else nstate= idle;
          
          state1: if(data_in) nstate= state1;
            else nstate= state10;
              
          state10: if(data_in) nstate= state101;
          else nstate= idle;
          
          state101: if(data_in) nstate= state1011;
          else nstate= idle;
          
          state1011: if(data_in) nstate= state1;
          else nstate= idle;
          
          default: nstate= idle;
          
        endcase
      end                                                                                                                                                                                                    
      begin: OL
        
        case(pstate)
          idle: unlock= 0;
          state1: unlock= 0;
          state10: unlock= 0;
          state101: unlock= 0;
          state1011: unlock= 1;
          
          default: unlock= 0;
        endcase
      end
    end
  
  always@(posedge clk, negedge rst_n)
    begin: PSR
      if(!rst_n)
        pstate= idle;
      
      else
        
        pstate= nstate;
      
      end
endmodule
      
      
          
              
              
            
             
      