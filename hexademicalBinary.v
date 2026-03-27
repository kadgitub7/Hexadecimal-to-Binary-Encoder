`timescale 1ns / 1ps

module hexademicalBinary(
    input zero,one,two,three,four,five,six,seven,eight,nine,a,b,c,d,e,f,
    output B3,
    output B2,
    output B1,
    output B0
    );
    
    assign B3 = eight | nine | a | b | c | d | e | f;
    assign B2 = four | five | six | seven | c | d | e | f;
    assign B1 = two | three | six | seven | a | b | e | f;
    assign B0 = one | three | five | seven | nine | b | d | f;

endmodule
