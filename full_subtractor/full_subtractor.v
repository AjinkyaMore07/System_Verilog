 module full_sub(input a,b,bin,output diff,borrowout);
   assign diff = a^b^bin;
   assign borrowout = ~a&b | ~a&bin | b&bin;
endmodule
