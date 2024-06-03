// Code your design here
module FSMD(
  input reg inizia, input reg[1:0] primo, input reg[1:0] secondo, input reg clk, 
  output reg[1:0] manche, output reg [1:0] partita);
  
  
  reg [2:0] state = 3'b000;
  reg [2:0] next_state = 3'b000;
  reg [2:0] startend = 3'b000;
  reg control;


  always @(posedge clk)
    begin: UPDATE
      state = next_state;
    end

  // START/END -> 000
  // NOADV -> 001
  // VPUG1 -> 010
  // VPUG2 -> 011
  // VPDG1 -> 100
  // VPDG2 -> 101
  // VPTG1 -> 110
  // VPTG2 -> 111

    reg obblig;
    reg [1:0] mv1;
    reg [1:0] mv2;
    reg [2:0] numero_manche;
    //reg calcola_manche;
    reg [4:0] nnm; //Not Modified Manche
    reg [4:0] conPrimo;
  	
  	// INIZIALIZZO 
	initial begin
      manche = 2'b00;
      partita = 2'b00;
    end

//ATTENZIONE!! QUESTA FSM HA QUALCHE MODIFICA RISPETTO AL GRAFICO CHE SERVE
  always @(state, inizia, control, manche, obblig) begin : FSM
    case(state)
      //parto da start//
      3'b000:
        if(control) begin
      	  next_state = state;
        end else begin
          partita = 2'b00;
          next_state = 3'b001; // NO ADV 
        end
      //parto da no adv//
      3'b001:
        if(~inizia && control == 1'b0 && (manche == 2'b00 || manche == 2'b11)) begin
          partita = 2'b00;
          next_state = state;
        end else if(~inizia && control == 1'b0 && manche==2'b01) begin
          partita = 2'b00;
          next_state = 3'b010;
        end else if(~inizia && control == 1'b0 && manche==2'b10) begin
          partita = 2'b00;
          next_state = 3'b011;
        end else if(control == 1'b1 || inizia == 1'b1) begin
          partita = 2'b11; 
          next_state = startend;
      	end
      //vantaggio g1//
      3'b010:
        if(~inizia && control == 1'b0 && (manche==2'b00 || manche == 2'b11)) begin
          partita = 2'b00;
          next_state = 3'b010;
        end else if(~inizia && control == 1'b0 && manche==2'b01 && obblig) begin
          partita = 2'b00;
          next_state = 3'b100;
        end else if(~inizia && control == 1'b0 && manche==2'b10) begin
          partita = 2'b00;
          next_state = 3'b001;
        end else if(~inizia && manche == 2'b01 && ~obblig) begin
          partita = 2'b01;
          next_state = startend;
        end else if(control == 1'b1 || inizia) begin
          partita = 2'b11;
          next_state = startend;
        end

       //vantaggio g2//
      	// Controllo = 1 se le partite sono 0
       3'b011:
         if(~inizia && control == 1'b0 && (manche==2'b00 || manche == 2'b11)) begin
           partita = 2'b00;
           next_state = state;
         end else if (~inizia && control == 1'b0 && manche==2'b01) begin
           partita = 2'b00;
           next_state = 3'b001;
         end else if (~inizia && control == 1'b0 && manche==2'b10 && obblig) begin
           partita = 2'b00;
           next_state = 3'b101;
         end else if(~inizia && manche == 2'b10 && ~obblig) begin
          partita = 2'b10; 
           next_state = startend; // WIN
         end else if(control == 1'b1 || inizia) begin
           partita = 2'b11;
          next_state = startend;
        end
        //vantaggio g1+1//
        3'b100:
          if(~inizia && control == 1'b0 && (manche==2'b00 || manche == 2'b11)) begin
            partita = 2'b00;
            next_state = state;
          end else if (~inizia && control == 1'b0 && manche==2'b01) begin
            partita = 2'b00;
            next_state = 3'b110;
          end else if (~inizia && control == 1'b0 && manche==2'b10) begin
            partita = 2'b00;
            next_state = 3'b010;
          end else if(~inizia && manche == 2'b01 && ~obblig) begin
            partita = 2'b01;
            next_state = startend;
          end else if(control == 1'b1 || inizia) begin
            partita = 2'b01;
            next_state = startend;
          end
      //vantaggio g2+1//
      3'b101:
        if(~inizia && control == 1'b0 && (manche==2'b00 || manche == 2'b11)) begin
             partita = 2'b00;
             next_state = state;
        end else if (~inizia && control == 1'b0 && manche==2'b01) begin
             partita = 2'b00;
             next_state = 3'b011;
        end else if (~inizia && control == 1'b0 && manche==2'b10) begin
             partita = 2'b00;
             next_state = 3'b111;
        end else if(~inizia && manche == 2'b10 && ~obblig) begin
            partita = 2'b10;
          next_state = startend;
        end else if(control == 1'b1 || inizia) begin
            partita = 2'b10;
            next_state = startend;
          end
      //vantaggio g1+2//
        3'b110:
          if(~inizia && control == 1'b0 && manche==2'b00) begin
              partita = 2'b00;
              next_state = state;
          end else if ((control == 1'b0 && (manche==2'b10 || manche == 2'b11 || manche == 2'b01)) || control == 1'b1 || inizia) begin
              partita = 2'b01;
            next_state = startend;
            end
        //vantaggio g2+2//
        3'b111:
          if(~inizia && control == 1'b0 && manche==2'b00) begin
              partita = 2'b00;
              next_state = startend;
          end else if ((control == 1'b0 && (manche==2'b10 || manche == 2'b11 || manche == 2'b01)) || control == 1'b1 || inizia) begin
              partita = 2'b10;
            	next_state = startend;
          end
    endcase
  end // END FSM

  
always @(posedge clk) begin: DATAPATH
		
   
    if(inizia) begin // QUANDO INIZIA = 1     
		
      // Inizializzo le manche
      manche = 2'b00;
      partita = 2'b00;
      
      mv1=2'b00;      mv2=2'b00;
      // primo = 10 -> 01000      secondo = 11 -> 00011
      // primo + secondo 01011 + 00100
      case(primo)
        2'b00:
          conPrimo = 5'b00000;
        2'b01:
          conPrimo = 5'b00001;
        2'b10:
          conPrimo = 5'b00010;
        2'b11:
          conPrimo = 5'b00011;
      endcase

      nnm = (conPrimo + secondo) + 5'b00100;
      numero_manche = (conPrimo + secondo) + 5'b00100;


    end else begin // QUANDO INIZIA = 0

        if(mv1 == primo || mv2 == secondo) begin //
            manche = 2'b00;
        end else begin

          case({primo, secondo})
          4'b1111, 4'b0101, 4'b1010: begin
            manche = 2'b11;
            mv1 = 2'b00;
            mv2 = 2'b00;
          end
          4'b0111, 4'b1001, 4'b1110: begin
            manche=2'b01;
            mv1 = primo;
            mv2 = 2'b00;
          end
          4'b1101, 4'b0110, 4'b1011: begin
            manche=2'b10;
            mv2=secondo;
            mv1=2'b00;
          end
            default:
            manche=2'b00;
          endcase
        end
	  
      // Se la manche è considerata valida, sottraggo 1
      if(manche != 2'b00) begin
        numero_manche = numero_manche - 5'b00001;
      end // invece se la manche non è valida allora rimane invariato

	  // se il valore delle manche iniziali-4 è maggiore del numero di manche attuali allora obblig sarà uguale a 1
      //nnm = manche all'inizio della partita
      // 7 - 4 = 3 -> 3 >= 7 obblig = 0 -> le partite minime sono superate
      if(numero_manche > (nnm - 5'b00100)) begin
        obblig = 1'b1;
      end else begin 
        obblig = 1'b0; 
      end

      if(numero_manche == 5'b00000) begin
        control = 1'b1;
      end else begin
        control = 1'b0;
      end

    end

end
	
  
    

endmodule
