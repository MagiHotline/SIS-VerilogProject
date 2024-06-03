`timescale 1ns/1ps

module tb_FSMD(); 

    reg[1:0] primo;
    reg[1:0] secondo;
    reg inizia;
    reg clk;
	
    //OUTPUT
    reg [1:0] manche;
    reg [1:0] partita;

    FSMD c(inizia, primo, secondo, clk, manche, partita);
    integer tbf, outf; // file descriptor
    

    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);

        tbf = $fopen("testbench.script", "w");
        outf = $fopen("output_verilog.txt", "w");
        $fdisplay(tbf, "read_blif FSMD.blif");
	
      	#30 // Aspettare un po' di più
        
      	inizia = 1'b1;
        primo = 2'b00;
        secondo = 2'b11;

        #2

      $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);

      
      #18
      
      inizia = 1'b0;
      primo = 2'b01;
      secondo = 2'b11;

        #2

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
      
        #18
		
      	inizia = 1'b0;
        primo= 2'b11;
        secondo = 2'b11;

        #2 

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);

        #18 
		
      	inizia = 1'b0;
        primo= 2'b01;
        secondo = 2'b10;


      #2 

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
      	#18
      
      	inizia = 1'b0;
      	primo = 2'b10;
      	secondo = 2'b11;
      
     #2 

       $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
      	#18
      
      	inizia = 1'b0;
      	primo = 2'b11;
      	secondo = 2'b01;
      
    	#2 

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
        #18
      
        inizia = 1'b1;
      	primo = 2'b00;
      	secondo = 2'b00;
      
    	#2 

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
        #18
      
      
        inizia = 1'b0;
      	primo = 2'b01;
      	secondo = 2'b11;
      
    	#2 

       $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
        #18
      
      
        inizia = 1'b0;
      	primo = 2'b01;
      	secondo = 2'b11;
      
    	#2 

       $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
        #18
      
      inizia = 1'b0;
      	primo = 2'b11;
      	secondo = 2'b10;
      
    	#2 

       $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
        #18
      
        inizia = 1'b0;
      	primo = 2'b00;
      	secondo = 2'b10;
      
    	#2 

       $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
        #18
      
      	inizia = 1'b0;
      	primo = 2'b10;
      	secondo = 2'b01;
      
    	#2 

       $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
        #18
      
      
      	inizia = 1'b0;
      	primo = 2'b11;
      	secondo = 2'b11;
      
    	#2 

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
        #18
      	
    	inizia = 1'b1;
      	primo = 2'b00;
      	secondo = 2'b00;
      
      	#2 

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
      	#18
      	
      	inizia = 1'b0;
      	primo = 2'b01;
      	secondo = 2'b11;
      	
      	#2 

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
      
      	inizia = 1'b1;
      	primo = 2'b00;
      	secondo = 2'b00;
      	
      
      #20 // Aspettare qualche nanosecondo in più a causa di
      // INIZIA = 1

        $fdisplay(tbf, "simulate %b %b %b %b %b", inizia, primo[1], primo[0], secondo[1], secondo[0]);
        $fdisplay(outf, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      
      
      	// FINE
        $fdisplay(tbf, "quit");

        $fclose(tbf);
        $fclose(outf);
      
      
      	#50;
		$finish;
    end



endmodule
