`timescale 1ns / 1ps

module hexademicalBinary_tb();
    reg zero,one,two,three,four,five,six,seven;
    reg eight,nine,a,b,c,d,e,f;
    
    wire B3,B2,B1,B0;
    
    hexadecimalBinary uut(zero,one,two,three,four,five,six,seven,
                  eight,nine,a,b,c,d,e,f,
                  B3,B2,B1,B0);
    
    task clear_inputs;
    begin
        zero = 0; one = 0; two = 0; three = 0; four = 0;
        five = 0; six = 0; seven = 0;
        eight = 0; nine = 0; a = 0; b = 0;
        c = 0; d = 0; e = 0; f = 0;
    end
    endtask
    
    initial begin
        clear_inputs; zero = 1;
        #10 $display("0 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; one = 1;
        #10 $display("1 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; two = 1;
        #10 $display("2 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; three = 1;
        #10 $display("3 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; four = 1;
        #10 $display("4 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; five = 1;
        #10 $display("5 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; six = 1;
        #10 $display("6 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; seven = 1;
        #10 $display("7 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; eight = 1;
        #10 $display("8 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; nine = 1;
        #10 $display("9 -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; a = 1;
        #10 $display("A -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; b = 1;
        #10 $display("B -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; c = 1;
        #10 $display("C -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; d = 1;
        #10 $display("D -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; e = 1;
        #10 $display("E -> %b%b%b%b", B3,B2,B1,B0);
    
        clear_inputs; f = 1;
        #10 $display("F -> %b%b%b%b", B3,B2,B1,B0);
    end
endmodule
