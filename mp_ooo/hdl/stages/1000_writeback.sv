module writeback

(
    //input from functional unit(s?)

    //output to prf, robert, 
    //output to arf?, would this be through ROB? i think so
    //output to reservation stations? or would that be through CPU
);

//maybe have this stage as part of funct units? 
//or just a queue coming out of the funct unit?
//could send func_unit_busy signal to res station based on enq to queue
//if its part of funct unit it would only be free after wb is done
//need to think about wb per funct unit vs one wb
//area vs only being able to wb one at a time

//need to be able to write to ROB from wb which i think can't be done rn
//add new prf ports? probably

//


endmodule : writeback