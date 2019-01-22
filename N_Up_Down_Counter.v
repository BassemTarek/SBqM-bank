module N_Up_Down_Counter (Pcount,in,out,rst,clk);
  input in,out,rst,clk;
  output reg [2:0] Pcount;
  
  always@(posedge clk)
  
  begin //
    
    if (rst)
      begin
        Pcount = 3'b0;
      end
      
    else if (in)
      begin
        Pcount = Pcount + 1;
      end
  
    else 
      begin
        Pcount = Pcount;
      end
              
  end //
  
  always@(posedge clk)
  
  begin //
    
    if (rst)
      begin
        Pcount = 3'b0;
      end
      
    else if (out)
      begin
        Pcount = Pcount - 1;
      end
  
    else 
      begin
        Pcount = Pcount;
      end
              
  end //
  
  
endmodule
    

