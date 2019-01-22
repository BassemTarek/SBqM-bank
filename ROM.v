// clk1 enter - clk2 out 
/*
  bassem tarek mahrous 
  06 FEB 2018
  ROM
  ----------------------
  shrief 
  07 FEB 2018
  TIMER  
*/
module ROM (clk1,in1,out1,rst1,Wtime,Tcount);
input in1 ,out1, rst1 , clk1 ;
input[1:0] Tcount;
wire [2:0] Pcount;
output reg [4:0] Wtime;
reg [4:0] index ; 
//----------------------------  
parameter Wtime10 = 5'b00000 ;
parameter Wtime11 = 5'b00011 ;
parameter Wtime12 = 5'b00110 ;
parameter Wtime13 = 5'b01001 ;
parameter Wtime14 = 5'b01100 ;
parameter Wtime15 = 5'b01111 ;
parameter Wtime16 = 5'b10010 ;
parameter Wtime17 = 5'b10101 ;
//----------------------------
parameter Wtime20 = 5'b00000 ;
parameter Wtime21 = 5'b00011 ;
parameter Wtime22 = 5'b00100 ;
parameter Wtime23 = 5'b00110 ;
parameter Wtime24 = 5'b00111 ;
parameter Wtime25 = 5'b01001 ;
parameter Wtime26 = 5'b01010 ;
parameter Wtime27 = 5'b01100 ;
//----------------------------
parameter Wtime30 = 5'b00000 ;
parameter Wtime31 = 5'b00011 ;
parameter Wtime32 = 5'b00100 ;
parameter Wtime33 = 5'b00101 ;
parameter Wtime34 = 5'b00110 ;
parameter Wtime35 = 5'b00111 ;
parameter Wtime36 = 5'b01000 ;
parameter Wtime37 = 5'b01001 ;
//reg startbit ;
//reg endbit ;
/*
wire [119:0] data  = { 
                        Wtime10,Wtime11,Wtime12,Wtime13,Wtime14,Wtime15,Wtime16,Wtime17,
                        Wtime20,Wtime21,Wtime22,Wtime23,Wtime24,Wtime25,Wtime26,Wtime27,
                        Wtime30,Wtime31,Wtime32,Wtime33,Wtime34,Wtime35,Wtime36,Wtime37   }; 
// (8*3 number of cases ) * 5 bit of Wtime if bit memory
*/ 
reg [4:0] data  [23:0] ;// (8*3 number of cases )  if byte memory
/*assign data = { 
         Wtime10,Wtime11,Wtime12,Wtime13,Wtime14,Wtime15,Wtime16,Wtime17,
         Wtime20,Wtime21,Wtime22,Wtime23,Wtime24,Wtime25,Wtime26,Wtime27,
         Wtime30,Wtime31,Wtime32,Wtime33,Wtime34,Wtime35,Wtime36,Wtime37    } ;
*/
initial 
begin 
         data [0] <=  Wtime10 ; 
         data [1] <=  Wtime11 ;
         data [2] <=  Wtime12 ; 
         data [3] <=  Wtime13 ;
         data [4] <=  Wtime14 ; 
         data [5] <=  Wtime15 ; 
         data [6] <=  Wtime16 ;
         data [7] <=  Wtime17 ; 
         data [8] <=  Wtime20 ;
         data [9] <=  Wtime21 ;     
         data [10] <=  Wtime22 ;
         data [11] <=  Wtime23 ; 
         data [12] <=  Wtime24 ; 
         data [13] <=  Wtime25 ;
         data [14] <=  Wtime26 ;
         data [15] <=  Wtime27 ;
         data [16] <=  Wtime30 ;
         data [17] <=  Wtime31 ;
         data [18] <=  Wtime32 ;
         data [19] <=  Wtime33 ;
         data [20] <=  Wtime34 ;
         data [21] <=  Wtime35 ;
         data [22] <=  Wtime36 ;
         data [23] <=  Wtime37 ;
end 
N_Up_Down_Counter Pcount1(Pcount,in1,out1,rst1,clk1);
always @(posedge clk1)
begin
 index = {( Tcount - 2'b01 ) , Pcount };
 Wtime = data [index] ;
/*
startbit = index + ( index * 4 ) ;
endbit = index + ( ( index + 1 ) * 4 ) ; 
Wtime = data [endbit:startbit]  ;
if bit memory
*/ 
end
endmodule