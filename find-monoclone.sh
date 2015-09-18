##find monoclone by awk program
#head -3000 
cat ${fl} | awk '/^@/{print $0 > "monoalignment.sam"};!/^@/{
        cp=$3":"$4":"$8":"$6":"$9
        if(!frq[cp]){
            print $0 >> "monoalignment.sam"
            frq[cp] = 1
        } else {
            frq[cp]++
        }
    }
    END{
        for(cp in frq) if(frq[cp] > 1) print(cp, frq[cp]) > "mutifrq.txt"
    }'
