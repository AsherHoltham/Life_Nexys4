////////////////////////////////////////////////////////////
////////// Creators: Asher Holtham & Krishna Srikanth
////////// Creation date: sat. Apr 13 2024
////////// Design name: Game_of_Life_machine_top
////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Main_machine 
    (   
        clk,
        BtnL, BtnR, BtnU, BtnD, BtnC, 
        Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
        board_o, generation_cnt_o
	);


	/* INPUTS */
	input clk;
	input BtnL, BtnR, BtnU, BtnD, BtnC, Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;
	/* INPUTS */

	/* OUTPUTS */
    output reg[255:0] board_o;
    output reg[15:0] generation_cnt_o;
    /* OUTPUTS */ 

    /* INTERNAL SIGNALS */
    reg[31:0] internal_clock_counter;
    wire reset;
    reg[2:0] state;
    wire [15:0] cell_inputs;
    wire [255:0] board_alg;
    wire [255:0] board_set;
    wire [255:0] board_output;
    /* INTERNAL SIGNALS */

    /* ASSIGNMENT */
    assign reset = (BtnL || (state == 3'b000));
    assign cell_inputs = {Sw0, Sw1, Sw2, Sw3, Sw4, Sw5, Sw6, Sw7, Sw8, Sw9, Sw10, Sw11, Sw12, Sw13, Sw14, Sw15};    /* ASSIGNMENT */

    /* MODULES */
    array_transfer tran_(.clk(internal_clock_counter[17]), .reset(reset), .select(state), .board_setup(board_set), .board_alrogithm(board_alg), .board_output(board_output));
    set_up set_(.clk(internal_clock_counter[17]), .reset(reset), .select(state[0]), .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC), .cell_inputs(cell_inputs), .board_input(board_output), .board_output(board_set));
    algorithm algo_(.clk(internal_clock_counter[25]), .reset(reset), .select(state[1]), .board_input(board_output), .board_output(board_alg));
    /* MODULES */

    /* PARAMETERS */
    localparam
        SET	= 3'b001,
        ALG = 3'b010,
        STOP = 3'b100;
    /* PARAMETERS */

    initial 
        state = 3'b000;

    always @(posedge clk)
        internal_clock_counter <= internal_clock_counter + 1;
    
    always @(posedge internal_clock_counter[25], posedge reset) 
    begin
        if (reset) begin
            board_o <= 0;
            generation_cnt_o <= 0;
        end 
        else if(state == ALG) begin   
            board_o <= board_output;
            generation_cnt_o <= generation_cnt_o + 1; 
            
        end else if(state == SET) 
            board_o <= board_output; 
    end

    always @(posedge BtnR, posedge reset) 
    begin
        if(reset)
            state <= SET;
        else begin
            case(state)
                SET:
                    state <= ALG;
                ALG:
                    state <= STOP;
                STOP:
                    state <= ALG;
            endcase
        end
    end
endmodule