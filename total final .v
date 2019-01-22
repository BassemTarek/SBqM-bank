/* 
        06 FEB 2018 & 07 FEB 2018
        group 2
        mini project  
*/
//`timescale 10ns/1ns 
module SBqM_project_test ; // self testbench
reg in ,out , rst , clk ;
reg [1:0] Tcount;
wire [2:0] pcount ;
wire [4:0] Wtime;
wire empty , full , warnning ;
// ----------------------------
integer i=0,j=0;
wire warning_check ;
reg [2:0] pcount_comp;
reg [1:0] upstate_comp;
reg [1:0] dstate_comp;
SBqM_project test_1 (
.in(in),
.out(out),
.rst(rst),
.clk(clk),
.Tcount(Tcount),
.pcount(pcount),
.Wtime(Wtime),
.empty(empty),
.full(full),
.warnning(warnning) 
);
initial 
begin 
  clk = 1 ;
  rst = 1 ; 
  Tcount = 1;
  in =1 ; 
  out =1 ; 
end 

always 
#5 clk = ~ clk;

event reset ;
event done_reset ;
initial 
begin 
forever 
begin 
@ (reset);
@(posedge clk);
rst =1 ;
if( empty != 1)
$display("Error in empty flag");
@(posedge clk);
rst =0 ;
#1 ;
-> done_reset ;
end
end 

initial 
begin
# 5 -> reset ; 
end
 
initial begin 
#10 ->reset;
@(done_reset);
for(i=0;i<8;i=i+1)
begin 
@(posedge clk)
#1
in=0;
@(posedge clk)
#1
in=1;
end

for(j=0;j<8;j=j+1)
begin 
@(posedge clk)
#1
out=0;
@(posedge clk)
#1
out=1;
end
$stop ;
end
       
always @(posedge clk , posedge rst)
    begin
            if(rst)
            begin
              pcount_comp <= 3'b000;
              upstate_comp <= 2'b00;
            end
            else
              case(upstate_comp)
              2'b00: 
              begin
                if(in == 0) upstate_comp <= 2'b01;
              end
              
              2'b01: 
              begin
                if(in == 1) upstate_comp <= 2'b10;
              end
              
              2'b10:
              begin              
                if(in == 0) upstate_comp <= 2'b01 ;
                else upstate_comp <= 2'b00 ;
              end
              
              default:
                upstate_comp <= 2'b00 ;
                
            endcase
          end
            
            always @(posedge clk , posedge rst)
            begin
              if(rst)
              begin
                pcount_comp = 3'b000;
                dstate_comp = 2'b00;
              end
              else
              case(dstate_comp)
                2'b00: 
                begin
                  if(out == 0) dstate_comp <= 2'b01;
                end
              
                2'b01: 
                begin
                  if(out == 1) dstate_comp <= 2'b10;
                end
              
                2'b10:
                begin                
                if(out == 0) dstate_comp <= 2'b01 ;
                else dstate_comp <= 2'b00 ;                                
                end
                
                default:
                  dstate_comp <= 2'b00 ;  
                
            endcase
            end
            
            always @(posedge clk)
             begin
             
                if(upstate_comp == 2'b10 && dstate_comp == 2'b10) pcount_comp <= pcount_comp;
                                
                else if (upstate_comp == 2'b10 && pcount_comp != 3'b111 ) pcount_comp <= pcount_comp + 1;
                
                else if (dstate_comp == 2'b10 && pcount_comp != 3'b000 ) pcount_comp <= pcount_comp - 1;                 
             end

always @(posedge clk)
begin : count_check
 if (pcount_comp != pcount)         
$display ("counter have problem that expect value %d ,your value %d " , pcount_comp , pcount );
end

reg full_check; 
reg empty_check ; 

always @(posedge clk)
begin 
            if(rst)
            begin
                empty_check <= 1;
                full_check <= 0;
            end
else if(pcount_comp == 3'b000 )
            begin
                empty_check <= 1;
                full_check <= 0; 
            end    
        else if(pcount_comp == 3'b111 )
            begin
                empty_check <= 0;
                full_check <= 1;  
            end
        else  
            begin
                empty_check <= 0;
                full_check <= 0;
            end
end

always @(posedge clk)
begin : flags_check
 if (empty_check != empty)         
$display ("empty flag have problem that expect value %d ,your value %d " , empty_check , empty );
 else if (full_check != full)
$display ("full flag have problem that expect value %d ,your value %d " , full_check , full );
end

assign warning_check = ( (~(pcount_comp[0] || pcount_comp[1] || pcount_comp[2] || out)) | (pcount_comp[0] & pcount_comp[1] & pcount_comp[2] & (~in) ) );

always @(posedge clk)
begin : Tcount_check
if (Tcount ==2'b00 )
$display ("Tcount & Wtime is false becouse Tcount = 0 ");
end

endmodule

module SBqM_project (  in ,out, rst , clk ,Tcount , pcount ,Wtime , empty , full , warnning );
input in ,out, rst , clk ;
input[1:0] Tcount;
output [2:0] pcount ;
output [4:0] Wtime;
output reg empty , full ;
output warnning;
wire [4:0] index ;
 
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
/*
wire [119:0] data  = { 
                        Wtime10,Wtime11,Wtime12,Wtime13,Wtime14,Wtime15,Wtime16,Wtime17,
                        Wtime20,Wtime21,Wtime22,Wtime23,Wtime24,Wtime25,Wtime26,Wtime27,
                        Wtime30,Wtime31,Wtime32,Wtime33,Wtime34,Wtime35,Wtime36,Wtime37   }; 
// (8*3 number of cases ) * 5 bit of Wtime if bit memory
*/ 
reg [4:0] data  [23:0] ;// (8*3 number of cases )  if byte memory
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
end  //  if byte memory

 sequance_counter Pcount1(pcount,in,out,rst,clk);
 

assign index = {( Tcount - 2'b01 ) , pcount };
assign Wtime = data [index] ; // if bit memory

assign warning = ( (~(pcount[0] || pcount[1] || pcount[2] || out)) | (pcount[0] & pcount[1] & pcount[2] & (~in) ) );
            // warnning bit will equal 1 when pcount = 111 and ~in1 = 1 and            
            // warnning bit will equal 1 when pcount = 000 and out1 = 0


always@(posedge clk , posedge rst)
        begin
            if(rst==1)
            begin
                empty <= 1;
                full <= 0;
            end
            else if(pcount == 3'b000 )
            begin
                empty <= 1;
                full <= 0; 
            end    
        else if(pcount == 3'b111 )
            begin
                empty <= 0;
                full <= 1;  
            end
        else  
            begin
                empty <= 0;
                full <= 0;
            end
        end

/*         

                           -------imp equations in storing bit memory-------
//reg startbit ;
//reg endbit ;
startbit = index + ( index * 4 ) ;
endbit = index + ( ( index + 1 ) * 4 ) ; 
assign Wtime = data [endbit:startbit]  ;
if bit memory
*/ 
endmodule